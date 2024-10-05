eval "$(/opt/homebrew/bin/brew shellenv)"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_config theme choose "catppuccin mocha"

# Alias
alias ls="lsd"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"

alias cm="chezmoi"
alias tree="tree -CA"
alias less="less -R"
alias printenv="printenv | LC_ALL=C sort"

set -x HOMEBREW_CASK_OPTS "--appdir=~/Applications"

fish_add_path $HOME'/Applications/Docker.app/Contents/Resources/bin'

# Hooks
zoxide init fish | source
starship init fish | source
direnv hook fish | source
fzf --fish | source

source $HOME/.cargo/env.fish

# Transient prompt (Starship command)
enable_transience

# Created by `pipx` on 2024-10-01 10:05:19
set PATH $PATH /Users/sigl/.local/bin
