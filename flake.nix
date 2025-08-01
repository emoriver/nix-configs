{
  description = "Configurazione di partenza usando il boilerplate di Misterio77 Standard";

  /*
  
  1. installare qualche applicazione con home-manager
  2. aggiungere altri host
  3. aggiungere altri utenti
  4. lavorare con le password
  5. lavorare con i dotfiles sotto home-manager
  6. implementare l'impermanenza
  7. aggiungere pacchetti personalizzati
  8. lavorare con overlays
  9. lavorare con i moduli di nixos
  10. lavorare con i moduli di home-manager
  
  */

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    home-manager = {      
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # Lenovo Workstation W541 for virtualization
      w541onnixos = nixpkgs.lib.nixosSystem {
        modules = [./hosts/w541onnixos];
        specialArgs = {inherit inputs outputs;};
      };
      # First NixOS distro under WSL on Mac Pro trashcan
      nixoswsl1mp = nixpkgs.lib.nixosSystem {
        modules = [./hosts/nixoswsl1mp];
        specialArgs = {inherit inputs outputs;};
      };
      # Lenovo T480 - 1 of 2 - for virtualization
      t4801onnixos = nixpkgs.lib.nixosSystem {
        modules = [./hosts/t4801onnixos];
        specialArgs = {inherit inputs outputs;};
      };
    };
  };
}
