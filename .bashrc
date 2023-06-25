# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi
export PATH=/home/georgk/.nimble/bin:$PATH
export BUN_INSTALL="/home/georgk/.bun" 
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH=$PATH:/home/georgk/.idris2/bin

export PATH=$PATH:/home/georgk/.pack/bin
unset rc
. "$HOME/.cargo/env"

xmodmap ~/.Xmodmap
