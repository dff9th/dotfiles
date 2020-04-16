########################################
# common settings
########################################

# User specific aliases and functions
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# the number of reserving history 
HISTSIZE=500000
export HISTCONTROL=erasedups

# complete command when sudo option is set
complete -cf sudo

# vim bind
set -o vi

# pandoc
GITHUB_CSS="${HOME}/.pandoc/css/github.css"
if [ -e $GITHUB_CSS ]; then
    alias pangit="pandoc -f markdown -t html5 -s --self-contained -c ${HOME}/.pandoc/css/github.css"
fi

# vim/nvim
NVIM_PATH='/usr/local/bin/nvim'
if [ -e $NVIM_PATH ]; then
    # exist nvim
    alias vi="nvim"
    alias nvi="nvim"
    export NVIM_HOME="${XDG_CONFIG_HOME}/nvim"
    export GIT_EDITOR='nvim'
elif which vim > /dev/null 2>&1; then
    # not exist nvim
    alias vi='vim'
    export GIT_EDITOR='vim'
fi

# nvm
export NVM_DIR="$XDG_CACHE_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# npm completion
NPM_COMP="$XDG_CACHE_HOME/completion/npm-completion.bash"
if [ -e $NPM_COMP ]; then
    . $NPM_COMP
fi

# rust
export CARGO_HOME="$XDG_CACHE_HOME/cargo"
export RUSTUP_HOME="$XDG_CACHE_HOME/rustup"
[ -s "$CARGO_HOME/bin" ] && export PATH="$CARGO_HOME/bin:$PATH"

# pyenv
if [ -d $XDG_CACHE_HOME/pyenv ]; then
    export PYENV_ROOT="$XDG_CACHE_HOME/pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    #eval "$(pyenv init - --no-rehash)"
    eval "$(pyenv init - --no-rehash)"
fi

# rbenv
export RBENV_ROOT=$XDG_CACHE_HOME/rbenv
if [ -d $XDG_CACHE_HOME/rbenv ]; then
    export PATH="$RBENV_ROOT/bin:$PATH"
    eval "$(rbenv init -)"
fi

# git
alias g='git'

## git completion
GIT_COMP='/usr/local/share/completion/git-completion.bash'
if [ -e $GIT_COMP ]; then
    source $GIT_COMP
    __git_complete g __git_main
fi

