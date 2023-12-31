# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


#custom aliases 
alias space="$HOME/bin/space" 
alias forcerm="sudo  rm -rf -I" 
alias up="uptime -p"
alias memory="watch free -h"
alias verson='lsb_release -a' 
alias installed='apt list --installed'
alias recrm='rm -rI'
alias net='sudo iftop -i wg-mullvad'
alias rsyncmv='rsync -avr --remove-source-files --ignore-existing --progress'
alias sbash='source ~/.bashrc'
alias symlink='ln -sr'
alias showfunc='declare -F' #nothing more than a reminder to refresh foundational knowledge on ... functions
alias yuzu='$HOME/bin/yuzu-mainline-20230531-4e5c0854a.AppImage &'
alias rsyncp='rsync -avr --ignore-existing --progress'
alias b='pushd $HOME/bin/ > /dev/null 2>&1'
alias vlcmulti='$HOME/bin/vlcmulti'
#alias topbin='ls -lt ~/bin | head -10'
alias topdir='ls -lt . | head -25'
alias morecommands='printf "Try 'dusort,' lalias,  'recrm', 'vimcomment', 'vlcmulti' or 'sbash'\n"' 
alias ttyshow='ps $(pgrep Xorg)'
alias bin='$HOME/bin'
alias mv='mv -v'
alias cp='cp -v'
alias ping='$HOME/bin/pingtest'

#function cd() {
#    command cd $HOME/Desktop
#elif [[ "$*" == "De" && -d "De" ]]; then
#    command cd "$@"
#  fi
#}

function cd() {
  if [[ "$*" == "De" && ! -d "De" ]]; then
    command cd ~/Desktop
  else
    command cd "$@"
  fi
}

function cd() {
  if [[ "$*" == "Vi" && ! -d "Vi" ]]; then
    command cd ~/Videos
  else
    command cd "$@"
  fi
}

function cd() {
  if [[ "$*" == "Do" && ! -d "Do" ]]; then
    command cd ~/Documents
  else 
    command cd "$@"
  fi
}   

function cd() {
  if [[ "$*" == "Pr" && ! -d "Pr" ]]; then
    command cd ~/Programs
  else
    command cd "$@"
  fi
}

function cd() {
  if [[ "$*" == "Down" && ! -d "Down" ]]; then
    command cd ~/downloadedmedia
  else
    command cd "$@"
  fi
}

function cd() {
  if [[ "$*" == "Ho" && ! -d "Ho" ]]; then
    command cd $HOME
  else 
    command cd "$@"
  fi
}   

function cd() {
  if [[ "$*" == "Pi" && ! -d "Pi" ]]; then
    command cd ~/Pictures
  else 
    command cd "$@"
  fi
}   

function cd() {
  if [[ "$*" == "Mu" && ! -d "Mu" ]]; then
    command cd ~/Music
  else
    command cd "$@"
  fi
}








function findcut {
    echo "to remove the leading ./ from a file name try the following"
    cat $HOME/.findcut.txt
}


function sitescrapes {
    cd $HOME/Videos/siteScrapes
}

function cutlead {
    sed 's|^~/bin/||' | tr '\0' '\n'
}

#function ping {
#date >> ~/tmp/ping.log
#last_argument="${!#}"
#if [[ $# = 0 ]];then
#    echo "An IP address or host name is required for this command" | tee -a ~/tmp/ping.log
#    echo "================================================" | tee -a ~/tmp/ping.log
#elif [[ $# -gt 0 ]] && /usr/bin/ping "$@"; then
#    echo "Successfully reached host at $last_argument" 
#    echo "================================================" | tee -a ~/tmp/ping.log
#else
#    echo -e "\033[1Afailed to reach host at "$last_argument"" 
#    echo "================================================" | tee -a ~/tmp/ping.log
#fi
#}







#function topbin {
#    ls -lt $HOME/bin | head -10 | less
# }

#progress function 
progress-watch () {
     while : ; do  progress | head -3 ; echo ===============; sleep 14s ; done
}



function lb {
ls $HOME/bin
}


function dusort {
du -ah $1 | grep -E "^[0-9\.]+G" | sort -n | head -n -1   
echo "UPDATED ON $(date)"
echo "ENDS HERE - WAIT FOR NEW SORT"
echo ===========================================
}   







#alias checkip='watch checkip'

#Custom functions 

#function 'r-rm'


function currentTime() { 
(date +"%I:%M %P")}

function sleepnow { 
    while : ; do  echo get more sleep ... now not later ; sleep 13s; done
}



