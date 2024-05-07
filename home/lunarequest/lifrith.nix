{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "luna";
    homeDirectory = "/home/luna";
    packages = with pkgs; [
      vscode
      cascadia-code
    ];
  };

  nixpkgs.config.allowUnfree = true;

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  programs.bat.enable = true;
  programs.ripgrep.enable = true;
  programs.eza.enable = true;

  programs.gpg = {
    enable = true;
    settings = {use-agent = true;};
  };

  programs.git = {
    enable = true;
    userName = "Luna D Dragon";
    userEmail = "luna@nullrequest.com";
    extraConfig = {
      color.ui = true;
      pull.rebase = true;
      merge.conflictstyle = "diff3";
      diff.algorithm = "patience";
      protocol.version = "2";
      core.commitGraph = true;
      gc.writeCommitGraph = true;
    };
  };

  programs.kitty.enable = true;
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
