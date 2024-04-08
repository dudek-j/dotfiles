# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]

WORKRC="$HOME/Code/dotfiles/workrc"
[ -f $WORKRC ] && source $WORKRC

# # Tmux
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
	tmux a || tmux
fi

# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(macos)
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Gitgud
alias gs='git status'
alias gl='git log --ext-diff'
alias wip="git add -A && git commit -m 'wip'"
source ~/Code/dotfiles/scripts/gitgud.sh

# Brew serach, filter with fzf, and download
bsi () {
  brew install $(brew search $1 | fzf ) 
}

# fg nvim if 
n () {
  ps -o ppid -o comm= -o pid | grep "$$ nvim" | awk '{print $3}' | fg >/dev/null 2>&1 || nvim .
}

# Kitty option-left/right
bindkey "\e[1;3D" backward-word # ⌥←
bindkey "\e[1;3C" forward-word # ⌥→

# Aliases
alias :q='exit'
alias cat='bat --theme="Dracula"'
alias ping='prettyping --nolegend'
alias top='btm'
alias rm="trash"
alias ll="exa -al"
alias ls="exa"

# Autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# macOS
defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES

# JDK
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# Ruby
export BUNDLE_PATH=~/.gems

# GO install env
export PATH=$PATH:/$HOME/go/bin/

# Stack, Haskell
export PATH=$PATH:/$HOME/.local/bin

# Mongod
export PATH="/usr/local/opt/mongodb-community@4.4/bin:$PATH"

# Squeel
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(mise activate zsh)"

# History size
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
