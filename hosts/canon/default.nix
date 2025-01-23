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
}
