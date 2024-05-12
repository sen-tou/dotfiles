export DISABLE_AUTO_TITLE="true"
export HIST_STAMPS="yyyy-mm-dd"
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY 

fpath+="$HOME/.zfunc"
autoload -Uz compinit && compinit

if [ -f "$HOME/.path" ]; then
    source "$HOME/.path"
fi

# styles
zstyle ':completion:*' menu select # selectable menu
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'  # case insensitive completion
zstyle ':completion:*' special-dirs true # Complete . and .. special directories
zstyle ':completion:*' list-colors '' # colorize completion lists
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01' # colorize kill list

# plugins
[ -f zsh_plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ] && source zsh_plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
[ -f zsh_plugins/z/zsh-z.plugin.zsh ] && source zsh_plugins/z/zsh-z.plugin.zsh
[ -f zsh_plugins/abbr/zsh-abbr.plugin.zsh ] && source zsh_plugins/abbr/zsh-abbr.plugin.zsh
[ -f zsh_plugins/autosuggestions/zsh-autosuggestions.plugin.zsh ] && source zsh_plugins/autosuggestions/zsh-autosuggestions.plugin.zsh
# fzf
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

autoload -Uz compinit && compinit

bindkey '\t' complete-word
bindkey '^[[Z' autosuggest-accept


eval "$(starship init zsh)"
