{
  age = {
    secrets = {
      secret1 = {
        file = ../../secrets/secret1.age;
        owner = "nmapped";
      };
      nmapped-nixpass = {
        file = ../../secrets/nmapped-nixpass.age;
        owner = "nmapped";
      };
    };
  };
}
