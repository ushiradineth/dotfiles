{
  mylib,
  myvars,
  ...
}: {
  home = {
    homeDirectory = "/Users/${myvars.username}";

    # Don't show the "Last login" message for every new terminal.
    file.".hushlogin" = {
      text = "";
    };

    file.".gitignore_global" = {
      text = ''
        ~*
        .DS_Store
      '';
    };
  };
  imports =
    (mylib.scanPaths ./.)
    ++ [
      ../base/core
      ../base/tui
      ../base/home.nix
    ];
}
