{
  description = "shuflake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = [
        # Tools
        pkgs.neovim
        pkgs.git
        pkgs.htop
        pkgs.lazygit
        pkgs.openssh
        pkgs.bat
        pkgs.curl
        pkgs.eza
        pkgs.fd
        pkgs.fzf
        pkgs.neofetch
        pkgs.tree
        pkgs.ripgrep
        pkgs.stow
        pkgs.pgcli
        pkgs.zoxide
        pkgs.speedtest-cli
        pkgs.yj
        pkgs.yq
        pkgs.gh

        # Kubernetes & Containerization
        pkgs.k9s
        pkgs.kind
        pkgs.kubernetes-helm
        pkgs.kubectl
        pkgs.kubectx
        pkgs.minikube
        pkgs.qemu

        # Shell & Terminal enhancements
        pkgs.zsh
        pkgs.zsh-autosuggestions
        pkgs.zsh-syntax-highlighting
        pkgs.zsh-powerlevel10k
        pkgs.mkalias
        pkgs.zplug
        pkgs.zoxide
        pkgs.delta

        # Programming languages
        pkgs.lua
        pkgs.python39
        pkgs.ansible
        pkgs.go
        pkgs.gcc
        pkgs.jdk17
        pkgs.maven
        pkgs.nodejs_22

        # Version managers
        pkgs.nodenv
        pkgs.pyenv
        pkgs.pnpm
        pkgs.yarn

        # Cloud tools
        pkgs.awscli2
        pkgs.azure-cli
        pkgs.ngrok
      ];

      fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "Meslo" ]; }) ];

      homebrew = {
        enable = true;
        brews = [
          "go-task"
          "terraform"
          "tflint"
          "luajit"
          "stow"
        ];
        casks = [
          "arc"
          "discord"
          "hiddenbar"
          "intellij-idea-ce"
          "docker"
          "blackhole-16ch"
          "whatsapp"
          "oversight"
          "notion"
          "notion-calendar"
          "figma"
          "raycast"
          "rectangle"
          "monitorcontrol"
          "bitwarden"
          "burp-suite"
          "wezterm"
        ];
        masApps = {
          "Horo" = 1437226581;
          "Davinci Resolve" = 571213070;
        };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
        '';

      system.defaults = {
        dock = {
          autohide = true;
          autohide-delay = 0.01;
          autohide-time-modifier = 0.01;
          show-recents = false;
          magnification = false;
          orientation = "right";
          persistent-apps = [
            "${pkgs.arc-browser}/Applications/Arc.app"
            "Applications/WezTerm.app"
            "/Applications/Notion.app"
            "/Applications/Notion Calendar.app"
          ];
          tilesize = 32;
        };

        finder = {
          AppleShowAllExtensions = true;
          AppleShowAllFiles = true;
          CreateDesktop = false;
          FXDefaultSearchScope = "SCcf";
          FXEnableExtensionChangeWarning = false;
          FXPreferredViewStyle = "clmv";
          QuitMenuItem = true;
          ShowPathbar = true;
          ShowStatusBar = true;
        };

        loginwindow.GuestEnabled = false;

        NSGlobalDomain = {
          AppleICUForce24HourTime = true;
          AppleInterfaceStyle = "Dark";
          AppleShowScrollBars = "Always";
          KeyRepeat = 2;
        };

        trackpad = {
          ActuationStrength = 0;
          Clicking = true;
          TrackpadRightClick = true;
          TrackpadThreeFingerDrag = true;
        };
      };

      time.timeZone = "Asia/Dubai";

      services.nix-daemon.enable = true;
      nix.settings.experimental-features = "nix-command flakes";
      programs.zsh.enable = true;
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;

      programs.nix-index.enable = true;
      security.pam.enableSudoTouchIdAuth = true;
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    darwinConfigurations."m2" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "shu";
            autoMigrate = true;
          };
        }
      ];
    };

    darwinPackages = self.darwinConfigurations."m2".pkgs;
  };
}
