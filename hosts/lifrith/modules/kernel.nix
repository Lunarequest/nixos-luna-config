{
  config,
  pkgs,
  lib,
  ...
}: {
  boot.kernelParams = ["zswap.enabled=1"];
  boot.kernelPatches = [
    {
      name="tcp-bbrv3";
      patch = ../../../kernel/patches/0001-bbr3.patch;
    }
    {
      name="misc-fixes";
      patch=../../../kernel/patches/0002-fixes.patch;
    }
    {
      name="ntsync";
      patch=../../../kernel/patches/0003-ntsync.patch;
      extraStructuredConfig = {
        NTSYNC = lib.kernel.mkForce lib.kernel.module;
      };
    }
    {
      name = "upgrade-zstd";
      patch = ../../../kernel/patches/0004-zstd.patch;
    }
  ];
  boot.kernelPackages = pkgs.linuxPackagesFor pkgs.luna_linux;
}

