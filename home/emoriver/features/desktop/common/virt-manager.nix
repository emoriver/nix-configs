{
  pkgs,
  ...
}: {

  programs.virt-manager = {
    enable = true;
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
 };
}