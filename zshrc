# vim: set et sts=4 ts=4 sw=4 tw=78
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=100000
setopt appendhistory autocd extendedglob
# End of lines configured by zsh-newuser-install

# Use modern completion system
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit
unsetopt menu_complete
unsetopt flow_control
setopt auto_menu
setopt complete_in_word
setopt always_to_end
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
if which dircolors > /dev/null; then
    eval "$(dircolors -b)"
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,ppid,%cpu,tty,cputime,command'

setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY_TIME
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt HIST_BEEP

# Sunrise theme for oh-my-zsh
# Intended to be used with Solarized: http://ethanschoonover.com/solarized
# Color shortcuts
R=$fg_no_bold[red]
G=$fg_no_bold[green]
M=$fg_no_bold[magenta]
Y=$fg_no_bold[yellow]
B=$fg_no_bold[blue]
RESET=$reset_color
if [ "$USER" = "root" ]; then
    PROMPTCOLOR="%{$R%}" PROMPTPREFIX="-!-";
else
    PROMPTCOLOR="" PROMPTPREFIX="---";
fi
local return_code="%(?..%{$R%}%? ↵%{$RESET%})"
# %B sets bold text
PROMPT="%B$PROMPTPREFIX %2~ %{$M%}%B»%b%{$RESET%} "
RPS1="${return_code}"
# End theme

# Up & down arrows search history from beginning of the line
# See https://superuser.com/a/585004 for reference
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Additional search mapping for vi mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
# Common emacs bindings for vi mode
bindkey '\e[3~'   delete-char
bindkey '^A'      beginning-of-line
bindkey '^E'      end-of-line
bindkey '^R'      history-incremental-pattern-search-backward
bindkey '\e.'     insert-last-word
# Tmux home/end
bindkey '\e[1~'      beginning-of-line
bindkey '\e[4~'      end-of-line
# Urxvt
bindkey '\e[7~'      beginning-of-line
bindkey '\e[8~'      end-of-line

# user-friendly command output
export CLICOLOR=1
ls --color=auto &> /dev/null && alias ls='ls --color=auto'
alias grep="grep --color"

# PATH helper functions from http://superuser.com/questions/408912
# is $1 missing from $2 (or PATH) ?
no_path() {
    eval "case :\$${2-PATH}: in *:$1:*) return 1;; *) return 0;; esac"
}
# if $1 exists and is not in path, append it
add_path () {
    [ -d ${1:-.} ] && no_path $* && eval ${2:-PATH}="\$${2:-PATH}:$1"
}
# if $1 is in path, remove it
del_path () {
    no_path $* || eval ${2:-PATH}=`eval echo :'$'${2:-PATH}: |
        sed -e "s;:$1:;:;g" -e "s;^:;;" -e "s;:\$;;"`
}
# if $1 exists and is not in path, prepend it
pre_path () {
    del_path $1
    [ -d ${1:-.} ] && no_path $* && eval ${2:-PATH}="$1:\$${2:-PATH}"
}

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
pre_path "$HOME/bin"
export PATH

export EDITOR=vim
export VISUAL=vim

AGENT_SOCK="$(gpgconf --list-dirs agent-socket)"
if [[ ! -S $AGENT_SOCK ]]; then
    gpg-agent --daemon &>/dev/null
fi
export GPG_TTY=$TTY
# Set SSH to use gpg-agent if it's enabled
GNUPGCONFIG="${GNUPGHOME:-"$HOME/.gnupg"}/gpg-agent.conf"
if [[ -r $GNUPGCONFIG ]] && command grep -q enable-ssh-support "$GNUPGCONFIG"; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    unset SSH_AGENT_PID
fi

# A way to get IP addresses {
	# http://stackoverflow.com/a/13322549/359059
	alias myip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
# }

# jlilja.net {
	alias jln_etatuki="ssh -L 5900:localhost:7000 jyrkililja@server1.jlilja.net"
# }

openssl_check_dates() {
	echo -n | openssl s_client -servername $1 -connect $1:443 2>/dev/null | openssl x509 -noout -dates
}

duh() {
    find "$1" -mindepth 1 -maxdepth 1 -exec du -sh "{}" \; | sort -h
}
