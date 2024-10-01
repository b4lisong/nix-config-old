{
  services.code-server = {
    enable = true;
    auth = "none";
    host = "0.0.0.0";
    extraGroups = ["docker"];
    disableWorkspaceTrust = true;
    disableTelemetry = true;
  };
}
