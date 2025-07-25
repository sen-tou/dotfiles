fpath+="$HOME/.zfunc"
if [ -f "$HOME/.path" ]; then
    source "$HOME/.path"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="cypher"

export DISABLE_AUTO_TITLE="true"
export HIST_STAMPS="yyyy-mm-dd"
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
export MANPAGER='nvim +Man!'
export BROWSWER='firefox'
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export EDITOR='nvim'
fi
export TERMINAL='wezterm'

setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY 

zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 14

DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git 
	fzf
	zoxide
	F-Sy-H
	# never use the ssh-agent here as it will intefere with the 
	# native ssh agent e.g. gnome-keyring agent
)

# Plugin Options
ZOXIDE_CMD_OVERRIDE=cd

source $ZSH/oh-my-zsh.sh

# User configuration
export MANPATH="/usr/local/man:$MANPATH"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias v="nvim"
alias gt="git"
alias gts="gt status"
alias gtd="gt diff"
alias gtp="gt push"
alias gta="gt add"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias get_idf='. $HOME/esp/esp-idf/export.sh'
