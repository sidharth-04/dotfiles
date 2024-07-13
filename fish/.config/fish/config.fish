source ~/.config/fish/fishrc.fish
source ~/.config/fish/functions/utility.fish

fish_config theme choose ayu\ Mirage
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
alias wm="$WINDOWMANAGER"
alias nv="neovide & disown; exit"
alias chmox="chmod +x"
alias top="bashtop"


# Sourcing
function sourceConda
	eval "$($HOME/miniforge3/bin/conda shell.fish hook)"
end
sourceConda

# Shell Config
function fish_greeting
    echo login at (set_color yellow; date +%T; set_color normal) on $hostname
end

set fish_cursor_default block
set fish_cursor_insert line

zoxide init fish | source
