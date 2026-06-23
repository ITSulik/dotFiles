{ pkgs, ... }:

{
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
    extraGroups = [ "networkmanager" "wheel" "video" ];
    shell = pkgs.fish;
  };

  # Basic low-level utilities 
  environment.systemPackages = with pkgs; [
    git
    curl
    pavucontrol
    uwsm
  ];

  system.stateVersion = "26.05";
}
