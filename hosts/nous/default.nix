{ config, pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
	../../configuration.nix
    ];

    networking.hostName = lib.mkForce "nous";
}
