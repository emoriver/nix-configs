# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;

  fonts = import ./fonts.nix;
/*  
  monitors = import ./monitors.nix;
  oama = import ./oama.nix;
  pass-secret-service = import ./pass-secret-service.nix;
  wallpaper = import ./wallpaper.nix;
  xpo = import ./xpo.nix;
  colors = import ./colors.nix;
  calendar-changes = import ./calendar-changes.nix;
  vdirsyncer = import ./vdirsyncer.nix;
*/
}
