{ user, config, pkgs, ... }:

let
  xdg_configHome = "${config.users.users.${user}.home}/.config";
  xdg_dataHome   = "${config.users.users.${user}.home}/.local/share";
  xdg_stateHome  = "${config.users.users.${user}.home}/.local/state";
  aerospace_config = "${config.users.users.${user}.home}/.aerospace.toml"; in
{
  # AeroSpace configuration
  "${aerospace_config}" = {
    text = ''
      # AeroSpace config defined by nix in modules/darwin/files.nix

      # Start AeroSpace at login
      start-at-login = true

      # You can use it to add commands that run after login to macOS user session.
      # 'start-at-login' needs to be 'true' for 'after-login-command' to work
      # Available commands: https://nikitabobko.github.io/AeroSpace/commands
      after-login-command = []
      
      # You can use it to add commands that run after AeroSpace startup.
      # 'after-startup-command' is run after 'after-login-command'
      # Available commands : https://nikitabobko.github.io/AeroSpace/commands
      after-startup-command = []

      # Mouse follows focus when focused monitor changes
      on-focused-monitor-changed = ['move-mouse monitor-lazy-center']
      # Move mouse to center of window when focus changes to it
      on-focus-changed = 'move-mouse window-lazy-center'

      # Default layout & orientation of root container
      default-root-container-layout = 'tiles'
      default-root-container-orientation = 'auto'

      # Gaps between windows (inner-*) and between monitor edges (outer-*).
      # Possible values:
      # - Constant:     gaps.outer.top = 8
      # - Per monitor:  gaps.outer.top = [{ monitor.main = 16 }, { monitor."some-pattern" = 32 }, 24]
      #                 In this example, 24 is a default value when there is no match.
      #                 Monitor pattern is the same as for 'workspace-to-monitor-force-assignment'.
      #                 See: https://nikitabobko.github.io/AeroSpace/guide#assign-workspaces-to-monitors
      [gaps]
      inner.horizontal = 10
      inner.vertical =   10
      outer.left =       10
      outer.bottom =     10
      outer.top =        10
      outer.right =      10

      # 'main' binding mode declaration
      # See: https://nikitabobko.github.io/AeroSpace/guide#binding-modes
      # 'main' binding mode must be always presented
      [mode.main.binding]
      
      # All possible keys:
      # - Letters.        a, b, c, ..., z
      # - Numbers.        0, 1, 2, ..., 9
      # - Keypad numbers. keypad0, keypad1, keypad2, ..., keypad9
      # - F-keys.         f1, f2, ..., f20
      # - Special keys.   minus, equal, period, comma, slash, backslash, quote, semicolon, backtick,
      #                   leftSquareBracket, rightSquareBracket, space, enter, esc, backspace, tab
      # - Keypad special. keypadClear, keypadDecimalMark, keypadDivide, keypadEnter, keypadEqual,
      #                   keypadMinus, keypadMultiply, keypadPlus
      # - Arrows.         left, down, up, right
      
      # All possible modifiers: cmd, alt, ctrl, shift
      
      # All possible commands: https://nikitabobko.github.io/AeroSpace/commands

      # Open kitty terminal
      alt-enter = 'exec-and-forget open -na ${pkgs.kitty}/Applications/kitty.app'

      # See: https://nikitabobko.github.io/AeroSpace/commands#layout
      alt-f = 'fullscreen'
      alt-e = 'layout tiles horizontal vertical' # 'layout toggle split' in i3
      alt-s = 'layout v_accordion' # 'layout stacking' in i3
      alt-w = 'layout h_accordion' # 'layout tabbed' in i3
      alt-shift-space = 'layout floating tiling' # 'floating toggle' in i3

      # See: https://nikitabobko.github.io/AeroSpace/commands#focus
      alt-h = 'focus left'
      alt-j = 'focus down'
      alt-k = 'focus up'
      alt-l = 'focus right'
      
      # See: https://nikitabobko.github.io/AeroSpace/commands#move
      alt-shift-h = 'move left'
      alt-shift-j = 'move down'
      alt-shift-k = 'move up'
      alt-shift-l = 'move right'

      alt-shift-cmd-h = ['join-with left', 'mode main']
      alt-shift-cmd-j = ['join-with down', 'mode main']
      alt-shift-cmd-k = ['join-with up', 'mode main']
      alt-shift-cmd-l = ['join-with right', 'mode main']
      
      # See: https://nikitabobko.github.io/AeroSpace/commands#resize
      alt-shift-minus = 'resize smart -50'
      alt-shift-equal = 'resize smart +50'

      # See: https://nikitabobko.github.io/AeroSpace/commands#workspace
      alt-1 = 'workspace 1'
      alt-2 = 'workspace 2'
      alt-3 = 'workspace 3'
      alt-4 = 'workspace 4'
      alt-5 = 'workspace 5'
      alt-6 = 'workspace 6'
      alt-7 = 'workspace 7'
      alt-8 = 'workspace 8'
      alt-9 = 'workspace 9'

      alt-shift-1 = 'move-node-to-workspace 1'
      alt-shift-2 = 'move-node-to-workspace 2'
      alt-shift-3 = 'move-node-to-workspace 3'
      alt-shift-4 = 'move-node-to-workspace 4'
      alt-shift-5 = 'move-node-to-workspace 5'
      alt-shift-6 = 'move-node-to-workspace 6'
      alt-shift-7 = 'move-node-to-workspace 7'
      alt-shift-8 = 'move-node-to-workspace 8'
      alt-shift-9 = 'move-node-to-workspace 9'
      #alt-shift-0 = 'move-node-to-workspace 0' # this is the secondary monitor, usually
      
      alt-shift-0 = 'focus-monitor --wrap-around next'
      
      alt-shift-c = 'reload-config'
      
      alt-r = 'mode resize'
      
      [mode.resize.binding]
      h = 'resize width -50'
      j = 'resize height +50'
      k = 'resize height -50'
      l = 'resize width +50'
      enter = 'mode main'
      esc = 'mode main'

      # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
      alt-tab = 'workspace-back-and-forth'
      # See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor
      alt-shift-tab = 'move-workspace-to-monitor --wrap-around next'
      
      # See: https://nikitabobko.github.io/AeroSpace/commands#mode
      alt-shift-semicolon = 'mode service'
      # 'service' binding mode declaration.
      # See: https://nikitabobko.github.io/AeroSpace/guide#binding-modes
      [mode.service.binding]
      esc = ['reload-config', 'mode main']
      r = ['flatten-workspace-tree', 'mode main'] # reset layout
      #s = ['layout sticky tiling', 'mode main'] # sticky is not yet supported https://github.com/nikitabobko/AeroSpace/issues/2
      f = ['layout floating tiling', 'mode main'] # Toggle between floating and tiling layout
      backspace = ['close-all-windows-but-current', 'mode main']
      
    '';
  };

  # Raycast script so that "Run Emacs" is available and uses Emacs daemon
 # "${xdg_dataHome}/bin/emacsclient" = {
 #   executable = true;
 #   text = ''
 #     #!/bin/zsh
 #     #
 #     # Required parameters:
 #     # @raycast.schemaVersion 1
 #     # @raycast.title Run Emacs
 #     # @raycast.mode silent
 #     #
 #     # Optional parameters:
 #     # @raycast.packageName Emacs
 #     # @raycast.icon ${xdg_dataHome}/img/icons/Emacs.icns
 #     # @raycast.iconDark ${xdg_dataHome}/img/icons/Emacs.icns

 #     if [[ $1 = "-t" ]]; then
 #       # Terminal mode
 #       ${pkgs.emacs}/bin/emacsclient -t $@
 #     else
 #       # GUI mode
 #       ${pkgs.emacs}/bin/emacsclient -c -n $@
 #     fi
 #   '';
 # };
}