{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    terminal = "kitty";
    theme = "tokyonight-storm";
  };

  xdg.dataFile."rofi/themes/tokyonight-storm.rasi".text = ''
    * {
      bg: #24283b;
      bg-alt: #292e42;
      fg: #c0caf5;
      accent: #7aa2f7;
      urgent: #f7768e;

      background-color: @bg;
      text-color: @fg;
      border-color: @accent;
    }

    window {
      width: 600px;
      border: 2px;
      border-radius: 12px;
      padding: 20px;
    }

    inputbar {
      children: [ prompt, entry ];
      padding: 8px 12px;
      background-color: @bg-alt;
      border-radius: 8px;
      margin: 0 0 10px 0;
    }

    prompt {
      background-color: inherit;
      text-color: @accent;
      margin: 0 8px 0 0;
    }

    entry {
      background-color: inherit;
      placeholder: "Search...";
      placeholder-color: #565f89;
    }

    listview {
      lines: 8;
      columns: 1;
      spacing: 4px;
      fixed-height: true;
    }

    element {
      padding: 8px 12px;
      border-radius: 8px;
    }

    element selected {
      background-color: @accent;
      text-color: @bg;
    }

    element-icon {
      size: 24px;
      margin: 0 10px 0 0;
    }

    element-text {
      vertical-align: 0.5;
    }

    element selected element-icon,
    element selected element-text {
      background-color: inherit;
      text-color: inherit;
    }
  '';
}
