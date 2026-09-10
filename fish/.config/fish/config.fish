source ~/.config/fish/fishrc.fish
source ~/.config/fish/functions/utility.fish

fish_config theme choose ayu\ Dark
fish_config prompt choose astronaut

# Aliases
# general
alias fishconfig="$EDITOR ~/.config/fish/config.fish"
alias sourcefish="source ~/.config/fish/config.fish"
alias nvimconfig="$EDITOR ~/.config/nvim/init.lua"

# paths
alias navprog="cd $HOME/programming"
alias navbooks="cd $HOME/books"

# utility
alias lsa="ls -la"
alias v="cowsay -f vader"
alias sl="ls"
alias mkae="make"
alias cat="bat"
alias nv="neovide & disown; exit"
alias chmox="chmod +x"
alias top="htop"
alias sheets="~/go/bin/sheets"

# Bindings
bind \ek clon

# Sourcing
function sourceConda
	eval "$($HOME/miniforge3/bin/conda shell.fish hook)"
end
# sourceConda

function sourceVulk
	eval "bass source $HOME/vulkan/1.3.290.0/setup-env.sh"
end
# sourceVulk

function sourceCaml
	eval "$(opam env)"
end
# sourceCaml

function nvm
    bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

# Shell Config
function fish_greeting
    echo login at (set_color yellow; date +%T; set_color normal) on $hostname
end

set fish_cursor_default block
set fish_cursor_insert line

zoxide init fish | source

if test -z "$DISPLAY" && tty | grep tty1
    exec Hyprland
end

# Set colorscheme based on wallust
bass cat ~/.cache/wallust/sequences

fish_add_path /opt/cross-compilers/arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-linux-gnu/bin
