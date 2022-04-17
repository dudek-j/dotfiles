#ZSH
export ZSH=$HOME/.oh-my-zsh

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

plugins=(
  git 
  osx
)

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
alias cat='bat'
alias ping='prettyping --nolegend'
alias top='sudo htop'
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
source ~/Documents/Code/dotfiles/scripts/gitgud.sh

# Pure prompt
autoload -U promptinit; promptinit
prompt pure

# Autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Openjdk
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# PyEnv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

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