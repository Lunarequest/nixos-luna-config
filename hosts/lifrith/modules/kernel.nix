{
  config,
  pkgs,
  lib,
  ...
}: {
  boot.kernelParams = ["zswap.enabled=1"];
  boot.kernelPackages = luna_linux;
}
