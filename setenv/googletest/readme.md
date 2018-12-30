# googletestセットアップ


## 環境
- CentOS 7.4
- googletest release-1.8.0


## 手順
root で以下実行
```
# curl -OL https://github.com/google/googletest/archive/release-1.8.0.tar.gz
# tar zxf release-1.8.0.tar.gz
# cd googletest-release-1.8.0
# mkdir build
# cd build
# cmake ..
# make
# make install
```
ライブラリのパスが通った状態になるので，テストコードコンパイル時に-Iと-Lオプション必要なし


## 詰まった点
- release-1.8.1でcmakeを実行するとlpthreadが見つからないと表示されエラー
    - release-1.8.0だと発生しないのでひとまず1.8.0を利用