## Generate diff files between commit A and B
function makegitdiff() {
    if [ $# -ne 3 ]; then
        echo "[ERROR] Usage: makegitdiff <beforeCommit> <afterCommit> <outputDir>"
        return
    fi
    local bf=$1
    local af=$2
    local outDir=$3
    if [ -e ${outDir} ]; then
        echo "[ERROR] ${outDir} is already existed"
        return 
    else
        mkdir ${outDir}
        git archive --format=tar --prefix=before/ ${bf} `git diff --diff-filter=d --name-only ${af} ${bf}` -o ${outDir}/before.tar
        git archive --format=tar --prefix=after/ ${af} `git diff --diff-filter=d --name-only ${bf} ${af}` -o ${outDir}/after.tar
        tar -xf ${outDir}/before.tar -C ${outDir}
        tar -xf ${outDir}/after.tar -C ${outDir}
        rm ${outDir}/before.tar
        rm ${outDir}/after.tar
    fi
}

## Show all diff between local and tracking branch
function gdab() {
    (
    set -f
    for b in `git branch`; do
        if [ ${b} != '*' ]; then
            echo "############################################################"
            echo "# git diff ${b} origin/${b}"
            echo "############################################################"
            git diff ${b} origin/${b}
        fi
    done
    )
}

# get aws instance's ip 
function awsip() {
    if (($# != 1)); then
        echo "[ERROR] Usage: $FUNCNAME <instance name>" >&2
        return
    fi
    echo $(aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | select(.Tags[].Value == "'$1'") | .PublicIpAddress')
}

# get aws instance's id
function awsid() {
    if (($# != 1)); then
        echo "[ERROR] Usage: $FUNCNAME <instance name>" >&2
        return
    fi
    echo $(aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | select(.Tags[].Value == "'$1'") | .InstanceId')
}

# boot aws instance
function awsstart() {
    if (($# != 1)); then
        echo "[ERROR] Usage: $FUNCNAME <instance name>" >&2
        return
    fi
    aws ec2 start-instances --instance-ids $(awsid $1)
}

# shutdown aws instance
function awsstop() {
    if (($# != 1)); then
        echo "[ERROR] Usage: $FUNCNAME <instance name>" >&2
        return
    fi
    aws ec2 stop-instances --instance-ids $(awsid $1)
}

# For aws instance
function awslocalip() {
    if (($# != 0)); then
        echo "[ERROR] Usage: $FUNCNAME" >&2
        return
    fi
    echo $(curl http://169.254.169.254/latest/meta-data/local-ipv4)
}

################################################################################
# for Mac
################################################################################
if [ "$(uname)" == 'Darwin' ]; then
    # ls alias
    alias ls='ls -G'
    alias ll='ls -lA'
    alias la='ls -A'
    alias sl='ls'

    # prompt
    OS_VERSION="$(sw_vers -productName) $(sw_vers -productVersion)"
    export PS1="\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$OS_VERSION\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n\$ "

################################################################################
# for MSYS2 on Windows
################################################################################
elif [ "$(expr substr $(uname -s) 1 5)"  == 'MINGW' ]; then
    # history front trace
    [ -t 0 ] && stty stop undef
    [ -t 0 ] && stty start undef

    # ls alias
    alias ls='ls --color=auto'
    alias ll='ls -lA'
    alias la='ls -A'
    alias sl='ls'

    ########################################
    # graphic
    ########################################
    # set mintty color Solarized
    source /etc/mintty-colors-solarized/sol.dark
    # set ls color Solarized
    eval `dircolors /etc/dircolors-solarized/dircolors.ansi-dark`
    echo -ne '\eP\e]12;#C0C0C0\a'   # silver cursor
    # prompt custom
    export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$MSYSTEM\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n\[\e[0m\]# '

    ########################################
    # system
    ########################################
    # for symbolic link on Windows
    export MSYS=winsymlinks:nativestrict

    ########################################
    # etc
    ########################################
    # display is disturbed when we set xterm-256color, so do following
    #alias tmux='tmux -2'

    # pandoc alias
    alias pandoc="/c/Users/clouduser/AppData/Local/Pandoc/pandoc.exe"

    # pandoc with github css
    function pangit() {
        local pandoc_cmd="/c/Users/clouduser/AppData/Local/Pandoc/pandoc.exe"
        local github_css="${HOME}/.pandoc/css/github.css"
        ${pandoc_cmd} -f gfm --self-contained -c ${github_css} ${1} -o ${1%.*}.html
    }

    # chrome alias
    alias chrome="/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe"


################################################################################
# for Ubuntu 18.04 / CentOS 7
################################################################################
elif [ "$(expr substr $(uname -s) 1 5)"  == 'Linux' ]; then
    # Ubuntu on wsltty settings
    if [ -e "/proc/sys/fs/binfmt_misc/WSLInterop" ]; then
        # To use pbcopy on tmux
        alias pbcopy="clip.exe"

        # Mintty color theme 
        SOLARIZED_DARK_THEME="$XDG_CACHE_HOME/mintty-colors-solarized/sol.dark"
        if [ -e $SOLARIZED_DARK_THEME ]; then
            source $SOLARIZED_DARK_THEME
        fi

        # Silver cursor
    	echo -ne '\eP\e]12;#C0C0C0\a'

        # X server
        export VETH_WSL_IP=$(netsh.exe interface ip show addresses "vEthernet (WSL)" | grep "IP Address:" | awk 'BEGIN{RS="\r\n"}{print $3}')
        export DISPLAY="${VETH_WSL_IP}:0.0"
        # Do follow command on PowerShell with superuser to enable X Server access from WSL2
        # Set-NetFirewallProfile -Name public -DisabledInterfaceAliases "vEthernet (WSL)" 
    fi

    # Expand path variable with tail '/' and TAB
    shopt -s direxpand

    # History front trace
    [ -t 0 ] && stty stop undef
    [ -t 0 ] && stty start undef

    # prompt
    OS_VERSION=$(cat /etc/os-release | grep PRETTY_NAME | sed -e 's/^.*PRETTY_NAME="\(.*\)".*$/\1/')
    export PS1="\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$OS_VERSION\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n\$ "

    # Color ls
    SOLARIZED_DARK_DIRCOLORS="$XDG_CACHE_HOME/dircolors-solarized/dircolors.ansi-dark"
    if [ -e $SOLARIZED_DARK_DIRCOLORS ]; then
        eval $(dircolors $SOLARIZED_DARK_DIRCOLORS)
    fi

    # ls alias
    alias ls='ls --color=auto'
    alias ll='ls -lA'
    alias la='ls -A'
    alias sl='ls'
fi
