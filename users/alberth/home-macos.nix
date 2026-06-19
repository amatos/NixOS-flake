{
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
    ../../home/macos
  ];

  programs.fish.enable = true;
  programs.zsh.enable = true;

  programs.git = {
    settings.user.name = "${userName}";
    settings.user.email = "${userEmail}";
  };
}
