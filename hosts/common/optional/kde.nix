{
  services.xserver.enable = true; # Requiered for SDDM and KDE Plasma 6 even if you use Wayland

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  programs.partition-manager.enable = true; # Optional: Enable partition manager for KDE Plasma 6
}
