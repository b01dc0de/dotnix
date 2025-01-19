{ config, pkgs, ... }:

{
    programs.home-manager.enable = true;
    home.stateVersion = "25.05";
    home.username = "cka";
    home.homeDirectory = "/home/cka";

    home.file."wallpaper.jpg".source = pkgs.fetchurl {
        url = "https://unsplash.com/photos/S3m8eOFRxOY/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8MjB8fGJydXRhbGlzdCUyMGFyY2hpdGVjdHVyZXxlbnwwfHx8fDE3MzQ5MjM5OTN8MA&force=true";
        hash = "sha256-aEqzbPgj1e3R1HTkPzYgzAUPplkKbXnMfY5EurKXfd8=";
    };


    xresources.properties = {
        "Xft.dpi" = 144;
    };

    home.packages = with pkgs; [
    ];
}
