{ config, pkgs, ... }:

{
  home.username = "murt";
  home.homeDirectory = "/home/murt";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello
    pkgs.git
    pkgs.direnv
    pkgs.atuin

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    pkgs.nerd-fonts.jetbrains-mono

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/murt/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        swapesc = "setxkbmap -option caps:swapescape";
        u = "cd ..";
	mvim = "nix run github:curtismuntz/nixvim-flake";
	lmvim = "nix run /home/murt/code/personal/nixvim-flake";
	ls = "ls --color=auto";
      };
      # enableAutosuggestions = true;
      initContent = ''
       eval "$(direnv hook zsh)"
       eval "$(atuin init zsh)"
       bindkey '^ ' autosuggest-accept
       bindkey '^[[H' beginning-of-line
       bindkey '^[[F' end-of-line
       bindkey '^[[3~' delete-char
       ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
       source ~/.p10k.zsh
      '';
      history = {
        size = 10000;
      };
      oh-my-zsh = { # "ohMyZsh" without Home Manager
        enable = true;
        plugins = [
	  "tmux"
	  "z"
	  "git"
	  "mercurial"
	  "command-not-found"
	  "python"
	  "pip"
	  "github"
	  "gnu-utils"
	  "history-substring-search"
	  "colored-man-pages"
	  "catimg"
	  "docker"
	];
        #theme = "fletcherm";
	theme = "agnoster";
      };
      plugins = [
        {
          name = "powerlevel10k";
	  src = pkgs.zsh-powerlevel10k;
	  file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
	}
      ];
  };
  programs.tmux = {
    enable = true;

    baseIndex = 1;

    plugins = with pkgs; [
      tmuxPlugins.yank
      #tmuxPlugins.fzf
      #tmuxPlugins.tpm
      tmuxPlugins.continuum

      tmuxPlugins.catppuccin
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
    ];

    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      #set -g mouse on

      set -g @catppuccin_flavour 'mocha'

      set -g @catppuccin_window_left_separator ""
      set -g @catppuccin_window_right_separator " "
      set -g @catppuccin_window_middle_separator " █"
      set -g @catppuccin_window_number_position "right"
      set -g @catppuccin_window_default_fill "number"
      set -g @catppuccin_window_default_text "#W"
      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
      set -g @catppuccin_status_modules_right "directory date_time"
      set -g @catppuccin_status_modules_left "session"
      set -g @catppuccin_status_left_separator  " "
      set -g @catppuccin_status_right_separator " "
      set -g @catppuccin_status_right_separator_inverse "no"
      set -g @catppuccin_status_fill "icon"
      set -g @catppuccin_status_connect_separator "no"
      set -g @catppuccin_directory_text "#{b:pane_current_path}"
      set -g @catppuccin_date_time_text "%H:%M"
      #set -g @catppuccin_meetings_text "#($HOME/.config/tmux/scripts/cal.sh)"
    '';
    };
    programs.git = {
      enable = true;
      userName  = "murt";
      userEmail = "me@murt.is";
      aliases = {
        st = "status";
        ci = "commit";
        br = "branch";
        co = "checkout";
        last = "log -1 HEAD";
        l = "log --pretty=oneline -n 20 --graph --abbrev-commit";
        s = "status -s";
      };
      extraConfig = {
        core.editor = "vim";
      };
      delta = {
        enable = true;
        options = {
          syntax-theme = "Monokai Extended";
          line-numbers = true;
          side-by-side = true;
          plus-color = "#012800";
          minus-color = "#340001";
        };
      };
    };

}
