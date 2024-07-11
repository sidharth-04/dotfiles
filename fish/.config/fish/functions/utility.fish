function ..    ; cd .. ; end
function ...   ; cd ../.. ; end

function take
	mkdir $argv && cd $argv
end

function open
	zathura $argv & disown
end

function clon
	$EMULATOR & disown
end

function pactivate
	source $argv/bin/activate
end

function bat
	cat /sys/class/power_supply/BAT0/capacity
end

function vol
	wpctl set-volume @DEFAULT_SINK@ $argv
end

function getvol
	wpctl get-volume @DEFAULT_SINK@
end

function screenshot
	slurp | grim -g - "/home/sidharth/downloads/$(date +'screenshot_%Y-%m-%d-%H-%M.png')"
end
