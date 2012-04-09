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
# DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(osx textmate git brew extract git-flow)

# Input controls
bindkey '^[[1;3D' backward-word    # alt + LEFT
bindkey '^[[1;3C' forward-word     # alt + RIGHT
bindkey '_^?' backward-delete-word # alt + BACKSPACE  delete word backward
bindkey '^[[3;3~' delete-word      # alt + DELETE  delete word forward
bindkey '^[' self-insert           # alt + ENTER  allow multiline input
bindkey '_t' transpose-words

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

alias gf="git flow"
alias gl="git log --pretty=oneline --decorate=full --abbrev-commit"

function git_log_from() {
git log --pretty=oneline --abbrev-commit --max-age=`date -j -f "%Y-%m-%d" "$1" "+%s"`
}

LS_CMD='ls'

if COREUTILS_PREFIX=(brew --prefix coreutils)
then
    # Color listing
    eval $(gdircolors ~/.dir_colors)
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    LS_CMD='gls'
fi

LS_COLOR=''
# Enable ls colors
if [ "$DISABLE_LS_COLORS" != "true" ]
then
    # Find the option for using colors in ls, depending on the version: Linux or BSD
    $($LS_CMD --color -d . &>/dev/null 2>&1) && LS_COLOR='--color' || LS_COLOR='-G'
fi

LS_CMD="$LS_CMD $LS_COLOR -Fh"

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
