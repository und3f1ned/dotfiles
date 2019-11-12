# sh.vim: bash

if tput setaf 1 &> /dev/null; then
  tput sgr0
  COLOR_GREEN=$(tput setaf 72)
  COLOR_YELLOW=$(tput setaf 178)
  COLOR_MAGENTA=$(tput setaf 98)
  COLOR_CYAN=$(tput setaf 111)
  COLOR_RESET=$(tput sgr0)
else
  COLOR_GREEN=$'\033[1;32m'
  COLOR_YELLOW=$'\033[1;33m'
  COLOR_MAGENTA=$'\033[1;35m'
  COLOR_CYAN=$'\033[1;36m'
  COLOR_RESET=$'\033[m'
fi

function parse_git_dirty() {
    ! [[ $(git status 2> /dev/null | tail -n1) =~ (working (directory|tree) clean) ]] && echo "*"
}

function parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

export PS1="\[${COLOR_CYAN}\]\u\[$COLOR_MAGENTA\]@\h \[$COLOR_YELLOW\]\w\[$COLOR_RESET\] \[$COLOR_GREEN\]\$(parse_git_branch)\[$COLOR_RESET\]\n\$ "
export PS2="\[$COLOR_RESET\]→ "
