{
  disko.devices = {
    disk = {
      disk1 = {
        type = "disk";
        device = "/dev/sda___________";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "nofail" ];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
      disk2 = {
        type = "disk";
        device = "/dev/sdb___________";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot-fallback";
                mountOptions = [ "nofail" ];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        mode = "mirror";
        rootFsOptions = {
          acltype = "posixacl";
          canmount = "off";
          dnodesize = "auto";
          normalization = "formD";
          relatime = "on";
          xattr = "sa";
          mountpoint = "none";
          #"com.sun:auto-snapshot" = "true";
        };
        options = {
          ashift = "12";
          #only for SSD
          #autotrim = "on";
        };
        datasets = {
          "root" = {
            type = "zfs_fs";
            mountpoint = "/";
          };
          "root/nix" = {
            type = "zfs_fs";
            options.mountpoint = "/root/nix";
            mountpoint = "/nix";
          };
          "root/home" = {
            type = "zfs_fs";
            options.mountpoint = "/root/home";
            mountpoint = "/home";
          };
        
          #to investigate and understand
          # README MORE: https://wiki.archlinux.org/title/ZFS#Swap_volume
          #"root/swap" = {
          #  type = "zfs_volume";
          #  size = "10M";
          #  content = {
          #    type = "swap";
          #  };
          #  options = {
          #    volblocksize = "4096";
          #    compression = "zle";
          #    logbias = "throughput";
          #    sync = "always";
          #    primarycache = "metadata";
          #    secondarycache = "none";
          #    "com.sun:auto-snapshot" = "false";
          #  };
          #};
        };
      };
    };
  };
}