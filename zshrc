#ZSH
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

plugins=(macos)
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Functions

## Brew serach, filter with fzf, and download
bsi () {
  brew install $(brew search $1 | fzf ) 
}


## Clone repo and remove git folder 
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
alias gs='git status'
alias gl='git log --ext-diff' alias cat='bat'
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
alias haste="pbpaste | haste | pbcopy"

# Gitgud
source ~/Code/dotfiles/scripts/gitgud.sh

# Pure prompt
fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
prompt pure
zstyle :prompt:pure:git:stash show yes
PURE_GIT_STASH_SYMBOL=🗄

# Autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Openjdk
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# PyEnv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Ruby
export BUNDLE_PATH=~/.gems

# GO install env
export PATH=$PATH:/$HOME/go/bin/

# React Native, Android related exports
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Haste
export HASTE_SERVER="https://paste.dudek.dev/"

# Mongod
export PATH="/usr/local/opt/mongodb-community@4.4/bin:$PATH"

# Python version manager
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

## macOS
defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES

# Tmux
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
	tmux a || tmux
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
