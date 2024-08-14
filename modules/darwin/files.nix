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

      # Default layout & orientation of root container
      default-root-container-layout = 'tiles'
      default-root-container-orientation = 'auto'

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

      # See: https://nikitabobko.github.io/AeroSpace/commands#layout
      alt-slash = 'layout tiles horizontal vertical'
      alt-comma = 'layout accordion horizontal vertical'
      
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
