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

# Clone repo and remove git folder 
degit () {
  projname=$(basename $1 .git)
  git clone $1 $2

  if test -z $2
  then
      rm -rf ./$projname/.git
  else
      rm -rf ./$2/.git
  fi
}

# Aliases
alias cat='bat'
alias ping='prettyping --nolegend'
alias top='btm'
alias zshconfig="code ~/.zshrc"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias rm="trash"
alias foam="code ~/Documents/Foam"
alias ll="exa -al"
alias ls="exa"
alias slink="xcrun simctl openurl booted"
alias slinkp="pbpaste && pbpaste | xargs xcrun simctl openurl booted"

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

# Python version manager
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
