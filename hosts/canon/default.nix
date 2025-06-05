{ config, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../configuration.nix
    ];

    # Hostname:
    networking.hostName = lib.mkForce "canon";

    # AMD GPU:
    services.xserver.videoDrivers = [ "amdgpu" ];

    # Enable the Pantheon Desktop Environment.
    #services.xserver.displayManager.lightdm.enable = true;
    services.displayManager.defaultSession = lib.mkForce "pantheon";
    services.xserver.desktopManager.pantheon.enable = lib.mkForce true;
}