#ls alias second='/media/veracrypt*'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#Custom Greeting - salvaged! 

echo "-----------------------------------------------------"
echo "            _                 _         "
echo "      _   _| |__  _   _ _ __ | |_ _   _ "
echo "     | | | | '_ \| | | | '_ \| __| | | |"
echo "     | |_| | |_) | |_| | | | | |_| |_| |"
echo "      \__,_|_.__/ \__,_|_| |_|\__|\__,_|"
#echo ""
echo "-----------------------------------------------------"
#Daily greeting 
user=$USER 
currentTime=$(date +"%I:%M %P")
today=$(date +"%B %d %Y") #formatting: https://www.javatpoint.com/bash-dat>
lastlogin=$(last | awk 'NR==1 {print $2, $3, $4, $5, $6, $7, $8, $9, $10}')     #| grep $USER | tail -1  | awk '{print """Last login time"": " $4 ", " $5 " " $6 "" ", " $7}')
lastusergrep=$(last | awk 'NR==1 {print $1}')
#logininfo=$(last | awk 'NR==1 {print $2, $3, $4, $5, $6, $7, $8, $9}')
printlast=$(echo $lastusergrep)
#echo -e ""
#echo -e ""
#printf "Hello, %s\n" $user
#printf "%s\n" "It is $today at $currentTime" 
#printf "%s\n" "The current time is: $currentTime"
echo -e "Previous user logging in was $printlast\nSession info for $printlast: $lastlogin"                              #printf "%s\n" "Last user logged in: ${lastlogin}"
#echo "$printlast; Details: $lastlogin" 
#printf "Try 'dusort,' lalias,  'recrm', 'vimcomment' or 'sbash'\n" 
printf "type 'errorhelp' to refresh on error handling; also check out 'progress-watch'\n"

#echo -e "NOTE: verify hostnames for scp and ssh connections. For example, the PCname Model hostname is host at X.X.1.200"
read -n 1 -r -s -p  "Press any key to continue" #Or try 'morecommands' "
clear 


#go to the top of a long listing per directory arg 
function topfind {
    ls -lt $1 | head 
}

function findtop {
   ls -lt $1 | head
}

function topbin {
    ls -lt ~/bin | head -10
}


function bintop {
    bintop="topbin"
    $bintop
}


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#Python venv paths 

#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/Devel
#source /usr/local/bin/virtualenvwrapper.sh

#Set default provider for vagrant 
export VAGRANT_DEFAULT_PROVIDER=virtualbox

#Block destructive mv attempts which mistake ./ for /* ... and it can get worse 

shopt -s extdebug

checkcommand() {
  if [[ $BASH_COMMAND = 'mv'*' /'*' '* ]]; then
    echo "WARNING - DESTRUCTIVE COMMAND: suppressing mv command with root directory combined with wildcard" >&2
    return 1
  elif [[ $BASH_COMMAND = 'rm -rf /'* ]]; then
    echo "WARNING - DESTRUCTIVE COMMAND: suppressing rm -rf command with root directory" >&2
    return 1
  fi
}

trap checkcommand DEBUG

export PATH="$PATH:/home/username/bin/vagrantBoxScripts"


#if lsof -i -n | grep -i "ssh" | grep -i "ESTABLISHED" >/dev/null 2>&1; then
#  echo -e "\e[33mSSH session is active\e[0m: VERIFY HOST NAME"
#fi

#echo -e "NOTE: verify hostnames for \e[36mscp and ssh\e[0m connections. For example, the PCname Model hostname is host at X.X.1.200"

#echo -e "NOTE: verify hostnames for \e[36mscp\e[0m and \e[36mssh\e[0m connections. For example, the PCname Model hostname is host at X.X.1.200"

#echo -e "REMEMBER: verify hostnames for ssh protocol connections. PCname Model: host at X.X.1.200" #Plaintext without modified color for key phrases 

#echo -e "\e[33mREMEMBER\e[0m: verify hostnames for ssh protocol connections. PCname Model: host at X.X.1.200"
echo  "Try < morecommands >" #"Info for PCname Model: host at X.X.1.200"
if lsof -i -n | grep -i "ssh" | grep -i "ESTABLISHED" >/dev/null 2>&1; then
  echo -e "\e[33mSSH session is active\e[0m: VERIFY HOST NAME"
fi
echo "Info for hostname: name at 192.X.X.X"






PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
export PATH="$PATH:$HOME/Vagrant"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/pythonscripts"
