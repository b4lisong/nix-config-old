{ config, pkgs, lib, ... }:

let name = "JL Mitra";
    user = "balisong";
    email = "b4lisong@pm.me"; in
{
  # Shared shell configuration
  zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    #autocd = false;
    #cdpath = [ "~/.local/share/src" ];
    #plugins = [
    #  {
    #      name = "powerlevel10k";
    #      src = pkgs.zsh-powerlevel10k;
    #      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    #  }
    #  {
    #      name = "powerlevel10k-config";
    #      src = lib.cleanSource ./config;
    #      file = "p10k.zsh";
    #  }
    #];
    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # Ripgrep alias
      alias search=rg -p --glob '!node_modules/*'  $@

      # vim is my editor
      export ALTERNATE_EDITOR=""
      #export VISUAL="emacsclient -c -a emacs"
      export EDITOR="vim"

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # pnpm is a javascript package manager
      alias pn=pnpm
      alias px=pnpx

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'
      alias ll='ls -lh'
      alias la='ls -alh'
      alias g='git'
      alias gs='git status';
      alias gp='git push';
      alias lg='lazygit';
    '';
    initExtra = ''
      # ensures homebrew CLI packages are in PATH for macOS
      # I don't like this one bit!
      if [[ $(uname -m) == 'arm64' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';
  };

  git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = "b4lisong";
    userEmail = "5397809+b4lisong@users.noreply.github.com";
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
	    editor = "vim";
        autocrlf = "input";
      };
      # Sign all commits using ssh key
      # ref: https://jeppesen.io/git-commit-sign-nix-home-manager-ssh/
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };

  vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline vim-airline-themes vim-startify vim-tmux-navigator ];
    settings = { ignorecase = true; };
    extraConfig = ''
      "" General
      set number
      set history=1000
      set nocompatible
      set modelines=0
      set encoding=utf-8
      set scrolloff=3
      set showmode
      set showcmd
      set hidden
      set wildmenu
      set wildmode=list:longest
      set cursorline
      set ttyfast
      set nowrap
      set ruler
      set backspace=indent,eol,start
      set laststatus=2
      ""set clipboard=autoselect
      set clipboard=unnamed

      " Dir stuff
      set nobackup
      set nowritebackup
      set noswapfile
      set backupdir=~/.config/vim/backups
      set directory=~/.config/vim/swap

      " Relative line numbers for easy movement
      set relativenumber
      set rnu

      "" Whitespace rules
      set tabstop=8
      set shiftwidth=2
      set softtabstop=2
      set expandtab

      "" Searching
      set incsearch
      set gdefault

      "" Statusbar
      set nocompatible " Disable vi-compatibility
      set laststatus=2 " Always show the statusline
      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1

      "" Local keys and such
      let mapleader=","
      let maplocalleader=" "

      "" Change cursor on mode
      :autocmd InsertEnter * set cul
      :autocmd InsertLeave * set nocul

      "" File-type highlighting and configuration
      syntax on
      filetype on
      filetype plugin on
      filetype indent on

      "" : -> ;
      noremap ; :

      "" jk -> esc in insert & visual mode
      inoremap jk <esc>
      vnoremap jk <esc>
      cnoremap jk <C-C>

      "" Paste from clipboard
      nnoremap <Leader>, "+gP

      "" Copy from clipboard
      xnoremap <Leader>. "+y

      "" Move cursor by display lines when wrapping
      nnoremap j gj
      nnoremap k gk

      "" Map leader-q to quit out of window
      nnoremap <leader>q :q<cr>

      "" Move around split
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l

      "" Easier to yank entire line
      nnoremap Y y$

      "" Move buffers
      nnoremap <tab> :bnext<cr>
      nnoremap <S-tab> :bprev<cr>

      "" Like a boss, sudo AFTER opening the file to write
      cmap w!! w !sudo tee % >/dev/null

      let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      }
        \ ]

      let g:startify_bookmarks = [
        \ '~/.local/share/src',
        \ ]

      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1
      '';
     };

  kitty = {
    enable = true;
    darwinLaunchOptions = [ "--single-instance" ];
    shellIntegration.enableZshIntegration = true;
    font = {
      name = "MesloLGS NF";
      size = 11;
    };
    theme = "Catppuccin-Mocha";
    keybindings = {
      "f1" = "show_kitty_env_vars";
    };
    settings = {
      background_opacity = "0.9";
      background_tint = "0.9";
      background_blur = 10;
      dim_opacity = "1.0";
      tab_bar_edge = "bottom";
      tab_bar_margin_width = "20.0";
      tab_bar_margin_height = "20.0 0.0";
      tab_bar_style = "powerline";
      tab_bar_align = "left";
      tab_bar_min_tabs = 2;
      tab_switch_strategy = "previous";
      tab_activity_symbol = "none";
      tab_powerline_style = "slanted";
      tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}";
      active_tab_title_template = "none";
      scrollback_lines = 10000;
      enable_audio_bell = false;
      window_margin_width = 0;
      window_padding_width = 20;
      remember_window_size = true;
      placement_strategy = "center";
      confirm_os_window_close = 0;
      hide_window_decorations = "titlebar-only";
      macos_quit_when_last_window_closed = true;
    };
  };   

  starship = {
    enable = true;
    settings = {
      # sources: 
      # https://gist.github.com/mIcHyAmRaNe/a6ee5ca3311d61ae6f181e691643925d
      # https://gist.github.com/pythoninthegrass/faff76c2f571c57126e793733aae167d
      add_newline = true;
      format = ''
        [┌╴\(](bold green)[$username@$hostname](bold blue)[\)](bold green) $os
        [| $all└─](bold green)$character
      '';
      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[](bold red)";
        # vicmd_symbol = "[V](bold green)";
      };
      username = {
        style_user = "blue bold";
        style_root = "red bold";
        format = "[$user]($style)";
        disabled = false;
        show_always = true;  
      };
      hostname = {
        ssh_only = false;
        format = "[$ssh_symbol](bold blue)[$hostname](bold blue)";
        trim_at = ".";
        disabled = false;
      };
      os = {
        style = "bold white";
        format = "on [$symbol $arch$name](style)";
        disabled = false;
      };
      os.symbols = {
        Macos = "";
        NixOS = "";
        Kali = "";
        Linux = "";
        Windows = "";
        Unknown = "";
      };
      git_branch = {
        truncation_length = 15;
        truncation_symbol = "";
        disabled = false;
      };
      git_status = {
        disabled = false;
      };
      git_commit = {
        commit_hash_length = 4;
        tag_disabled = false;
        only_detached = false;
      };
      directory = {
        truncation_length = 8;
        truncation_symbol = "…/";
        truncate_to_repo = true;
        read_only = "🔒";
      };
    };
  };

  ssh = {
    enable = true;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/id_github"
          )
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/id_github"
          )
        ];
      };
    };
  };

  tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      sensible
      yank
      prefix-highlight
      {
        plugin = power-theme;
        extraConfig = ''
           set -g @tmux_power_theme 'gold'
        '';
      }
      {
        plugin = resurrect; # Used by tmux-continuum

        # Use XDG data directory
        # https://github.com/tmux-plugins/tmux-resurrect/issues/348
        extraConfig = ''
          set -g @resurrect-dir '$HOME/.cache/tmux/resurrect'
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-pane-contents-area 'visible'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5' # minutes
        '';
      }
    ];
    terminal = "screen-256color";
    prefix = "C-x";
    escapeTime = 10;
    historyLimit = 50000;
    extraConfig = ''
      # Remove Vim mode delays
      set -g focus-events on

      # Enable full mouse support
      set -g mouse on

      # -----------------------------------------------------------------------------
      # Key bindings
      # -----------------------------------------------------------------------------

      # Unbind default keys
      unbind C-b
      unbind '"'
      unbind %

      # Split panes, vertical or horizontal
      bind-key x split-window -v
      bind-key v split-window -h

      # Move around panes with vim-like bindings (h,j,k,l)
      bind-key -n M-k select-pane -U
      bind-key -n M-h select-pane -L
      bind-key -n M-j select-pane -D
      bind-key -n M-l select-pane -R

      # Smart pane switching with awareness of Vim splits.
      # This is copy paste from https://github.com/christoomey/vim-tmux-navigator
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
        | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l
      '';
    };
}
