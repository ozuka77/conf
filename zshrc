#Lookin ~/.oh-my-zsh/themes/
export ZSH=$HOME/.oh-my-zsh
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="gentoo"
#ZSH_THEME="muse"

#ZSH_THEME="miloshadzic"

ZSH_THEME="agnoster"
setopt correctall
autoload -U compinit
compinit
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
# très utile pour les complétion qui demandent beaucoup de temps
# # comme la recherche d'un paquet aptitude install moz<tab>
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache
export GREP_COLOR=31
alias grep='grep --color=auto'


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git nmap colored-man colorize cp extract docker tmux z systemd dirhistory systemadmin battery themes)

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias au="sudo apt-get update"
alias ai="sudo apt-get install"
alias acs="axi-cache search"
alias sh="sudo shutdown -r now"
alias zsh="vim ~/.zshrc"
alias rzsh="source ~/.zshrc"
alias ..="cd .."
alias ....="cd ../.."
alias lsh="ls -hl"
alias la="ls -la"

#alias grc color
alias ping="grc ping"
alias traceroute="grc traceroute"
alias netstat="grc netstat"
alias ifconfig="sudo grc ifconfig"
alias iwconfig="sudo grc iwconfig"
alias tail="sudo grc tail"

# generate a dated .bak from file
function bak() { cp $1 $1_`date +%Y-%m-%d_%H:%M:%S`.bak ; }

# SUDO

