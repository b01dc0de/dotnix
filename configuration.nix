{ config, pkgs, lib, ... }:

{
  # Define NixOS version:
  system.stateVersion = "25.11";

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
  # NOTE: If grub.theme is set, that isn't affected by grub.font, etc.
  #boot.loader.grub.fontSize = 24;
  #boot.loader.grub.font = "${pkgs.nerd-fonts.hack}/share/fonts/truetype/NerdFonts/Hack/HackNerdFont-Regular.ttf";
  boot.loader.grub.theme = "${pkgs.catppuccin-grub}";

  # Networking:
  networking.hostName = lib.mkDefault "unnamed";
  networking.networkmanager.enable = true;

  # Bluetooth:
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

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
  # libinput:
  services.libinput.mouse.disableWhileTyping = true;

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

  # Polkit:
  security.polkit.enable = true;

  # GPU:
  hardware.graphics.enable = true;

  # Default session:
  #services.displayManager.defaultSession = "none+i3";

  # X11:
  services.xserver.enable = true;

  # KDE Plasma:
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.theme = "${pkgs.catppuccin-sddm}/share/sddm/themes/catppuccin-mocha";
  services.desktopManager.plasma6.enable = true;

  # i3:
  services.xserver.windowManager.i3 = {
    enable = true;
    configFile = ./i3/config;
    extraPackages = with pkgs; [
      autotiling
      dex
      dunst
      feh
      i3blocks
      i3status
      picom
      rofi
    ];
  };
  programs.i3lock.enable = true;
  programs.i3lock.package = pkgs.i3lock-blur;

  # Hyprland:
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
  #services.hypridle.enable = true;
  #programs.hyprlock.enable = true;
  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors = {
    # Using example config from nixos options:
    hyprland = {
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/Hyprland";
    };
  };

  # Environment:
  environment.pathsToLink = [ "/libexec" ];

  # Fonts:
  fonts.enableDefaultPackages = true;
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.blex-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    nerd-fonts.sauce-code-pro
    nerd-fonts.symbols-only
    nerd-fonts.terminess-ttf
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
    nerd-fonts.ubuntu-sans
  ];

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
  programs.nh.enable = true;

  # Pkgs:
  environment.systemPackages = with pkgs; [
    alacritty
    busybox
    catppuccin
    chromium
    fastfetch
    efibootmgr
    gitFull
    github-desktop
    kitty # Used by default Hyprland config
    lxappearance
    neovide
    obsidian
    spotify
    vscode-fhs
    xclip

    # Development-related:
    libclang
  ];
}
