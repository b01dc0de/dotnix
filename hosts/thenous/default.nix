{ config, pkgs, lib, ... }:

{
    imports = [
        ./hardware-configuration.nix
	../../configuration.nix
    ];

    networking.hostName = lib.mkForce "thenous";

    # Nvidia:
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
        modesetting.enable = true;
	prime = {
            offload.enable = true;
            offload.enableOffloadCmd = true;
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
	};
	open = false;
    };
}
