{ config, lib, pkgs, ... }:

{
    config = {
        programs.gamemode.enable = true;
        programs.steam.enable = true;
	programs.steam.gamescopeSession.enable = true;

	environment.systemPackages = with pkgs; [
	    mangohud
	    prismlauncher
	    protonup
	];
    };
}
