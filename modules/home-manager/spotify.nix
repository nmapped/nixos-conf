{ pkgs, ... }:

{
  home.file.".config/spotify-player/app.toml" = {
    text = ''
      theme = "dracula"
      client_id = "c91973201a91462cb48de8ce5dee459d"
      client_port = 8080
      login_redirect_uri = "http://127.0.0.1:8989/login"
      playback_format = """
      {status} {track} • {artists}
      {album}
      {metadata}"""
      notify_timeout_in_secs = 0
      tracks_playback_limit = 50
      app_refresh_duration_in_ms = 32
      playback_refresh_duration_in_ms = 0
      page_size_in_rows = 20
      play_icon = "▶"
      pause_icon = "󰏤"
      liked_icon = ""
      border_type = "Plain"
      progress_bar_type = "Rectangle"
      cover_img_length = 10
      cover_img_width = 5
      cover_img_scale = 1.0
      enable_media_control = true
      enable_streaming = "Always"
      enable_notify = true
      enable_cover_image_cache = true
      default_device = "spotify-player"
      notify_streaming_only = false
      seek_duration_secs = 5

      [notify_format]
      summary = "{track} • {artists}"
      body = "{album}"

      [layout]
      playback_window_position = "Top"
      playback_window_height = 6

      [layout.library]
      playlist_percent = 40
      album_percent = 40

      [device]
      name = "archangel-tui"
      device_type = "speaker"
      volume = 70
      bitrate = 320
      audio_cache = true
      normalization = false
      autoplay = false
    '';
    recursive = true;
  };
}
