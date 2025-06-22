{
  pkgs,
  ...
}: {
  imports = [
    ./global
    #./features/desktop/hyprland
    ./features/desktop/kde
    #./features/desktop/wireless
    #./features/rgb
    #./features/productivity
    #./features/pass
    #./features/games
    #./features/games/star-citizen.nix
    #./features/games/shadps4.nix
  ];
}
