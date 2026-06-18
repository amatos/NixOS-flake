{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    # misc
    libnotify
    wineWow64Packages.wayland
    xdg-utils
    graphviz
  ];

  programs = {

  };

  services = {
    syncthing.enable = true;

    # auto mount usb drives
    udiskie.enable = true;
  };
}
