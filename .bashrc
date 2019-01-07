# .bashrc

################################################################################
# for MSYS2 on Windows
################################################################################
if [ "$(expr substr $(uname -s) 1 5)"  == 'MINGW' ]; then
    # history front trace
    [ -t 0 ] && stty stop undef
    ########################################
    # common settings
    ########################################
    # the number of reserving history 
    HISTSIZE=50000
    # vim bind
    set -o vi
    # vim alias
    alias vi='vim'
    # ls alias
    alias ls='ls --color=auto'
    alias ll='ls -lA'
    alias la='ls -A'
    alias sl='ls'
    # git command alias
    alias g='git'
    # git diff output files
    function makegitdiff() {
        if [ $# -ne 3 ]; then
            echo "[ERROR] usage: makegitdiff <afterCommit> <beforeCommit> <outputDir>"
            return
        fi
        local af=$1
        local bf=$2
        local outDir=$3
        if [ -e ${outDir} ]; then
            echo "ERROR: ${outDir} is already existed"
            return 
        else
            mkdir ${outDir}
            git archive --format=tar --prefix=after/ ${af} `git diff --diff-filter=d --name-only ${bf} ${af}` -o ${outDir}/after.tar
            git archive --format=tar --prefix=before/ ${bf} `git diff --diff-filter=d --name-only ${af} ${bf}` -o ${outDir}/before.tar
            tar -xf ${outDir}/after.tar -C ${outDir}
            tar -xf ${outDir}/before.tar -C ${outDir}
            rm ${outDir}/after.tar
            rm ${outDir}/before.tar
        fi
    }
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
    # git completion
    source /usr/share/git/completion/git-completion.bash
    __git_complete g __git_main

    ########################################
    # graphic
    ########################################
    # set mintty color Solarized
    source /etc/mintty-colors-solarized/sol.dark
    # set ls color Solarized
    eval `dircolors /etc/dircolors-solarized/dircolors.ansi-dark`
    # prompt custom
    export PS1="\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$MSYSTEM\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n\[\e[0m\]# "

    ########################################
    # system
    ########################################
    # for symbolic link on Windows
    export MSYS=winsymlinks:nativestrict

    ########################################
    # etc
    ########################################
    # display is disturbed when we set xterm-256color, so do following
    alias tmux='tmux -2'

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
# for Mac
################################################################################
elif [ "$(uname)" == 'Darwin' ]; then
    ########################################
    # common settings
    ########################################
    # the number of reserving history 
    HISTSIZE=500000
    # vim bind
    set -o vi
    # vim alias
    alias vi='vim'
    # ls alias
    alias ls='ls --color=auto'
    alias ll='ls -lA'
    alias la='ls -A'
    alias sl='ls'
    # git command alias
    alias g='git'
    # git diff output files
    function makegitdiff() {
        if [ $# -ne 3 ]; then
            echo "[ERROR] usage: makegitdiff <afterCommit> <beforeCommit> <outputDir>"
            return
        fi
        local af=$1
        local bf=$2
        local outDir=$3
        if [ -e ${outDir} ]; then
            echo "ERROR: ${outDir} is already existed"
            return 
        else
            mkdir ${outDir}
            git archive --format=tar --prefix=after/ ${af} `git diff --diff-filter=d --name-only ${bf} ${af}` -o ${outDir}/after.tar
            git archive --format=tar --prefix=before/ ${bf} `git diff --diff-filter=d --name-only ${af} ${bf}` -o ${outDir}/before.tar
            tar -xf ${outDir}/after.tar -C ${outDir}
            tar -xf ${outDir}/before.tar -C ${outDir}
            rm ${outDir}/after.tar
            rm ${outDir}/before.tar
        fi
    }
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


################################################################################
# for CentOS7
################################################################################
else
    ########################################
    # common settings
    ########################################
    # the number of reserving history 
    HISTSIZE=500000
    # vim bind
    set -o vi
    # vim alias
    alias vi='vim'
    # ls alias
    alias ls='ls --color=auto'
    alias ll='ls -lA'
    alias la='ls -A'
    alias sl='ls'
    # git command alias
    alias g='git'
    # git diff output files
    function makegitdiff() {
        if [ $# -ne 3 ]; then
            echo "[ERROR] usage: makegitdiff <afterCommit> <beforeCommit> <outputDir>"
            return
        fi
        local af=$1
        local bf=$2
        local outDir=$3
        if [ -e ${outDir} ]; then
            echo "ERROR: ${outDir} is already existed"
            return 
        else
            mkdir ${outDir}
            git archive --format=tar --prefix=after/ ${af} `git diff --diff-filter=d --name-only ${bf} ${af}` -o ${outDir}/after.tar
            git archive --format=tar --prefix=before/ ${bf} `git diff --diff-filter=d --name-only ${af} ${bf}` -o ${outDir}/before.tar
            tar -xf ${outDir}/after.tar -C ${outDir}
            tar -xf ${outDir}/before.tar -C ${outDir}
            rm ${outDir}/after.tar
            rm ${outDir}/before.tar
        fi
    }
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
    # git completion
    source /usr/share/dotfiles/git-completion.bash
    # Source global definitions
    if [ -f /etc/bashrc ]; then
    	. /etc/bashrc
    fi
    
    # Uncomment the following line if you don't like systemctl's auto-paging feature:
    # export SYSTEMD_PAGER=
    
    # User specific aliases and functions
    export XDG_CONFIG_HOME="$HOME/.config"
    # expand path variable with tail '/' and TAB
    shopt -s direxpand
    
    # pandoc
    alias pangit="pandoc -f markdown -t html5 -s --self-contained -c ${HOME}/.pandoc/css/github.css"
    
    # history front trace
    [ -t 0 ] && stty stop undef
    
    export HISTCONTROL=erasedups
    
    # prompt
    OS_VERSION=`cat /etc/redhat-release`
    #export PS1="\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$OS_VERSION\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n\$ "
    export PS1="\[\e]0;\w\a\]\n\[\e[33m\]\u@\h \[\e[35m\]$OS_VERSION\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n\$ "
    
    # ls command color
    export LS_COLORS="no=00:fi=00:di=34:ow=34;40:ln=35:pi=30;44:so=35;44:do=35;44:"\
    "bd=33;44:cd=37;44:or=05;37;41:mi=05;37;41:ex=01;31:*.cmd=01;31:*.exe=01;31:"\
    "*.com=01;31:*.bat=01;31:*.reg=01;31:*.app=01;31:*.txt=32:*.org=32:*.md=32:"\
    "*.mkd=32:*.h=32:*.hpp=32:*.c=32:*.C=32:*.cc=32:*.cpp=32:*.cxx=32:*.objc=32:"\
    "*.cl=32:*.sh=32:*.bash=32:*.csh=32:*.zsh=32:*.el=32:*.vim=32:*.java=32:"\
    "*.pl=32:*.pm=32:*.py=32:*.rb=32:*.hs=32:*.php=32:*.htm=32:*.html=32:"\
    "*.shtml=32:*.erb=32:*.haml=32:*.xml=32:*.rdf=32:*.css=32:*.sass=32:*.scss=32:"\
    "*.less=32:*.js=32:*.coffee=32:*.man=32:*.0=32:*.1=32:*.2=32:*.3=32:*.4=32:"\
    "*.5=32:*.6=32:*.7=32:*.8=32:*.9=32:*.l=32:*.n=32:*.p=32:*.pod=32:*.tex=32:"\
    "*.go=32:*.sql=32:*.csv=32:*.sv=32:*.svh=32:*.v=32:*.vh=32:*.vhd=32:*.bmp=33:"\
    "*.cgm=33:*.dl=33:*.dvi=33:*.emf=33:*.eps=33:*.gif=33:*.jpeg=33:*.jpg=33:"\
    "*.JPG=33:*.mng=33:*.pbm=33:*.pcx=33:*.pdf=33:*.pgm=33:*.png=33:*.PNG=33:"\
    "*.ppm=33:*.pps=33:*.ppsx=33:*.ps=33:*.svg=33:*.svgz=33:*.tga=33:*.tif=33:"\
    "*.tiff=33:*.xbm=33:*.xcf=33:*.xpm=33:*.xwd=33:*.xwd=33:*.yuv=33:*.aac=33:"\
    "*.au=33:*.flac=33:*.m4a=33:*.mid=33:*.midi=33:*.mka=33:*.mp3=33:*.mpa=33:"\
    "*.mpeg=33:*.mpg=33:*.ogg=33:*.opus=33:*.ra=33:*.wav=33:*.anx=33:*.asf=33:"\
    "*.avi=33:*.axv=33:*.flc=33:*.fli=33:*.flv=33:*.gl=33:*.m2v=33:*.m4v=33:"\
    "*.mkv=33:*.mov=33:*.MOV=33:*.mp4=33:*.mp4v=33:*.mpeg=33:*.mpg=33:*.nuv=33:"\
    "*.ogm=33:*.ogv=33:*.ogx=33:*.qt=33:*.rm=33:*.rmvb=33:*.swf=33:*.vob=33:"\
    "*.webm=33:*.wmv=33:*.doc=31:*.docx=31:*.rtf=31:*.odt=31:*.dot=31:*.dotx=31:"\
    "*.ott=31:*.xls=31:*.xlsx=31:*.ods=31:*.ots=31:*.ppt=31:*.pptx=31:*.odp=31:"\
    "*.otp=31:*.fla=31:*.psd=31:*.7z=1;35:*.apk=1;35:*.arj=1;35:*.bin=1;35:"\
    "*.bz=1;35:*.bz2=1;35:*.cab=1;35:*.deb=1;35:*.dmg=1;35:*.gem=1;35:*.gz=1;35:"\
    "*.iso=1;35:*.jar=1;35:*.msi=1;35:*.rar=1;35:*.rpm=1;35:*.tar=1;35:*.tbz=1;35:"\
    "*.tbz2=1;35:*.tgz=1;35:*.tx=1;35:*.war=1;35:*.xpi=1;35:*.xz=1;35:*.z=1;35:"\
    "*.Z=1;35:*.zip=1;35:*.ANSI-30-black=30:*.ANSI-01;30-brblack=01;30:"\
    "*.ANSI-31-red=31:*.ANSI-01;31-brred=01;31:*.ANSI-32-green=32:*.ANSI-01;"\
    "32-brgreen=01;32:*.ANSI-33-yellow=33:*.ANSI-01;33-bryellow=01;33:"\
    "*.ANSI-34-blue=34:*.ANSI-01;34-brblue=01;34:*.ANSI-35-magenta=35:*.ANSI-01;"\
    "35-brmagenta=01;35:*.ANSI-36-cyan=36:*.ANSI-01;36-brcyan=01;36:"\
    "*.ANSI-37-white=37:*.ANSI-01;37-brwhite=01;37:*.log=01;32:*~=01;32:*#=01;32:"\
    "*.bak=01;33:*.BAK=01;33:*.old=01;33:*.OLD=01;33:*.org_archive=01;33:*.off=01;"\
    "33:*.OFF=01;33:*.dist=01;33:*.DIST=01;33:*.orig=01;33:*.ORIG=01;33:*.swp=01;"\
    "33:*.swo=01;33:*,v=01;33:*.gpg=34:*.gpg=34:*.pgp=34:*.asc=34:*.3des=34:"\
    "*.aes=34:*.enc=34:*.sqlite=34:"
fi

