set -x HOMEBREW_PREFIX $HOME/.local
set -x HOMEBREW_CASK_OPTS "--appdir=$HOME/Applications"

set SSH_AUTH_SOCK $HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

fish_add_path $HOME'/Applications/Docker.app/Contents/Resources/bin'
fish_add_path $HOME'.local/bin'
fish_add_path $HOME'.docker/bin'
fish_add_path $HOMEBREW_PREFIX'bin'

eval "$(brew shellenv)"

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

# Hooks
zoxide init fish | source
starship init fish | source
direnv hook fish | source
fzf --fish | source

#source $HOME/.cargo/env.fish

# Transient prompt (Starship command)
enable_transience
