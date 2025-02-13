
{ lib
, stdenv
, fetchzip
, nodejs
, electron
, makeWrapper
, makeDesktopItem
, pkg-config
, python3
}:

stdenv.mkDerivation rec {
  pname = "edex-ui";
  version = "2.2.8";

  src = fetchzip {
    url = "https://github.com/GitSquared/edex-ui/archive/refs/tags/v${version}.zip";
    sha256 = "sha256-FReLe28pqz5D8yQfGyUWImOmwk5Ux2aeiex30IBO0mI=";  # This is intentionally wrong
  };

  nativeBuildInputs = [
    nodejs
    makeWrapper
    pkg-config
    python3
  ];

  buildInputs = [
    electron
  ];

  npmFlags = [ "--cache" "$TMPDIR/npm-cache" ];

  buildPhase = ''
    runHook preBuild

    export HOME=$TMPDIR
    export npm_config_cache=$TMPDIR/.npm
    export npm_config_nodedir=${nodejs}
    npm install --legacy-peer-deps $npmFlags
    npm run build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/applications
    cp -r dist $out/share/edex-ui

    makeWrapper ${electron}/bin/electron $out/bin/edex-ui \
      --add-flags "$out/share/edex-ui" \
      --prefix PATH : ${lib.makeBinPath [ nodejs ]}

    cp ${makeDesktopItem {
      name = "edex-ui";
      exec = "edex-ui";
      icon = "edex-ui";
      desktopName = "eDEX-UI";
      genericName = "System Monitor";
      categories = [ "System" "TerminalEmulator" ];
    }}/share/applications/* $out/share/applications/

    runHook postInstall
  '';

  meta = with lib; {
    description = "A cross-platform, customizable science fiction terminal emulator with advanced monitoring & touchscreen support";
    homepage = "https://github.com/GitSquared/edex-ui";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ ];
  };
}
