
# カラースキーム
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

# フォルダを開く
alias o="open ."

# ファイル一覧
alias ll="ls -la"
alias la="ls -a"

# python
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export PYTHONPATH=/Users/tkamada/devtools_bk/llvm/tools/clang/bindings/python:$PYTHONPATH


# android
export ANDROID_HOME=/usr/local/opt/android-sdk
export ANDROID_TOOL=/usr/local/opt/android-sdk/tools:/usr/local/opt/android-sdk/platform-tools
export NDK_ROOT=/usr/local/Cellar/android-ndk/r10e
export ANDROID_NDK_ROOT=$NDK_ROOT
export PATH=$ANDROID_HOME:$ANDROID_TOOL:$NDK_ROOT:~/Library/adb-peco/bin:$PATH
alias restart-adb='adb kill-server; adb start-server'
alias installapp='find ./ -name *.apk | peco | xargs adb install -r'
alias uninstallapp='adbp shell pm list package | sed -e s/package:// | peco | xargs adbp uninstall'
source ~/dotfiles/.gradle-tab-completion.bash

# svn
export SVN_EDITOR=vim

# mysql
#export PATH=$PATH:/opt/local/share/mysql5/mysql

# Java文字コードをutf-8に変更
export DEFAULT_JVM_OPTS="-Dfile.encoding=UTF-8"
export JAVA7_HOME=`/usr/libexec/java_home -v 1.7`
export JAVA8_HOME=`/usr/libexec/java_home -v 1.8`
export PATH=$JAVA7_HOME/bin:$PATH
# vimの設定
PATH="/usr/local/Cellar/macvim-kaoriya/HEAD/MacVim.app/Contents/MacOS:$PATH"
alias mvim='env LANG=ja_JP.UTF-8 /usr/local/Cellar/macvim-kaoriya/HEAD/MacVim.app/Contents/MacOS/mvim "$@"'
alias vim='env LANG=ja_JP.UTF-8 /usr/local/Cellar/macvim-kaoriya/HEAD/MacVim.app/Contents/MacOS/vim "$@"'
case "$(uname)" in

    Darwin) # OSがMacならば
        if [[ -d /usr/local/Cellar/macvim-kaoriya/HEAD/MacVim.app ]]; then # MacVimが存在するならば
            PATH="/usr/local/bin:$PATH"
        fi
        ;;

    *) ;; # OSがMac以外ならば何もしない
esac
function cd () { command cd $@ && pwd && ls -aF ; }


# scala
#export SBT_OPTS="-Dfile.encoding=UTF8 -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256m"

PATH=~/bin:$PATH
#PATH=/usr/local/bin:$PATH

# rbenv
#eval "$(rbenv init -)"
#export PATH="$HOME/.rbenv/shims:$PATH"
#export JRUBY_OPTS="-Xcext.enabled=true"

# tmuxinator
#export EDITOR=/usr/bin/vim
#export SHELL=/bin/bash

### Added by the Heroku Toolbelt
#export PATH="/usr/local/heroku/bin:$PATH"

alias less='/usr/local/Cellar/vim/7.4.922/share/vim/vim74/macros/less.sh'

