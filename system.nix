{ pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Minimal fileSystems for `nix flake check` to pass
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  networking.hostName = "soul";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;
  time.timeZone = "UTC";

  # Enable the Hyprland Compositor & Audio
  programs.hyprland.enable = true;
  security.polkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.fish.enable = true;

  users.users.soul = {
    isNormalUser = true;
    description = "soul";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
    ];
    shell = pkgs.fish;
  };

  # Basic low-level utilities
  environment.systemPackages = with pkgs; [
    git
    curl
    pavucontrol
    uwsm
    inputs.caelestia.packages.${pkgs.system}.default
  ];

  system.stateVersion = "26.05";
}
