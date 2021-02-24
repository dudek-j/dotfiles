#ZSH
export ZSH=$HOME/.oh-my-zsh

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

plugins=(
  git 
  osx
)

# Aliases
alias gs='git status'
alias cat='bat'
alias ping='prettyping --nolegend'
alias top='sudo htop'
alias zshconfig="code ~/.zshrc"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias rm="trash"
alias foam="code ~/Documents/Foam"
alias ll="ls -alhG"

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
