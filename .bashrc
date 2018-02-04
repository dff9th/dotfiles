## vim bind
set -o vi

## MacVim boot
if [ "$(uname)" == 'Darwin' ]; then
    # Mac
    alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    alias vim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
    # alias gvi='open -a /Applications/MacVim.app/Contents/MacOS/MacVim'
    # alias gvim='open -a /Applications/MacVim.app/Contents/MacOS/MacVim'

    ## ls command colar
    alias ls='ls -G'


    # function

    ## MacVim起動を新規ファイル引数に実行できない対策
    ## http://qiita.com/b4b4r07/items/9013e19ba47fd07e87b5
    MacVim='/Applications/MacVim.app/Contents/MacOS/MacVim'
    function gvim() {
        if [ $# -eq 0 ]; then
            # 引数なし起動だとカレントディレクトリがルートになるのでpwdで対策
            open -a MacVim `pwd`
        elif [ $# -eq 1 ]; then
            if [ ! -f "$1" ]; then
                touch "$1" || return 1
            fi
            touch -t $( date -v+1S +'%Y%m%d%H%M' ) ~/.compare
            open -a "$MacVim" "$1" && {
                sleep 0.2
                if [ ~/.compare -ot "$1" ]; then
                    # 今回起動で新規作成かつ終了後空ファイルなら消す
                    [ ! -s "$1" ] && rm "$1"
                fi
                rm ~/.compare
            }
        else
            echo "$@: invalid arguments"
            return 1
        fi
        return 0
    }

    alias gvi='gvim'
elif [ "$(expr substr $(uname -s) 1 5)"  == 'MINGW' ]; then
    # MSYS2
    # minttyのカラー設定をSolarizedに
    source /etc/mintty-colors-solarized/sol.dark
    # lsの色設定をSolarizedに
    eval `dircolors /etc/dircolors-solarized/dircolors.ansi-dark`

    alias vi='vim'
    # lsを使いやすく
    alias ls='ls --color=auto'
    alias ll='ls -lA'
    alias la='ls -A'
    alias sl=ls
    export MSYS=winsymlinks:nativestrict
fi
