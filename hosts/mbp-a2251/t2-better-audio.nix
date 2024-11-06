{
  config,
  lib,
  ...
}: {
  # source: https://github.com/kekrby/t2-better-audio
  # Configuration files to improve audio experience for T2 Macs

  environment.etc = {
    # Custom profile set configuration for Apple T2
    # from: https://wiki.t2linux.org/guides/audio-config/
    # `sed -n "s/.*\(AppleT2.*\) -.*/\1/p" /proc/asound/cards`
    # yields AppleT2x4 on the A2251.
    # Using: https://github.com/kekrby/t2-better-audio/blob/main/files/profile-sets/apple-t2x4.conf
    "pipewire/alsa-card-profile/mixer/profile-sets/apple-t2x4.conf".text = ''
      [Mapping Speakers]
      device-strings = hw:%f,0
      paths-output = t2-speakers
      channel-map = front-left,front-right,rear-left,rear-right
      direction = output

      [Mapping BuiltinMic]
      device-strings = hw:%f,1
      paths-input = t2-builtin-mic
      channel-map = aux0,aux1,aux2
      direction = input

      [Mapping Headphones]
      device-strings = hw:%f,2
      paths-output = t2-headphones
      channel-map = left,right
      direction = output

      [Mapping HeadsetMic]
      device-strings = hw:%f,3
      paths-input = t2-headset-mic
      channel-map = mono
      direction = input

      [Profile Default]
      description = Default Profile
      output-mappings = Speakers Headphones
      input-mappings = BuiltinMic HeadsetMic
    '';

    # Custom path configurations

    # t2-speakers.conf
    "pipewire/alsa-card-profile/mixer/paths/t2-speakers.conf".text = ''
      [General]
      type = speaker
      priority = 100
      description-key = analog-output-speaker
    '';

    # t2-builtin-mic.conf
    "pipewire/alsa-card-profile/mixer/paths/t2-builtin-mic.conf".text = ''
      [General]
      type = mic
      priority = 100
      description-key = analog-input-microphone-internal
    '';

    # t2-headphones.conf
    "pipewire/alsa-card-profile/mixer/paths/t2-headphones.conf".text = ''
      [General]
      type = headphones
      priority = 200
      description-key = analog-output-headphones

      [Jack Codec Output]
      required = any
    '';

    # t2-headset-mic.conf
    "pipewire/alsa-card-profile/mixer/paths/t2-headset-mic.conf".text = ''
      [General]
      type = headset
      priority = 200
      description-key = analog-input-microphone-headset

      [Jack Codec Output]
      required = any
    '';

    # Udev rules
    "udev/rules.d/91-audio-custom.rules".text = ''
      SUBSYSTEM!="sound", GOTO="pulseaudio_end"
      ACTION!="change", GOTO="pulseaudio_end"
      KERNEL!="card*", GOTO="pulseaudio_end"

      SUBSYSTEMS=="pci", ATTRS{vendor}=="0x106b", ATTRS{device}=="0x1803", PROGRAM="/usr/bin/sed -n 's/.*AppleT2x\([0-9]\).*/\1/p' /proc/asound/cards", ENV{PULSE_PROFILE_SET}="apple-t2x%c.conf", ENV{ACP_PROFILE_SET}="apple-t2x%c.conf"

      LABEL="pulseaudio_end"
    '';
  };
}
