{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.carpinera = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ifTheyExist [
      "audio"
      #"deluge"
      #"docker"
      "git"
      #"i2c"
      #"libvirtd"
      #"lxd"
      #"minecraft"
      #"mysql"
      #"network"
      #"plugdev"
      #"podman"
      #"tss"
      "video"
      "wheel"
      #"wireshark"

      "networkmanager"
      "sudo"
      "libvirtd"
    ];

    # Initial password for your user, skip setting a root password by passing '--no-root-passwd' to nixos-install
    # Be sure to change it (using passwd) after rebooting!
    # initialPassword = "nixos";
    # hashed password "nixos"
    hashedPassword = "$y$j9T$lvXAjw6Igk6ncFj9mwG5t1$PjzBovVCANq3hknwG8WBqlEkAfXOVgy7/AxY8/mJRZC";

    #openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/gabriel/ssh.pub);
    openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/carpinera/ssh.pub);
    #hashedPasswordFile = config.sops.secrets.gabriel-password.path;
    packages = [pkgs.home-manager];
  };

/*
  sops.secrets.gabriel-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };
*/

  home-manager.users.carpinera = import ../../../../home/carpinera/${config.networking.hostName}.nix;

/*
  security.pam.services = {
    swaylock = {};
    hyprlock = {};
  };
*/

  services.xserver.xkb = {
    layout = "it";
    variant = "";
  };
}
