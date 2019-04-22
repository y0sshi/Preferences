#
# Example .zshrc file for zsh 4.0
#
# .zshrc is sourced in interactive shells.  It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#
# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
#limit -s umask 022

# font
export GDFONTPATH=/usr/share/fonts/liberation
export GNUPLOT_DEFAULT_GDFONT=LiberationSans-Regular

# Set up aliases
alias mv='nocorrect mv -i'       # no spelling correction on mv
alias cp='nocorrect cp -i'       # no spelling correction on cp
alias rm='nocorrect rm -i'       # no spelling correction on rm
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias j=jobs
alias pu=pushd
alias po=popd
alias d='dirs -v'
alias h=history
alias ls='ls -F --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -l -a'
alias lal='ls -a -l'
alias x=exit
alias vi="vi -u NONE"
alias gcalc="gnome-calculator"
alias mew='emacs -f mew'
alias pacwin='cat ~/.opt/phoenix/share/PacVim/wingame.log'
#alias ls='sl'
# Set less command
export LESSCHARSET=utf-8

# List only directories and symbolic
# links that point to directories
alias lsd='ls -ld *(-/DN)'

# List only file beginning with "."
alias lsa='ls -ld .*'

# Shell functions
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

# Where to look for autoloaded function definitions
fpath=($fpath ~/.zfunc)

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# Global aliases -- These do not have to be
# at the beginning of the command line.
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'

manpath=(/opt/share/man /usr/share/man)
export MANPATH

# Hosts to use for completion (see later zstyle)
hosts=(`hostname` ftp.math.gatech.edu prep.ai.mit.edu wuarchive.wustl.edu)

# Set prompts
#if [ $TERM = screen ]; then 
#  promptname=$(print "\ek%m\e\\")$USERNAME
#else
#  promptname=$USERNAME
#fi
#PROMPT="%U%B$promptname%b [ %m : %~ ]%u
# "

#PROMPT="%U%B$promptname@%m:%~%b%u 
# "
#

if [ $TERM = screen ]; then 
  promptname=$(print "\ek%m\e\\")$USERNAME
else
  promptname=$USERNAME
fi

PROMPT='%F{green}%U%B%n@%m:%u%f%F{yellow}%~%b%f
 '

#if [ -f ~/.zshTimeRemain ]; then
#  source ~/.zshTimeRemain
#fi

# Some environment variables
export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs

MAILCHECK=0
HISTSIZE=200
DIRSTACKSIZE=20

# Watch for my friends
# watch=( $(<~/.friends) )       # watch for people in .friends file
# watch=(notme)                   # watch for everybody but me
# LOGCHECK=300                    # check every 5 min for login/logout activity
# WATCHFMT='%n %a %l from %m at %t.'

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
setopt   ignoreeof
unsetopt bgnice autoparamslash

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

# bindkey -v               # vi key bindings

bindkey -e                 # emacs key bindings
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search
bindkey '^W' backward-kill-word

# Some nice key bindings
#bindkey '^X^Z' universal-argument ' ' magic-space
#bindkey '^X^A' vi-find-prev-char-skip
#bindkey '^Xa' _expand_alias
#bindkey '^Z' accept-and-hold
#bindkey -s '\M-/' \\\\
#bindkey -s '\M-=' \|

# Setup new style completion system. To see examples of the old style (compctl
# based) programmable completion, check Misc/compctl-examples in the zsh
# distribution.
autoload -U compinit
compinit

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

# enviroment variables
export XMODIFIERS="@im=ibus"
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"
export JSERVER="localhost"

if [ $OSTYPE = linux-gnu -o $OSTYPE = linux ]; then ### CADENCE IUS
  ### CADENCE IUS
  ##export CDS_INST_DIR=/home/cad/cadence-incisiv-15.20.020
  export CDS_INST_DIR=/home/cad/cadence-xcelium-18.09.001
  export PATH=$PATH:$CDS_INST_DIR/tools/bin
  export CDS_LIC_FILE=5280@vdec-cad1:5280@vdec-cad2:5280@vdec-cad3
  export INCA_64BIT=1

  ### ALTERA Quartus
  ##export QUARTUS_ROOTDIR=/home/cad/altera-quartus-pro-18.0/quartus
  ##export SOPC_KIT_NIOS2=/home/cad/altera-quartus-pro-18.0/nios2eds
  ##export MODELSIM_AproDIR=/home/cad/altera-quartus-pro-18.0/modelsim_ase

  ##export QUARTUS_ROOTDIR=/home/cad/altera-quartus-se-17.1/quartus
  ##export SOPC_KIT_NIOS2=/home/cad/altera-quartus-se-17.1/nios2eds
  ##export MODELSIM_ASEDIR=/home/cad/altera-quartus-se-17.1/modelsim_ase

  # DE2-115
  export QUARTUS_ROOTDIR=/home/cad/altera-quartus-se-16.1.2/quartus
  export SOPC_KIT_NIOS2=/home/cad/altera-quartus-se-16.1.2/nios2eds
  export MODELSIM_ASEDIR=/home/cad/altera-quartus-se-16.1.2/modelsim_ase

  # NU Board
  ##export QUARTUS_ROOTDIR=/home/cad/altera-quartus-13.0.1/quartus
  ##export SOPC_KIT_NIOS2=/home/cad/altera-quartus-13.0.1/nios2eds
  ##export MODELSIM_ASEDIR=/home/cad/altera-quartus-13.0.1/modelsim_ase

  export PATH=$PATH:$QUARTUS_ROOTDIR/bin
  export PATH=$PATH:$SOPC_KIT_NIOS2/bin
  export PATH=$PATH:$MODELSIM_ASEDIR/bin
  export QUARTUS_MWWM="allwm"
  export LM_LICENSE_FILE=1800@133.45.242.192

  ### Vivado 
  #export PATH=/home/cad/xilinx-vivado-2017.2/Vivado/2017.2/bin:$PATH
  #export PATH=/home/cad/xilinx-vivado-2018.2/Vivado/2018.2/bin:$PATH
  export PATH=/home/cad/xilinx-vivado-2018.3/Vivado/2018.3/bin:$PATH

  ### Vivado HLS
  #export PATH=/home/cad/xilinx-vivado-2017.2/Vivado_HLS/2017.2/bin:$PATH
  export PATH=/home/cad/xilinx-vivado-2018.3/Vivado_HLS/2018.3/bin:$PATH
fi

export PKG_CONFIG_PATH=/opt/lib/pkgconfig:$PKG_CONFIG_PATH

## screen
 export PATH=~/.opt/bin/screen-v.4.6.2/bin:$PATH
# export SCREENDIR=/var/run/screen/S-naofumi

### PS1 Setting

setxkbmap -layout us
###source ~/.drill_instructor/drill_instructor.zshrc

export PATH=$PATH:$HOME/.script
export LANG=ja_JP.UTF-8

## PacVim
export PATH=$PATH:$HOME/.opt/phoenix/share/PacVim

## setxkb install
export PKG_CONFIG_PATH=$HOME/.opt/phoenix/share/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=$HOME/.opt/phoenix/lib/:$PKG_CONFIG_PATH
