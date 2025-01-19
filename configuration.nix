{ config, pkgs, lib, ... }:

{
  # Define NixOS version:
  system.stateVersion = "25.05";

  # Enable flakes:
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader:
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.configurationLimit = 16;
  boot.loader.grub.default = "saved";
  boot.loader.grub.useOSProber = true;

  # Networking:
  networking.hostName = lib.mkDefault "unnamed";
  networking.networkmanager.enable = true;

  # Timezone / Locale:
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Keymap:
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Printing support:
  services.printing.enable = true;

  # Sound:
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # GPU:
  hardware.graphics.enable = true;

  # X11:
  services.xserver.enable = true;

  # KDE Plasma:
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Users:
  users.users.cka = {
    isNormalUser = true;
    description = "CKA";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Allow unfree packages:
  nixpkgs.config.allowUnfree = true;

  # Program configuration:
  programs.firefox.enable = true;
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;

  # Pkgs:
  environment.systemPackages = with pkgs; [
    alacritty
    gitFull
    github-desktop
  ];
}
