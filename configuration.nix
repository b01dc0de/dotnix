{ config, pkgs, lib, ... }:

{
  # Define NixOS version:
  system.stateVersion = "25.11";

  # Enable flakes:
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable automatic garbage collection:
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;

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
    options = "ctrl:nocaps";
  };
  console.useXkbConfig = true;
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
    wireplumber.enable = true;
  };

  # Polkit:
  security.polkit.enable = true;

  # GPU:
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

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
  programs.hyprland.xwayland.enable = true;
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
  environment.variables = rec {
    NIXCFG = "$HOME/dotnix";
    FLAKE = "${NIXCFG}";
    # XDG Base Directory spec:
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    # Not in XDG spec:
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [ "${XDG_BIN_HOME}" ];
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Fonts:
  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" "DejaVu Serif" ];
	sansSerif = [ "Noto Sans" "DejaVu Sans" ];
	monospace = [ "Hack" "DejaVu Sans Mono" ];
      };
    };
    fontDir.enable = true;
    packages = with pkgs; [
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
  };

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
  programs.nh.enable = true;

  # Chromium:
  programs.chromium = {
    enable = true;
    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
      "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
    ];
  };

  # Neovim:
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Pkgs:
  environment.systemPackages = with pkgs; [
    arc-theme
    arc-icon-theme
    alacritty
    busybox
    catppuccin
    catppuccin-cursors
    chromium
    cliphist
    curl
    discord
    emacs
    fastfetch
    floorp
    efibootmgr
    galculator
    gimp
    gitFull
    github-desktop
    hyprpaper
    hyprpolkitagent
    hyprsunset
    kitty
    libreoffice-fresh
    lxappearance
    neovide
    obsidian
    pavucontrol
    playerctl
    spotify
    vscode-fhs
    waybar
    wl-clipboard
    wget
    xclip

    # Development-related:
    libclang
  ];
}
