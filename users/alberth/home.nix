{pkgs, userName, userEmail, ...}: {
  ##################################################################################################################
  #
  # Home Manager Configuration
  #
  ##################################################################################################################

  imports = [
    ../../home/core.nix
    ../../home/fcitx5
    ../../home/i3
    ../../home/programs
    ../../home/rofi
    ../../home/shell
  ];

  programs.git = {
    settings.user.name = "${userName}";
    settings.user.email = "${userEmail}";
  };
}
