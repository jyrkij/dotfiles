# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="sunrise"
# Cool themes: muse, juanghurtado(?), nanotech, sunrise, eastwood, gallois,
# gentoo, kphoen, 

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew brew-cask bundler gem git git-flow git-hubflow git-remote-branch gpg-agent history-substring-search extract npm osx pass pod rails ruby sublime tmux vagrant web-search)

# Input controls
bindkey '^[[1;3D' backward-word    # alt + LEFT
bindkey '^[[1;3C' forward-word     # alt + RIGHT
bindkey '_^?' backward-delete-word # alt + BACKSPACE  delete word backward
bindkey '^[[3;3~' delete-word      # alt + DELETE  delete word forward
bindkey '^[' self-insert           # alt + ENTER  allow multiline input
bindkey '_t' transpose-words

source $ZSH/oh-my-zsh.sh

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

alias gf="git flow"
alias gl="git log --pretty=oneline --decorate=full --abbrev-commit"

function git_log_from() {
    git log --pretty=oneline --abbrev-commit --max-age=`date -j -f "%Y-%m-%d" "$1" "+%s"`
}

if ([[ -d /usr/local/Cellar/ ]])
then
    del_path /usr/local/bin
    del_path /usr/local/sbin
    pre_path /usr/local/bin
    pre_path /usr/local/sbin
    if (brew --prefix coreutils &>/dev/null 2>&1); then
        pre_path "$(brew --prefix coreutils)/libexec/gnubin"
    fi
fi

if (ls --color -d . &>/dev/null 2>&1)
then
    LS_COLOR='--color'
    eval $(dircolors ~/.dir_colors)
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
else
    LS_COLOR='-G'
fi

LS_CMD="ls $LS_COLOR -Fh"

alias ls="$LS_CMD"

# List direcory contents
alias lsa="$LS_CMD -la"
alias l="$LS_CMD -la"
alias ll="$LS_CMD -l"
alias sl="$LS_CMD" # often screw this up

# List directory contents after a 'cd'
function chpwd() {
    emulate -LR zsh
    ls
}

export EDITOR=vim
export VISUAL=vim

alias fs="touch signaturetestfile; gpg -s signaturetestfile; rm signaturetestfile signaturetestfile.gpg"
alias killgpgagent="pkill -u `whoami` gpg-agent; unset GPG_AGENT_INFO SSH_AGENT_PID SSH_AUTH_SOCK; rm ~/.gnupg/gpg-agent.env"
gpg-connect-agent /bye
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# A way to get IP addresses {
    # http://stackoverflow.com/a/13322549/359059
    alias myip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
# }

# A way to upgrade vim with rbenv
alias upgrade_vim="rbenv local system && brew unlink vim && brew install vim --with-override-system-vi --with-python3 --with-cscope --with-lua && rbenv local 2.3.1"

alias upgrade_spf13="sh <(curl https://j.mp/spf13-vim3 -L)"

# Thunderbird
alias thunderbird="open -a Thunderbird"

alias jirc="ssh jyrkililja@server1.jlilja.net -t 'screen -DRUS jyrkililja-irssi'"
alias jln1="ssh root@server1.jlilja.net -t 'byobu'"
alias hp1="ssh jyrkililja@hp1 -t 'tmux attach || tmux'"

# Focus Flow {
    alias backup1.focusflow.net="ssh root@backup1.focusflow.net -t 'screen -DRUS jyrkililja'"
    alias pfactori="ssh root@164.215.38.8 -t 'screen -DRUS jyrkililja'"
    alias dev1="ssh root@dev1.thefactori.com -t 'screen -DRUS jyrkililja'"
    alias flow1="ssh root@server.focusflow.net -t 'screen -DRUS jyrkililja'"
    alias flow2="ssh root@server.focusflow2.net -t 'screen -DRUS jyrkililja'"
    alias flow3="ssh root@server3.focusflow.net -t 'screen -DRUS jyrkililja'"
    alias flow4="ssh root@server4.focusflow.net -t 'screen -DRUS jyrkililja'"
    alias flow5="ssh root@server5.focusflow.net -t 'screen -DRUS jyrkililja'"
    alias flowns1="ssh root@185.123.116.230 -t 'screen -DRUS jyrkililja'"
    alias flowns2="ssh root@77.86.252.138 -t 'screen -DRUS jyrkililja'"
    alias flowns3="ssh root@94.237.28.18 -t 'screen -DRUS jyrkililja'"
    alias aa1="ssh root@aa1.focusflow.net -t 'screen -DRUS jyrkililja'"
    alias git.focusflow.net="ssh root@git.focusflow.net -t 'screen -DRUS jyrkililja'"
    alias mhyp.focusflow.net="ssh root@mhyp.focusflow.net -t 'screen -DRUS jyrkililja'"

    function query_flowns() {
        for i in 1 2 3; do
            dig @ns$i.focusflow.net +short +identify "$@"
        done
    }
# }

# toggle-ansible from Antti Haavikko
toggle-ansible () {
  COLOR='\033[0;33m'
  NC='\033[0m'
  ANSIBLE_VERSION="$(ansible --version)"
  if [[ "$ANSIBLE_VERSION" =~ "1.9" ]]
  then
    echo "\n${COLOR}Linking newest Ansible${NC}"
    brew unlink ansible@1.9 && brew link ansible
  else
    echo "\n${COLOR}Linking Ansible 1.9${NC}"
    brew unlink ansible && brew link ansible@1.9 --force
  fi
}

alias weather="curl wttr.in/Rovaniemi"
alias winger="finger rovaniemi@graph.no"

pre_path "$HOME/.composer/vendor/bin"

# To enable shims and autocompletion add to your profile:
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

pre_path "$HOME/bin"

export PATH

