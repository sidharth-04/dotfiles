function ..    ; cd .. ; end
function ...   ; cd ../.. ; end

function take
	mkdir $argv && cd $argv
end

function open
	zathura $argv & disown
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

function screenshot
	slurp | grim -g - "$HOME/downloads/$(date +'screenshot_%Y-%m-%d-%H-%M.png')"
end
