{ config, pkgs, ... }:

{
    programs.home-manager.enable = true;
    home.stateVersion = "25.05";
    home.username = "cka";
    home.homeDirectory = "/home/cka";

    home.file."wallpaper.jpg".source = pkgs.fetchurl {
        url = "https://unsplash.com/photos/gSF2C2cuI34/download?ixid=M3wxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNzM3MzIxMTY1fA&force=true";
        hash = "sha256-IqBooFkxc4cOXC9Ufenp+SvtfHDautTyOdg+Q20tZ6w=";
    };

    # Hyprland:
    wayland.windowManager.hyprland = {
        enable = true;
        extraConfig = "source = ~/dotnix/hypr/hyprland.conf";
    };

    programs.bash = {
    	enable = true;
	enableCompletion = true;
	bashrcExtra = "eval \"$(direnv hook bash)\"";
	initExtra = "fastfetch";
    };
    programs.direnv = {
    	enable = true;
	enableBashIntegration = true;
	nix-direnv.enable = true;
    };


    xresources.properties = {
        "Xft.dpi" = 144;
    };

    home.packages = with pkgs; [
    ];
}
