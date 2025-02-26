{
  config,
  pkgs,
  lib,
  ...
}: {
  boot = {
    kernelParams = ["zswap.enabled=1" "lsm=landlock,lockdown,yama,integrity,bpf"];
    kernelPatches = [
      {
        name = "tcp-bbrv3";
        patch = ../../../kernel/patches/0001-bbr3.patch;
      }
      {
        name = "misc-fixes";
        patch = ../../../kernel/patches/0002-fixes.patch;
      }
      {
        name = "ntsync";
        patch = ../../../kernel/patches/0003-ntsync.patch;
        extraStructuredConfig = {
          NTSYNC = lib.kernel.mkForce lib.kernel.module;
        };
      }
      {
        name = "upgrade-zstd";
        patch = ../../../kernel/patches/0004-zstd.patch;
      }
      {
        name = "multi-gen-lru";
        patch = null;
        extraStructuredConfig = {
          LRU_GEN = lib.kernel.mkForce lib.kernel.yes;
          LRU_GEN_ENABLED = lib.kernel.mkForce lib.kernel.yes;
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
          DRM_VMWGFX_FBCON = lib.mkForce (lib.kernel.option lib.kernel.no);
          HSA_AMD = lib.mkForce (lib.kernel.option lib.kernel.no);
          NOUVEAU_LEGACY_CTX_SUPPORT = lib.mkForce (lib.kernel.option lib.kernel.no);
        };
      }
      {
        name = "disable-sound";
        patch = null;
        extraStructuredConfig = with lib.kernel; {
          SOUND = lib.mkForce lib.kernel.no;
          SND = lib.mkForce (lib.kernel.option lib.kernel.no);
          SND_AC97_POWER_SAVE = lib.mkForce (lib.kernel.option lib.kernel.no);
          SND_DYNAMIC_MINORS = lib.mkForce (lib.kernel.option lib.kernel.no);
          SND_HDA_INPUT_BEEP = lib.mkForce (lib.kernel.option lib.kernel.no);
          SND_HDA_PATCH_LOADER = lib.mkForce (lib.kernel.option lib.kernel.no);
          SND_HDA_RECONFIG = lib.mkForce (lib.kernel.option lib.kernel.no);
          SND_OSSEMUL = lib.mkForce (lib.kernel.option lib.kernel.no);
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
          MEDIA_SUPPORT = lib.mkForce lib.kernel.no;
          MEDIA_CONTROLLER = lib.mkForce (lib.kernel.option lib.kernel.no);
          MEDIA_TUNER = lib.mkForce (lib.kernel.option lib.kernel.no);
          MEDIA_ANALOG_TV_SUPPORT = lib.mkForce (lib.kernel.option lib.kernel.no);
          MEDIA_ATTACH = lib.mkForce (lib.kernel.option lib.kernel.no);
          MEDIA_DIGITAL_TV_SUPPORT = lib.mkForce (lib.kernel.option lib.kernel.no);
          MEDIA_CAMERA_SUPPORT = lib.mkForce (lib.kernel.option lib.kernel.no);
          MEDIA_PCI_SUPPORT = lib.mkForce (lib.kernel.option lib.kernel.no);
          MEDIA_USB_SUPPORT = lib.mkForce (lib.kernel.option lib.kernel.no);
          STAGING_MEDIA = lib.mkForce (lib.kernel.option lib.kernel.no);
          DVB_CORE = lib.mkForce (lib.kernel.option lib.kernel.no);
          VIDEO_DEV = lib.mkForce (lib.kernel.option lib.kernel.no);
          VIDEO_STK1160_COMMON = lib.mkForce (lib.kernel.option lib.kernel.no);
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

          BT = lib.mkForce lib.kernel.no;
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
    kernelPackages = pkgs.linuxPackagesFor pkgs.luna_linux;
    binfmt.emulatedSystems = ["aarch64-linux"];
  };
}
