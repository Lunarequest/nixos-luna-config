{
  config,
  pkgs,
  lib,
  ...
}: {
  boot.kernelParams = ["zswap.enabled=1"];
  boot.kernelPackages = pkgs.linuxPackagesFor pkgs.luna_linux;
}
