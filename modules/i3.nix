{pkgs, ...}: {
  # i3 related options
  environment.pathsToLink = ["/libexec"]; # links /libexec from derivations to /run/current-system/sw
  services.displayManager.defaultSession = "none+i3";
  services.displayManager = {
    gdm.enable = true;
  };

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi # application launcher, the same as dmenu
        dunst # notification daemon
        i3blocks # status bar
        i3lock # default i3 screen locker
        xautolock # lock screen after some time
        i3status # provide information to i3bar
        i3
        picom # transparency and shadows
        feh # set wallpaper
        acpi # battery information
        arandr # screen layout manager
        dex # autostart applications
        xbindkeys # bind keys to commands
        xbacklight # control screen brightness
        xdpyinfo # get screen information
        sysstat # get system information
        # minimal screen capture tool, used by i3 blur lock to take a screenshot
        # print screen key is also bound to this tool in i3 config
        scrot
        thunar # xfce4's file manager
      ];
    };

    # Configure keymap in X11
    xkb.layout = "us";
  };

  programs.dconf.enable = true;

  # thunar file manager(part of xfce) related options
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  services.xrdp = {
    enable = true;
    openFirewall = true;
  };
}
