{ config, pkgs, lib, ... }:

{
    imports = [
        ../../home.nix
    ];

    xresources.properties = lib.mkForce {
        "Xft.dpi" = 192;
    };

}
