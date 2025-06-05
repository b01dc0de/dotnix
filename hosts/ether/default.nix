{ config, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../configuration.nix
    ];

    # Hostname:
    networking.hostName = lib.mkForce "ether";
}
