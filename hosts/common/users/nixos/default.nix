{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.nixos = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ifTheyExist [
      #"audio" on WSL??
      "git"
      "video"
      "wheel"
      "sudo"
    ];

    # Initial password for your user, skip setting a root password by passing '--no-root-passwd' to nixos-install
    # Be sure to change it (using passwd) after rebooting!
    # initialPassword = "nixos";
    # hashed password "nixos"
    hashedPassword = "$y$j9T$lvXAjw6Igk6ncFj9mwG5t1$PjzBovVCANq3hknwG8WBqlEkAfXOVgy7/AxY8/mJRZC";
  
    openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/nixos/ssh.pub);

    packages = [pkgs.home-manager];
  };

  home-manager.users.nixos = import ../../../../home/nixos/${config.networking.hostName}.nix;

  services.xserver.xkb = {
    layout = "it";
    variant = "";
  };
}
