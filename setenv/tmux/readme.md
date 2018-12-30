# msys2上でのtmuxビルド


## 目的
tmux上でvimを起動すると全角記号 (□，✕，→等) を入力すると表示がズレる問題がある．

上記を解決するには，tmuxのソースに有志が公開しているパッチを当ててビルドすればよい．

msys2上のビルドは特に癖が強いため，本書にメモとして残しておく．


## ビルドするバージョン
tmux 2.7


## ビルド方法
1. msys2.exeを起動 (mingw{32,64}.exeではないので注意，Mingwのgccでのビルドは不可)
2. 必要パッケージをインストール
    ```
    # pacman -S patch libevent-devel ncurses-devel \
      make autoconf automake libtool libevent pkg-config
    ```
3. tmuxソース取得，パッチ適用，およびmsys2用修正
    ```
    # git clone https://github.com/tmux/tmux.git
    # git clone https://gist.github.com/z80oolong/e65baf0d590f62fab8f4f7c358cbcc34 tmux-patch
    # cd ./tmux
    # git checkout 2.7
    # patch -p1 < ../tmux-patch/tmux-2.7-fix.diff
    # vi tmux.c
    ```
    - 以下に修正  
    before
    ```
    140:  if (sb.st_uid != uid || (sb.st_mode & S_IRWXO) != 0) {
    ```
    after
    ```
    140:  if (sb.st_uid != uid) {
    ```
4. ビルド
    ```
    # sh autogen.sh
    # ./configure --disable-dependency-tracking && make
    # make install
    ```

- 参考
    - [tmux + Vimで全角記号のずれをなおす](https://you84815.blogspot.com/2018/08/tmux-vim.html)


## 詰まった点


### mingw64.exeから起動 (諦めた)
- `sh autogen.sh`時に`sh: autom4te: コマンドが見つかりません`
    - `pacman -S autoconf`でautoconfもインストール

- `./configure`時に`configure: error: "libevent not found"`
    - `pacman -S mingw-w64-x86_64-libevent`でmingw版libeventをインストール
    - libevent-develをインストールしても解決しない

- `./configure`時に`configure: error: "curses not found`
    - `pacman -S mingw-w64-x86_64-ncurses`でmingw版ncursesをインストール
    - ncurses-develをインストールしても解決しない

- `./configure`時に`configure: error: "CMSG_DATA not found"`

諦めた！！！


### msys2.exeから起動 (頑張った)
- `sh autogen.sh`時に`configure.ac:90: error: possibly undefined macro: AC_SEARCH_LIBS`
    - 以下をpacmanでインストール
        - autoconf
        - automake
        - m4
        - libtool
        - libevent
        - perl
        - pkg-config

- `./configure`時に`configure: error: "libevent not found"`
    - `pacman -S libevent-devel`でlibevent-develをインストール

- `./configure`時に`configure: error: "curses not found`
    - `pacman -S ncurses-devel`でncurses-develをインストール

- `./configure`時に
  ```
    config.status: error: Something went wrong bootstrapping makefile fragments
    for automatic dependency tracking.  Try re-running configure with the
    '--disable-dependency-tracking' option to at least be able to build
    the package (albeit without support for automatic dependency tracking).
  ```
    - `./configure --disable-dependency-tracking`で再実行

- `tmux`実行時に`error creating /tmp//tmux-197609 (Permission denied)`
    - tmux.cを以下のように修正して再make  
    before
    ```
    140:  if (sb.st_uid != uid || (sb.st_mode & S_IRWXO) != 0) {
    ```
    after
    ```
    140:  if (sb.st_uid != uid) {
    ```
    - 参考
        - [msys2のtmuxに手を入れて云々かんぬん](https://blog.tizen.moe/entry/2015/07/07/000000_72)  
        - [tmux-git: can't create socket: Permission denied #271](https://github.com/Alexpux/MSYS2-packages/issues/271I)
        - [Merge pull request #286 from moguriso/tmux_modify](https://github.com/Alexpux/MSYS2-packages/commit/86c42fda848546a729bb3a76372c15d7d41f6d6c)


やったぜ
