source /etc/bash/colors.sh
source /etc/bash/git-completion.sh
source /etc/bash/git-flow-completion.sh

# Setting PS1
export PS1="\n\[$Blue\]+-[\[$Color_Off\]\[$Yellow\]\u\[$Color_Off\]\[$Cyan\]@\[$Color_Off\]\[$Yellow\]\h\[$Color_Off\]\[$Blue\]]-[\[$Color_Off\]\[$White\]\w\[$Color_Off\]\[$Blue\]]\[$Blue\]-$(__git_ps1 "[\[$Green\]%s\[$Blue\]\[$Blue\]]-")[\[$Color_Off\]\[$Red\]\T\[$Color_Off\]\[$Blue\]]\[$Color_Off\]\n\[$Blue\]+-\[$Red\][\[$Color_Off\]\[$White\]\$\[$Color_Off\]\[$Red\]]› \[$Color_Off\]"

# some more ls aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias l='ls -lha'
alias vim="vim -p"
alias v="vim"
alias cp="cp -i"