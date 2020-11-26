# jyrki@jlilja.net’s dotfiles

## Requirements

At this point you’ll most likely need more than what is listed here:

- zsh as login shell
- tmux and [tmux-plugin-manager](https://github.com/tmux-plugins/tpm)
- gpg version >= 2.1
- git
- [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)

### Ubuntu

Install the following packages:

```
sudo apt install \
    sway \
    swayidle \
    swaylock \
    wofi \
    kitty \
    vifm \
    imagemagick \
    xwayland \
    brightnessctl \
    mako-notifier \
    apparmor-utils \
    qutebrowser \
    qtwayland5
pip3 install \
    autotiling \
    wpgtk
```

Some quirks to note:

- https://github.com/emersion/mako/issues/257

### OS X

- [brew](https://brew.sh)
- reattach-to-user-namespace

## Installation

1. Clone this repo to `~/dotfiles`.
2. Install [rcm](https://github.com/thoughtbot/rcm)
3. Run `env RCRC=$HOME/dotfiles/rcrc rcup`
