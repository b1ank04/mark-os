{...}: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 350;
        height = 150;
        offset = "10x10";
        origin = "top-right";
        transparency = 10;
        frame_color = "#7aa2f7";
        font = "JetBrainsMono Nerd Font 10";
        corner_radius = 10;
      };
      urgency_normal = {
        background = "#1f2335";
        foreground = "#c0caf5";
        timeout = 5;
      };
    };
  };
}
