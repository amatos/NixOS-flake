{ username, ... }:
{
  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
  };
  system.primaryUser = username;

  nix.settings.trusted-users = [ username ];
}
