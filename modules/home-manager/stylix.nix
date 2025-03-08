{ pkgs, ... }:

{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    image = ../../assets/water-gate.jpg;

    targets.dunst.settings = {
      global = {
        frame_color = "#81a1c1";
      };

      urgency_low = {
        frame_color = "81a1c1";
      };

      urgency_normal = {
        frame_color = "81a1c1";
      };

      urgency_critical = {
        frame_color = "81a1c1";
      };
    };
  };
}
