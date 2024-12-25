{
  # NOTE: the args not used in this file CAN NOT be removed!
  # because haumea pass argument lazily,
  # and these arguments are used in the functions like `mylib.nixosSystem`, `mylib.colmenaSystem`, etc.
  inputs,
  lib,
  mylib,
  myvars,
  system,
  genSpecialArgs,
  ...
} @ args: let
  name = "shu";

  modules = {
    darwin-modules = map mylib.relativeToRoot [
      "modules/darwin"
      "modules/core"
      "modules/base.nix"
      "hosts/${name}"
    ];
    home-modules = map mylib.relativeToRoot [
      "home/darwin/default.nix"
    ];
  };

  systemArgs = modules // args;
in {
  # macOS's configuration
  darwinConfigurations.${name} = mylib.macosSystem systemArgs;
}
