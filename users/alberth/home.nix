{
  pkgs,
  userName,
  userEmail,
  ...
}:
{
  ##################################################################################################################
  #
  # Home Manager Configuration
  #
  ##################################################################################################################

  imports = [
    ../../home/common
    ../../home/linux/fcitx5
    ../../home/linux/i3
    ../../home/linux/programs
    ../../home/linux/rofi
  ];

  programs.fish.enable = true;
  programs.zsh.enable = true;

  programs.git = {
    settings.user.name = "${userName}";
    settings.user.email = "${userEmail}";
  };
}
