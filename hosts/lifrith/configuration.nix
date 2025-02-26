# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  attrs,
  ...
}: {
  nixpkgs.overlays = [
    (self: super: {
      luna_linux =
        (let
          baseKernel = pkgs.linuxPackages_latest;
        in
          pkgs.linuxManualConfig {
            # here we inhert the src and modDriVersion from baseKernel,
            # we don't want to redfine these
            inherit (baseKernel.kernel) src modDirVersion;
            # we do want to overwrite the stdenv we like
            stdenv = pkgs.llvmPackages_18.stdenv;
            # we rename the kernel to know we're on the right one
            # this is also why we need to inhert modDirVersion
            version = "${baseKernel.kernel.version}-luna";
            # out config
            configfile = ../../kernel/luna-config;
            # required to fix some things
            allowImportFromDerivation = true;
          })
        .overrideAttrs (old: {
          nativeBuildInputs = with pkgs;
            old.nativeBuildInputs
            ++ [
              llvmPackages_18.lld
              llvmPackages_18.clangUseLLVM
              llvmPackages_18.llvm
              openssl_3_3
              zstd
              pahole
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
          hardeningDisable = ["all"];
        });
    })
  ];
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/encrypted_dns.nix
    ./modules/kernel.nix
  ];
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "Lifrith"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  #switch to dbus-broker
  services.dbus.implementation = "broker";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.luna = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Luna D Dragon";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      kate
      git
      neovim
      #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  programs.kdeconnect.enable = true;

  # Install zsh
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    clang_18
    vivaldi-ffmpeg-codecs
    (
      pkgs.vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = true;
      }
    )
    widevine-cdm
    rustup
    attrs.dotfox.packages.x86_64-linux.dotfox
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
