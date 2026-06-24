{
  lib,
  pkgs,
  inputs,
  ...
}:

{

  home.username = "soul";
  home.homeDirectory = "/home/soul";

  programs.caelestia = {
    enable = true;
    cli.enable = true;
  };

  # Daily Apps & Core CLI Suite
  home.packages = [
    inputs.zen-browser.packages.${pkgs.system}.default

    pkgs.fastfetch
    pkgs.btop
    pkgs.micro
    pkgs.starship
    pkgs.eza
    pkgs.zoxide
    pkgs.direnv
    pkgs.trash-cli
    pkgs.jq
    pkgs.lazygit
    pkgs.bat
    pkgs.ripgrep
    pkgs.wl-clipboard
    pkgs.cliphist
    pkgs.hyprpicker
    pkgs.thunar

    # Design System Fonts
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-color-emoji
  ];

  programs.vscode = {
    enable = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if not test -f "$HOME/.local/state/caelestia/scheme.json"
          caelestia scheme set -n caelestia
      end
    '';
  };

  # Mandatory activation script hook for Caelestia daemon logic
  home.activation = {
    caelestiaDaemonStart = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      # Triggers daemon safely if not already running under active generation
      $DRY_RUN_CMD caelestia shell -d >/dev/null || true
    '';
  };

  home.stateVersion = "26.05";
}
