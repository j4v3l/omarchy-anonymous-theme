# ============================================================
# Advanced Arch Linux .bashrc (Starship + Alacritty Edition)
# Author: j4v3l
# ============================================================

# ---- Environment Setup ----
export EDITOR="nvim"
export VISUAL="nvim"

export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=10000
export HISTFILESIZE=20000
shopt -s histappend
shopt -s checkwinsize
shopt -s autocd             # just type dir name to cd
shopt -s globstar           # recursive globbing: **/*.txt
set -o noclobber            # prevent overwriting with '>'
set -o vi                   # enable vi mode for shell input

# Use Starship prompt
eval "$(starship init bash)"

# ---- Aliases ----
# ls / navigation
alias ll='ls -alF --color=auto'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cls='clear'

# Reload bashrc
alias refresh='source ~/.bashrc && echo "🔄 .bashrc reloaded (j4v3l)"'

# Safer rm, cp, mv
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Arch package management
alias update='sudo pacman -Syu'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'
alias search='pacman -Ss'
alias list='pacman -Qe'

# Networking & system
alias myip='curl ifconfig.me'
alias ports='sudo lsof -i -P -n | grep LISTEN'
alias topcpu='ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head'

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'

# Rerun last command with sudo
alias please='sudo $(fc -ln -1)'

# Quick local server
alias serve='python3 -m http.server 8000'

# ---- Functions ----
mkcd () {
  mkdir -p "$1" && cd "$1"
}

extract () {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.tar.xz)    tar xf "$1"    ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"   ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *)           echo "Unknown archive format: $1" ;;
    esac
  else
    echo "$1 is not a valid file"
  fi
}

psgrep () {
  ps aux | grep -i --color=auto "$1"
}

hgrep () {
  history | grep "$1"
}

biggest () {
  du -ah . | sort -rh | head -n ${1:-20}
}

jump () {
  cd "$(find . -type d -name "$1" -print -quit)"
}

timer () {
  start=$(date +%s)
  "$@"
  end=$(date +%s)
  echo "Command took $((end-start)) seconds."
}

# ---- Custom Aliases File ----
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# ---- Enable bash completion ----
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi
