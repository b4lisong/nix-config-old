{ agenix, config, pkgs, ... }:

let user = "balisong"; in

{

  imports = [
    ../../modules/darwin/secrets.nix
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
    ../../modules/shared/cachix
     agenix.darwinModules.default
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Setup user, packages, programs
  nix = {
    package = pkgs.nix;
    settings.trusted-users = [ "@admin" "${user}" ];

    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    # Turn this on to make command line easier
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;

  # Load configuration that is shared across systems
  environment.systemPackages = with pkgs; [
    agenix.packages."${pkgs.system}".default
  ] ++ (import ../../modules/shared/packages.nix { inherit pkgs; });

  system = {
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };
      
      # Show specific text as a greeting at login
      loginwindow.LoginwindowText = "おかえり、お兄ちゃん";

      screensaver = {
        # Always ask for password when screensaver unlocked
        askForPassword = true;
        # Only ask for screensaver password if longer than 10 sec
        askForPasswordDelay = 10;
      };

      # One space spans across all physical displays
      # Useful due to AeroSpace
      spaces.spans-displays = true;

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.2;
        expose-animation-duration = 0.2;
        showhidden = true;
        show-process-indicators = true;
        show-recents = false;
        launchanim = true;
        orientation = "right";
        tilesize = 48;
        mru-spaces = false;
        wvous-bl-corner = 13; # hot corner, bottom-left: lock screen
      };

      finder = {
        _FXShowPosixPathInTitle = false;
        # Finder shows all file extensions
        AppleShowAllExtensions = true;
        # Default Finder view is columns
        FXPreferredViewStyle = "clmv";
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };

      CustomUserPreferences = {
        NSGlobalDomain = {
          # Add a context menu item for showing the Web Inspector in web views
          WebKitDeveloperExtras = true;
        };
	"com.apple.finder" = {
        ShowExternalHardDrivesOnDesktop = true;
        ShowHardDrivesOnDesktop = true;
        ShowMountedServersOnDesktop = true;
        ShowRemovableMediaOnDesktop = true;
        _FXSortFoldersFirst = true;
        # When performing a search, search the current folder by default
        FXDefaultSearchScope = "SCcf";
      };
      "com.apple.desktopservices" = {
        # Avoid creating .DS_Store files on network or USB volumes
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.screensaver" = {
        # Require password immediately after sleep or screen saver begins
        askForPassword = 1;
        askForPasswordDelay = 0;
      };
      "com.apple.screencapture" = {
        location = "~/Desktop";
        type = "png";
      };
      # TODO: enable these settings elsewhere
      #"com.apple.Safari" = {
      #  # Privacy: don’t send search queries to Apple
      #  UniversalSearchEnabled = false;
      #  SuppressSearchSuggestions = true;
      #  # Press Tab to highlight each item on a web page
      #  WebKitTabToLinksPreferenceKey = true;
      #  ShowFullURLInSmartSearchField = true;
      #  # Prevent Safari from opening ‘safe’ files automatically after downloading
      #  AutoOpenSafeDownloads = false;
      #  ShowFavoritesBar = false;
      #  IncludeInternalDebugMenu = true;
      #  IncludeDevelopMenu = true;
      #  WebKitDeveloperExtrasEnabledPreferenceKey = true;
      #  WebContinuousSpellCheckingEnabled = true;
      #  WebAutomaticSpellingCorrectionEnabled = false;
      #  AutoFillFromAddressBook = false;
      #  AutoFillCreditCardData = false;
      #  AutoFillMiscellaneousForms = false;
      #  WarnAboutFraudulentWebsites = true;
      #  WebKitJavaEnabled = false;
      #  WebKitJavaScriptCanOpenWindowsAutomatically = false;
      #  "com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks" = true;
      #  "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" = true;
      #  "com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled" = false;
      #  "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled" = false;
      #  "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles" = false;
      #  "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically" = false;
      #};
      "com.apple.mail" = {
        # Disable inline attachments (just show the icons)
        DisableInlineAttachmentViewing = true;
      };
      "com.apple.AdLib" = {
        allowApplePersonalizedAdvertising = false;
      };
      "com.apple.print.PrintingPrefs" = {
        # Automatically quit printer app once the print jobs complete
        "Quit When Finished" = true;
      };
      "com.apple.SoftwareUpdate" = {
        AutomaticCheckEnabled = true;
        # Check for software updates daily, not just once per week
        ScheduleFrequency = 1;
        # Download newly available updates in background
        AutomaticDownload = 1;
        # Install System data files & security updates
        CriticalUpdateInstall = 1;
      };
      "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
      # Prevent Photos from opening automatically when devices are plugged in
      "com.apple.ImageCapture".disableHotPlug = true;
      # Turn on app auto-update
      "com.apple.commerce".AutoUpdate = true;
      };
    };
  };
}
