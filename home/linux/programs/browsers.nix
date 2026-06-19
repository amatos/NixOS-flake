{
  username,
  ...
}:
{
  programs = {
    firefox = {
      enable = true;
      profiles.${username} = { };
    };
  };
}
