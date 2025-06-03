{
  description = "b01dc0de/dotnix NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations =
    let
      default = rec {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.cka = import ./home.nix;
            home-manager.backupFileExtension = "hm-backup";
          }
        ];
      };
    in
    {
      canon = nixpkgs.lib.nixosSystem {
        system = default.system;
        modules = [ ./hosts/canon ] ++ default.modules;
      };
      ether = nixpkgs.lib.nixosSystem {
        system = default.system;
        modules = [ ./hosts/ether ] ++ default.modules;
      };
      primus = nixpkgs.lib.nixosSystem {
        system = default.system;
        modules = [
          ./hosts/primus
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.cka = import ./hosts/primus/home.nix;
            home-manager.backupFileExtension = "hm-backup";
          }
        ];
      };
      thenous = nixpkgs.lib.nixosSystem {
        system = default.system;
        modules = [ ./hosts/thenous ] ++ default.modules;
      };
    };
  };
}