sudo-command-line() {
[[ -z $BUFFER ]] && zle up-history
[[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
zle end-of-line
}
zle -N sudo-command-line
# Defined shortcut keys: [Esc] [Esc]
bindkey "\e\e" sudo-command-line

#history

alias h='history'
function hs
{
history | grep $*
}
alias hsi='hs -i'

# web_search from terminal
function web_search() {
# get the open command
local open_cmd
if [[ "$OSTYPE" = darwin* ]]; then
open_cmd='open'
else
open_cmd='xdg-open'
fi
# check whether the search engine is supported
if [[ ! $1 =~ '(google|bing|yahoo|duckduckgo)' ]];
then
echo "Search engine $1 not supported."
return 1
fi
local url="http://www.$1.com"
# no keyword provided, simply open the search engine homepage
if [[ $# -le 1 ]]; then
$open_cmd "$url"
return
fi
if [[ $1 == 'duckduckgo' ]]; then
#slightly different search syntax for DDG
url="${url}/?q="
else
url="${url}/search?q="
fi
shift # shift out $1
while [[ $# -gt 0 ]]; do
url="${url}$1+"
shift
done
url="${url%?}" # remove the last '+'
nohup $open_cmd "$url" >/dev/null 2&>1
}
alias bing='web_search bing'
alias google='web_search google'
alias yahoo='web_search yahoo'
alias ddg='web_search duckduckgo'
#add your own !bang searches here
alias wiki='web_search duckduckgo \!w'
alias news='web_search duckduckgo \!n'
alias youtube='web_search duckduckgo \!yt'
alias map='web_search duckduckgo \!m'
alias image='web_search duckduckgo \!i'
alias ducky='web_search duckduckgo \!'
alias vi='vim'
alias rscp='rsync -aP'
alias rsmv='rsync -aP --remove-source-files'
alias pulse='sudo killall -9 pulseaudio'

# infos ----------------------------------------------------------------
#normal colors
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
green='\e[0;32m'
yellow='\e[0;33m'

# text bright colors
bred='\e[0;91m'
bblue='\e[0;94m'
bcyan='\e[0;96m'
bgreen='\e[0;92m'
byellow='\e[0;93m'
bwhite='\e[0;97m'

# reset color
NC='\e[0m'

# generate space report
function space() { du -skh * | sort -hr ; }
# disk usage
function dduse() { echo -e " `df -h | grep sda1 | awk '{print $5}'` used -- `df -h | grep sda1 | awk '{print $4}'` free"; }
# mem usage
function mmuse() { echo -e " `free -m | grep buffers/cache | awk '{print $3}'` used -- `free -m | grep buffers/cache | awk '{print $4}'` free"; }
# temps
function temps() { echo -e " cpu: `sensors | grep temp1 | tail -n1 | awk '{print $2}'` -- hdd: +`sudo hddtemp /dev/sda | awk '{print $3}'`"; }
# processes
function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

# hardware -------------------------------------------------------------
# processor
function core() { cat /proc/cpuinfo | grep "model name" | cut -c14- ; }
# graphic card
function graph() { lspci | grep -i vga | cut -d: -f3 ; }
# ethernet card
function ethcard() { lspci | grep -i ethernet | cut -d: -f3 ; }
# wireless card
function wfcard() { lspci | grep -i network | cut -d: -f3 ; }

# battery --------------------------------------------------------------
function batt()
{
    # check main battery
    B0CHG=$(cat /sys/class/power_supply/BAT1/status)
    B0FULL=$(cat /sys/class/power_supply/BAT1/energy_full)
    B0NOW=$(cat /sys/class/power_supply/BAT1/energy_now)
    B0PERC=$(( (( $B0NOW * 100 )) / $B0FULL ))
    # check dockstation battery
    if [ -d /sys/class/power_supply/BAT2 ];then
        B2CHG=$(cat /sys/class/power_supply/BAT2/status)
        B2FULL=$(cat /sys/class/power_supply/BAT2/energy_full)
        B2NOW=$(cat /sys/class/power_supply/BAT2/energy_now)
        B2PERC=$(( (( $B2NOW * 100 )) / $B2FULL ))

        B2STA=$(echo -e "${blue}/$NC dock: $B2CHG - $B2PERC %")
    else
        B2STA=
    fi
    # output
    echo -e " main: $B0CHG - $B0PERC % $B2STA"
}

# local ip address -----------------------------------------------------
function my_lip()
{
    # wired interface
    if [ "$(cat /sys/class/net/eth0/operstate)" = "up" ];then
        MY_ETH0IP=$(sudo /sbin/ifconfig eth0 | awk '/inet/ {print $2}' | sed -e s/addr://)
    else
        MY_ETH0IP=$(echo "not connected")
    fi
    # wireless interface
    if [ "$(cat /sys/class/net/wlan0/operstate)" = "up" ];then
        MY_ETH1IP=$(sudo /sbin/ifconfig wlan0 | awk '/inet/ {print $2}' | sed -e s/addr://)
    else
        MY_ETH1IP=$(echo "not connected")
    fi
    # output
    echo -e " wired: $MY_ETH0IP -- wireless: $MY_ETH1IP"
}

# public ip address ----------------------------------------------------
function my_eip()
{
    if [ "$(cat /sys/class/net/eth0/operstate)" = "up" ] || [ "$(cat /sys/class/net/wlan0/operstate)" = "up" ];then
	    MY_EXIP=$(curl -s checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
    else
        MY_EXIP=$(echo "not connected")
    fi
    # output
    echo -e " $MY_EXIP"
}

# openports ------------------------------------------------------------
function oports() { sudo netstat -nap --inet | head -n 18 | ccze -A; }

# infobox --------------------------------------------------------------
function ii()
{
    echo
    echo -e "${red}                                                          ┌─────────────────────────┐"
    echo -e "${red}┌─────────────────────────────────────────────────────────┤$NC      Debian InfoBox    ${red} │"
    echo -e "${red}│          ┌───────────────────────┐                      └────────────┬────────────┘"
    echo -e "${red}├──────────┤${bblue} Toshiba Tecra M11-18T${red} ├───────────────────────────────────┘"
    echo -e "${red}│          └───────────────────────┘"
    echo -e "${red}│${blue}┌── agenda ────────────────────────────────────────────────────────────"
    echo -e "${red}│${blue}└$NC `date +'%A, %B %-d, %Y -- %I:%M %P'`"
    echo -e "${red}│${bblue}┌── processor information ─────────────────────────────────────────────"
    echo -e "${red}│${bblue}└$NC `core`"
    echo -e "${red}│${bblue}┌── graphic information ───────────────────────────────────────────────"
    echo -e "${red}│${bblue}└$NC`graph`"
    echo -e "${red}│${bblue}┌── ethernet information ──────────────────────────────────────────────"
    echo -e "${red}│${bblue}└$NC`ethcard`"
    echo -e "${red}│${bblue}┌── wireless information ──────────────────────────────────────────────"
    echo -e "${red}│${bblue}└$NC`wfcard`"
    echo -e "${red}│          ┌─────────────────────────────┐"
    echo -e "${red}├──────────┤${bgreen} Debian GNU/Linux 8.0 Jessie${red} │"
    echo -e "${red}│          └─────────────────────────────┘"
    echo -e "${red}│${yellow}┌── kernel information ────────────────────────────────────────────────"
    echo -e "${red}│${yellow}└$NC `uname -a`"
    echo -e "${red}│${bcyan}┌── machine stats ─────────────────────────────────────────────────────"
    echo -e "${red}│${bcyan}└$NC`uptime`"
    echo -e "${red}│${bgreen}┌── memory stats ──────────────────────────────────────────────────────"
    echo -e "${red}│${bgreen}└$NC`mmuse`"
    echo -e "${red}│${green}┌── disk stats ────────────────────────────────────────────────────────"
    echo -e "${red}│${green}└$NC`dduse`"
    echo -e "${red}│${blue}┌── batt stats ────────────────────────────────────────────────────────"
    echo -e "${red}│${blue}└$NC`batt`"
    echo -e "${red}│${yellow}┌── sensors ───────────────────────────────────────────────────────────"
    echo -e "${red}│${yellow}└$NC`temps`"
    echo -e "${red}│${cyan}┌── local IP address ──────────────────────────────────────────────────"
    echo -e "${red}│${cyan}└$NC`my_lip`"
    echo -e "${red}│${cyan}┌── external IP address ───────────────────────────────────────────────"
    echo -e "${red}│${cyan}└$NC`my_eip`"
    echo -e "${red}│          ┌──────────────────┐"
    echo -e "${red}├──────────┤${bcyan} Open Connections${red} │"
    echo -e "${red}│          └──────────────────┘"
    echo -e "${red}│$NC `oports`"
    echo -e "${red}└────────────────────────────────────────────────────────────────────┤│"
    
}



