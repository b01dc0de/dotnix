{ config, pkgs, lib, ... }:

{
    programs.home-manager.enable = true;
    home.stateVersion = "25.11";
    home.username = "cka";
    home.homeDirectory = "/home/cka";

    home.file."wallpaper.jpg".source = pkgs.fetchurl {
        url = "https://unsplash.com/photos/gSF2C2cuI34/download?ixid=M3wxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNzM3MzIxMTY1fA&force=true";
        hash = "sha256-IqBooFkxc4cOXC9Ufenp+SvtfHDautTyOdg+Q20tZ6w=";
    };

    xresources.properties = {
        "Xft.dpi" = 144;
    };

    home.packages = with pkgs; [ ];

    # Bash:
    programs.bash = {
    	enable = true;
	enableCompletion = true;
	bashrcExtra = "eval \"$(direnv hook bash)\"";
	initExtra = ''fastfetch'';
    };

    # Direnv:
    programs.direnv = {
    	enable = true;
	enableBashIntegration = true;
	nix-direnv.enable = true;
    };

    # Hyprland:
    wayland.windowManager.hyprland = {
        enable = true;
        extraConfig = lib.fileContents ./cfg/hypr/hyprland.conf;
    };

    # Kitty:
    programs.kitty = {
        enable = true;
	font = {
	    name = "JetBrainsMono Nerd Font Mono";
	    size = 16;
	};
	settings = {
            dynamic_background_opacity = true;
            enable_audio_bell = false;
            background_opacity = "0.9";
            background_blur = 1;
	};
	themeFile = "Catppuccin-Mocha";
    };

    # Neovim:
    programs.neovim = {
        enable = true;
	extraConfig = lib.fileContents ./cfg/nvim/init.vim;
	plugins = with pkgs.vimPlugins; [
	    catppuccin-nvim
	    lualine-nvim
	    nord-vim
	    nvim-lspconfig
	    nvim-treesitter.withAllGrammars
	    telescope-nvim
	];
	viAlias = true;
	vimAlias = true;
	vimdiffAlias = true;
    };

    # Oh-my-posh:
    programs.oh-my-posh = {
	enable = true;
        enableBashIntegration = true;
	useTheme = "catppuccin";
    };
}
