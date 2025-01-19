{ config, pkgs, ... }:

{
    programs.home-manager.enable = true;
    home.stateVersion = "25.05";
    home.username = "cka";
    home.homeDirectory = "/home/cka";

    xresources.properties = {
        "Xft.dpi" = 172;
    };

    home.packages = with pkgs; [

    ];
}
