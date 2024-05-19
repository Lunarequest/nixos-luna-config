{
  config,
  pkgs,
  lib,
  ...
}: {
  boot.kernelParams = ["zswap.enabled=1"];
  boot.kernelPackages = pkgs.luna_linux.extend (self: super: {
    kernel = super.kernel.overrideAttrs (old: {
      nativeBuildInputs = with pkgs;
        old.nativeBuildInputs
        ++ [
          llvmPackages_18.lld
          llvmPackages_18.clangUseLLVM
          pkgs.llvmPackages_18.llvm
        ];
      LLVM = "1";
      LLVM_IAS = "1";
      CC = "${pkgs.llvmPackages_18.clangUseLLVM}/bin/clang";
      HOSTCC = "${pkgs.llvmPackages_18.clangUseLLVM}/bin/clang";
      LD = "${pkgs.llvmPackages_18.lld}/bin/ld.lld";
      HOSTLD = "${pkgs.llvmPackages_18.lld}/bin/ld.lld";
      AR = "${pkgs.llvmPackages_18.llvm}/bin/llvm-ar";
      HOSTAR = "${pkgs.llvmPackages_18.llvm}/bin/llvm-ar";
      NM = "${pkgs.llvmPackages_18.llvm}/bin/llvm-nm";
      STRIP = "${pkgs.llvmPackages_18.llvm}/bin/llvm-strip";
      OBJCOPY = "${pkgs.llvmPackages_18.llvm}/bin/llvm-objcopy";
      OBJDUMP = "${pkgs.llvmPackages_18.llvm}/bin/llvm-objdump";
      READELF = "${pkgs.llvmPackages_18.llvm}/bin/llvm-readelf";
      HOSTCXX = "${pkgs.llvmPackages_18.clangUseLLVM}/bin/clang++";
    });
  });
}
