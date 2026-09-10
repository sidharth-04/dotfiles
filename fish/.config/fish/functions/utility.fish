function ..    ; cd .. ; end
function ...   ; cd ../.. ; end

function take
	mkdir $argv && cd $argv
end

function open
	xdg-open $argv & disown
end

function browse
	$FILEMANAGER $argv & disown
end

function clon
	$EMULATOR & disown
end

function pactivate
	source $argv/bin/activate
end

function mux
	if count $argv > /dev/null
		bash ~/misc/scripts/tmux/tmux-$argv.sh
	end
end

function fish_command_not_found
    __fish_default_command_not_found_handler $argv
end
