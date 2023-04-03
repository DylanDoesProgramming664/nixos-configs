

# DylanDoesProgramming's configuration.nix

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of hardware scan
    ./hardware-configuration.nix
    <nixos-hardware/system76/default.nix>
  ];

  # Boot Loader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    systemd-boot.enable = true;
  };

  # linux kernel version
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_1; 

  boot.kernelModules = [ "fuse" "kvm-intel" "coretemp" ];

  boot.supportedFilesystems = [ "ntfs" ];

  # Network Manager
  networking.networkmanager = {
    enable = true;
  };

  # Time Zone
  time.timeZone = "America/New_York";

  # XServer settings
  services = {
    xserver = {
      enable = true;

      displayManager.lightdm.enable = true;
      displayManager.defaultSession = "none+i3";

      desktopManager = {
        plasma5.enable = true;
	xfce.enable = true;
      };

      windowManager = {
        i3.enable = true;
      };

      videoDrivers = [ "modesetting" ];

      libinput = {
        enable = true;
        touchpad.scrollMethod = "edge";
      };

    };
  };

  # Theme settings
  qt5.enable = true;
  qt5.platformTheme = "gnome";
  qt5.style = "adwaita";

  # Audio settings
  sound.enable = true;
  sound.mediaKeys.enable = true;
  hardware.pulseaudio.enable = true;

  # OpenGl/OpenCL settings
  hardware.opengl = {
    enable = true;
    extraPackages = [
      pkgs.intel-compute-runtime
    ];
  };

  # Input config
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ anthy hangul mozc ];
  };

  # Bluetooth settings
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  # Init user configs
  users.users.dylandoesprogramming = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    password = "password";
  };

  security.sudo.enable = true;

  # Doas config
  security.doas = {
    enable = true;
    extraRules = [
      { groups = [ "wheel" ]; persist = true; }
    ];
  };

  # Zsh config
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    autosuggestions.async = true;
    histSize = 10000;
  };

  services.lemmy.enable = true;
  services.lemmy.settings.hostname = "dylandoesprogramming664";

  nixpkgs.config.allowUnfree = true;

  # Builtin Packages
  environment.systemPackages = with pkgs; [
    # Essentials
    curl
    wget
    tree
    plocate
    exa
    bat
    fd
    du-dust
    procs
    tldr
    tealdeer
    bottom
    zoxide
    openssl
    openssh
    pkg-config
    unzip
    ocs-url
    xss-lock

    # Continuous Integration tools
    git
    gh
    fossil
    circleci-cli

    # Terminals, Emulators & Shells
    xterm
    kitty
    alacritty
    tmux
    nushell

    # Vim related stuff
    neovim
    neovide
    vifm
    vieb

    # QoL
    ripgrep
    lazygit

    # Programming Languages
    kotlin
    go
    python3
    julia
    ruby_3_1
    crystal
    nodejs
    nodePackages.npm
    rustup
    gcc
    flex
    bison
    clang
    lua5_3_compat
    lua53Packages.tl
    gnumake

    # Extras
    brave
    thunderbird
    kate
    digitalbitbox
    neofetch
    screenfetch
    nitrogen
    element-desktop
    discord
    spotify
    android-studio
    anbox
    feh
    i3-gaps
    dmenu
    via
    appimage-run
    fuse
  ];

  fonts.fonts = with pkgs; [
    nerdfonts
    vistafonts
  ];

  services.udev.packages = [ "/run/current-system/sw/bin/via" ];

  environment.variables = {
    EDITOR = "nvim";
    TERM = "xterm-256color";
    SHELL = "zsh";
    OPENSSL_DIR = "/nix/store/3qy9hdy1v3ci7vqahprrcf7d3553rndy-openssl-3.0.8-bin/bin/openssl";
    X86_64_UNKNOWN_LINUX_GNU_OPENSSL_LIB_DIR = "/nix/store/xzn56dy54k0sdgm4lx98c20r81hq41nl-openssl-3.0.8/lib";
    X86_64_UNKNOWN_LINUX_GNU_OPENSSL_INCLUDE_DIR = "/nix/store/g8jc4yh3hgvwjp2q420ddgvc3gb2rpkd-openssl-3.0.8-dev/include";
    OPENSSL_INCLUDE_DIR = "/nix/store/g8jc4yh3hgvwjp2q420ddgvc3gb2rpkd-openssl-3.0.8-dev/include";
    X86_64_UNKNOWN_LINUX_GNU_OPENSSL_DIR = "/nix/store/3qy9hdy1v3ci7vqahprrcf7d3553rndy-openssl-3.0.8-bin/bin/openssl";
    DISPLAY = ":0";
  };

  boot.initrd.availableKernelModules = [ "hid_cherry" ];

  programs.ssh.askPassword = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";

  hardware.system76.enableAll = true;

  services.ddccontrol.enable = true;

  system.stateVersion = "23.05";
}
