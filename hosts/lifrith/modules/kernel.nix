{
  config,
  pkgs,
  lib,
  ...
}: {
  boot.kernelParams = ["zswap.enabled=1"];
  boot.kernelPatches = [
    {
      name = "clang-sexy";
      patch = null;
      extraStructuredConfig = with lib.kernel; {
        CFI_CLANG = lib.mkForce lib.kernel.yes;
        # this should make the kernel compile with thin lto
        LTO_NONE = lib.mkForce lib.kernel.no;
        LTO_CLANG = lib.mkForce lib.kernel.yes;
        LTO_CLANG_THIN = lib.mkForce lib.kernel.yes;
      };
    }
    {
      name = "tcp-congest";
      patch = null;
      extraStructuredConfig = with lib.kernel; {
        TCP_CONG_BBR = lib.kernel.yes;
        TCP_CONG_CUBIC = lib.mkForce lib.kernel.no;
        DEFAULT_TCP_CONG = freeform "bbr";
      };
    }
    {
      name = "zswap";
      patch = null;
      extraStructuredConfig = with lib.kernel; {
        ZSWAP_DEFAULT_ON = lib.mkForce (lib.kernel.option lib.kernel.yes);
        ZSWAP_ZPOOL_DEFAULT_Z3FOLD = lib.mkForce (lib.kernel.option lib.kernel.yes);
        ZSWAP_COMPRESSOR_DEFAULT_LZ4 = lib.mkForce (lib.kernel.option lib.kernel.yes);
        ZSWAP_SHRINKER_DEFAULT_ON = lib.mkForce (lib.kernel.option lib.kernel.yes);
      };
    }
    {
      name = "disable-gfx";
      patch = null;
      extraStructuredConfig = with lib.kernel; {
        DRM_AMDGPU_CIK = lib.mkForce (lib.kernel.option lib.kernel.no);
        DRM_AMDGPU_SI = lib.mkForce (lib.kernel.option lib.kernel.no);
        DRM_AMDGPU_USERPTR = lib.mkForce (lib.kernel.option lib.kernel.no);
        DRM_AMD_DC_DCN = lib.mkForce (lib.kernel.option lib.kernel.no);
        DRM_AMD_DC_HDCP = lib.mkForce (lib.kernel.option lib.kernel.no);
        DRM_AMD_DC_SI = lib.mkForce (lib.kernel.option lib.kernel.no);
        DRM_DP_AUX_CHARDEV = lib.mkForce (lib.kernel.option lib.kernel.no);
        DRM_FBDEV_EMULATION = lib.mkForce (lib.kernel.option lib.kernel.no);
        DRM_GMA500 = lib.mkForce (lib.kernel.option lib.kernel.no);
        DRM_HYPERV = lib.mkForce (lib.kernel.option lib.kernel.no);
        DRM_LEGACY = lib.mkForce (lib.kernel.option lib.kernel.no);
        DRM_VMWGFX_FBCON = lib.mkForce (lib.kernel.option lib.kernel.no);
        HSA_AMD = lib.mkForce (lib.kernel.option lib.kernel.no);
        NOUVEAU_LEGACY_CTX_SUPPORT = lib.mkForce (lib.kernel.option lib.kernel.no);
      };
    }
    {
      name = "disable-sound";
      patch = null;
      extraStructuredConfig = with lib.kernel; {
        SND_SOC_INTEL_SOUNDWIRE_SOF_MACH = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_SOC_SOF_ACPI = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_SOC_SOF_APOLLOLAKE = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_SOC_SOF_CANNONLAKE = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_SOC_SOF_COFFEELAKE = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_SOC_SOF_COMETLAKE = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_SOC_SOF_ELKHARTLAKE = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_SOC_SOF_GEMINILAKE = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_SOC_SOF_HDA_AUDIO_CODEC = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_SOC_SOF_HDA_LINK = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_SOC_SOF_ICELAKE = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_SOC_SOF_INTEL_TOPLEVEL = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_SOC_SOF_JASPERLAKE = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_SOC_SOF_MERRIFIELD = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_SOC_SOF_PCI = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_SOC_SOF_TIGERLAKE = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_SOC_SOF_TOPLEVEL = lib.mkForce (lib.kernel.option lib.kernel.no);
        SND_USB_CAIAQ_INPUT = lib.mkForce (lib.kernel.option lib.kernel.no);
      };
    }
    {
      name = "disable-media";
      patch = null;
      extraStructuredConfig = with lib.kernel; {
        MEDIA_CONTROLLER = lib.mkForce (lib.kernel.option lib.kernel.no);
        MEDIA_TUNER = lib.mkForce (lib.kernel.option lib.kernel.no);
        MEDIA_ANALOG_TV_SUPPORT = lib.mkForce (lib.kernel.option lib.kernel.no);
        MEDIA_ATTACH = lib.mkForce (lib.kernel.option lib.kernel.no);
        MEDIA_DIGITAL_TV_SUPPORT = lib.mkForce (lib.kernel.option lib.kernel.no);
        STAGING_MEDIA = lib.mkForce (lib.kernel.option lib.kernel.no);
        DVB_CORE = lib.mkForce (lib.kernel.option lib.kernel.no);
      };
    }
    {
      name = "disable-wireless";
      patch = null;
      extraStructuredConfig = with lib.kernel; {
        RT2800USB_RT53XX = lib.mkForce (lib.kernel.option lib.kernel.no);
        RT2800USB_RT55XX = lib.mkForce (lib.kernel.option lib.kernel.no);
        RTW88 = lib.mkForce (lib.kernel.option lib.kernel.no);
        RTW88_8822BE = lib.mkForce (lib.kernel.option lib.kernel.no);
        RTW88_8822CE = lib.mkForce (lib.kernel.option lib.kernel.no);
        BT_HCIBTUSB_MTK = lib.mkForce (lib.kernel.option lib.kernel.no);
        BT_HCIUART = lib.mkForce (lib.kernel.option lib.kernel.no);
        BT_HCIUART_BCSP = lib.mkForce (lib.kernel.option lib.kernel.no);
        BT_HCIUART_H4 = lib.mkForce (lib.kernel.option lib.kernel.no);
        BT_HCIUART_LL = lib.mkForce (lib.kernel.option lib.kernel.no);
        BT_HCIUART_QCA = lib.mkForce (lib.kernel.option lib.kernel.no);
        BT_HCIUART_SERDEV = lib.mkForce (lib.kernel.option lib.kernel.no);
        BT_QCA = lib.mkForce (lib.kernel.option lib.kernel.no);

        NFC = lib.mkForce lib.kernel.no;
        HAMRADIO = lib.mkForce lib.kernel.no;
        WWAN = lib.mkForce lib.kernel.no;
        AX25 = lib.mkForce (lib.kernel.option lib.kernel.no);
        NETROM = lib.mkForce (lib.kernel.option lib.kernel.no);
        ROSE = lib.mkForce (lib.kernel.option lib.kernel.no);
      };
    }
    {
      name = "disable-interfaces";
      patch = null;
      extraStructuredConfig = with lib.kernel; {
        FIREWIRE = lib.mkForce lib.kernel.no;
        CARDBUS = lib.mkForce lib.kernel.no;
        PCMCIA = lib.mkForce lib.kernel.no;
        SCSI_LOWLEVEL_PCMCIA = lib.mkForce (lib.kernel.option lib.kernel.no);
        RAPIDIO = lib.mkForce lib.kernel.no;
        COMEDY = lib.mkForce (lib.kernel.option lib.kernel.no);
        GREYBUS = lib.mkForce lib.kernel.no;
      };
    }
    {
      name = "disable-xen";
      patch = null;
      extraStructuredConfig = with lib.kernel; {
        XEN = lib.mkForce lib.kernel.no;
      };
    }
    {
      name = "fucking-reiser";
      patch = null;
      extraStructuredConfig = with lib.kernel; {
        REISERFS_FS = lib.mkForce lib.kernel.no;
        ADFS_FS = lib.mkForce lib.kernel.no;
        AFS_FS = lib.mkForce lib.kernel.no;
        AFFS_FS = lib.mkForce lib.kernel.no;
        BEFS_FS = lib.mkForce lib.kernel.no;
        CRAMFS = lib.mkForce lib.kernel.no;
        EFS_FS = lib.mkForce lib.kernel.no;
        EROFS_FS = lib.mkForce lib.kernel.no;
        HFS_FS = lib.mkForce lib.kernel.no;
        HPFS_FS = lib.mkForce lib.kernel.no;
        JFS_FS = lib.mkForce lib.kernel.no;
        MINIX_FS = lib.mkForce lib.kernel.no;
        NILFS2_FS = lib.mkForce lib.kernel.no;
        NTFS3_FS = lib.mkForce lib.kernel.no;
        NTFS3_FS_POSIX_ACL = lib.mkForce (lib.kernel.option lib.kernel.no);
        NTFS3_LZX_XPRESS = lib.mkForce (lib.kernel.option lib.kernel.no);
        OMFS_FS = lib.mkForce lib.kernel.no;
        ORANGEFS_FS = lib.mkForce lib.kernel.no;
        QNX4FS_FS = lib.mkForce lib.kernel.no;
        QNX6FS_FS = lib.mkForce lib.kernel.no;
        SYSV_FS = lib.mkForce lib.kernel.no;
        UBIFS_FS = lib.mkForce lib.kernel.no;
        VXFS_FS = lib.mkForce lib.kernel.no;
        UFS_FS = lib.mkForce lib.kernel.no;
        GFS2_FS = lib.mkForce lib.kernel.no;
        OCFS2_FS = lib.mkForce lib.kernel.no;
      };
    }
  ];
}
