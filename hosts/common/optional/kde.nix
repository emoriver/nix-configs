{
  services.xserver.enable = true; # Requiered for SDDM and KDE Plasma 6 even if you use Wayland

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
}
