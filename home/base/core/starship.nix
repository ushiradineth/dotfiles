{lib, ...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = lib.concatStrings [
        "$sudo"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$character"
      ];
      right_format = lib.concatStrings [
        "$cmd_duration"
        "$terraform"
      ];
      directory = {
        truncation_length = 255;
        truncate_to_repo = false;
        use_logical_path = false;
        style = "blue";
      };
      git_branch = {
        format = "[$branch]($style)";
        style = "bright-black";
      };
      git_status = {
        format = "[*]($style)[$ahead$diverged$behind](yellow) ";
        style = "bright-black";
        ahead = "⇡$\{count\}";
        diverged = "⇡$\{ahead_count\}⇣$\{behind_count\}";
        behind = "⇣$\{count\}";
      };
      cmd_duration = {
        format = " [$duration]($style)";
        style = "yellow";
      };
      terraform = {
        format = " [$workspace]($style)";
      };
    };
  };
}