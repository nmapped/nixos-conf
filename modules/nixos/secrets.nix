let
  nmapped = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFSa7MXHnwGLiv4W+AGRgnq+xHQBY21fowXwqYEpj21T";
  users = [ nmapped ];
in
{
  "nmapped-nixpass.age".publicKeys = [ nmapped ];
  age = {
    secrets = {
      nmapped-nixpass = {
        file = ./secrets/nmapped-nixpass.age;
        owner = "nmapped";
      };
    };
  };
}
