{
  pkgs,
  ...
}:
{
  programs.tealdeer = {
    enable = true;
    settings = {
      updates = {
        auto_update = true; # Automatically check for updates
        auto_update_interval_hours = 24;
      };
      display = {
        compact = false; # Set to true to view less whitespace
        color = "auto"; # Valid values: "always", "auto", "never"
      };
    };
  };
}
