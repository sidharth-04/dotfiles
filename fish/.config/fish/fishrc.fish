set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx ZDOTDIR "$XDG_CONFIG_HOME/zsh"
set -gx EDITOR "nvim"
set -gx EMULATOR "alacritty"
set -gx BROWSER "firefox"
set -gx WINDOWMANAGER "Hyprland"
set -gx FILEMANAGER "nautilus"
set -gx LAUNCHER "fuzzel"
set -gx GTK_THEME Adwaita:dark

set -a PATH "$HOME/.local/bin"
set -a PATH "$HOME/.cargo/bin"
