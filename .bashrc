## vim bind
set -o vi

if [ "$(uname)" == 'Darwin' ]; then
    # for Mac

    #alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    #alias vim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    alias vi='vim'

    # ls command colar
    alias ls='ls -G'
    alias ll='ls -lA'
    alias la='ls -A'
    alias sl=ls

    # to boot MacVim with the argument of a new file
    # http://qiita.com/b4b4r07/items/9013e19ba47fd07e87b5
    #MacVim='/Applications/MacVim.app/Contents/MacOS/MacVim'
    #function gvim() {
    #    if [ $# -eq 0 ]; then
    #        # to set MacVim's directory not root one but current one
    #        open -a MacVim `pwd`
    #    elif [ $# -eq 1 ]; then
    #        if [ ! -f "$1" ]; then
    #            touch "$1" || return 1
    #        fi
    #        touch -t $( date -v+1S +'%Y%m%d%H%M' ) ~/.compare
    #        open -a "$MacVim" "$1" && {
    #            sleep 0.2
    #            if [ ~/.compare -ot "$1" ]; then
    #                # 今回起動で新規作成かつ終了後空ファイルなら消す
    #                [ ! -s "$1" ] && rm "$1"
    #            fi
    #            rm ~/.compare
    #        }
    #    else
    #        echo "$@: invalid arguments"
    #        return 1
    #    fi
    #    return 0
    #}

elif [ "$(expr substr $(uname -s) 1 5)"  == 'MINGW' -o "$(expr substr $(uname -s) 1 4)"  == 'MSYS' ]; then
    # for Windows MSYS2

    # move current directory to home one at boot
    cd

    # set mintty color Solarized
    source /etc/mintty-colors-solarized/sol.dark
    # set ls color Solarized
    eval `dircolors /etc/dircolors-solarized/dircolors.ansi-dark`

    alias vi='vim'
    alias g='git'

    # ls command colar
    alias ls='ls --color=auto'
    alias ll='ls -lA'
    alias la='ls -A'
    alias sl=ls

    # for symbolic link on Windows
    export MSYS=winsymlinks:nativestrict

    # for graphical vim
    # export TERM='xterm-256color'
    # display is disturbed when we set xterm-256color, so do following
    alias tmux='tmux -2'

    # youtube_dl
    export PATH=/usr/lib/youtube_dl/bin:$PATH
fi
