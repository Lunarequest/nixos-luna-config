{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # sexy lix shizz
    lix = {
      url = "git+https://git@git.lix.systems/lix-project/lix?ref=refs/tags/2.90-beta.1";
      flake = false;
    };
    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module";
      inputs.lix.follows = "lix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    lix,
    lix-module,
    ...
  } @ attrs: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations.Lifrith = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./hosts/lifrith/configuration.nix
        lix-module.nixosModules.default
      ];
    };
    homeConfigurations = {
      "luna@Lifrith" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./home/lunarequest/lifrith.nix
          {
            home = {
              username = "luna";
              homeDirectory = "/home/luna";
              stateVersion = "24.05";
            };
          }
        ];
      };
    };
  };
}
