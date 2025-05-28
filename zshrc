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

# Personal screipts
export PATH="$HOME/.local/bin/personal:$PATH"

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Gitgud
alias gs='git status'
alias gp='git push'
alias gl='git log --ext-diff'
alias gu='gitui'
alias wip="git add -A && git commit -m 'wip'"
source ~/Code/dotfiles/scripts/gitgud.sh

# Source idf if not available
idf () {
  if ! [ -x "$(command -v idf.py)" ]; then
    source ~/esp/export.sh
  else
    echo 'Already sourced' >&2
  fi
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
alias ll="eza -al"
alias ls="eza"

# Autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# macOS
defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES

# Clangd
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# JDK
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# Ruby
export PATH=$PATH:/$HOME/.local/share/gem/ruby/3.3.0/bin

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

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY
