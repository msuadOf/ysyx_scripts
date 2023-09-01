#!/bin/bash

source util_proxy_env.sh
echo $http_proxy

sudo dnf update
sudo dnf install -y build-essential    # build-essential packages, include binary utilities, gcc, make, and so on
sudo dnf install -y man                # on-line reference manual
sudo dnf install -y gcc-doc            # on-line reference manual for gcc
sudo dnf install -y gdb                # GNU debugger
sudo dnf install -y git                # revision control system
sudo dnf install -y libreadline-dev    # a library used later
sudo dnf install -y libsdl2-dev        # a library used later
# sudo dnf install -y llvm llvm-dev      # llvm project, which contains libraries used later
# sudo dnf install -y llvm-11 llvm-11-dev # only for ubuntu20.04
sudo dnf remove -y llvm llvm-dev      # llvm project, which contains libraries used later
sudo dnf remove -y llvm-11 llvm-11-dev # only for ubuntu20.04

#vim
sudo dnf install vim -y

#tmux
sudo dnf install tmux -y


verilator --version
if [ $? -eq 0 ] ; then
  echo "verilator have installed" 
else
    # install verilator v5.008 
    #<h2>install verilator </h2>
    cd ~
    sudo dnf install git perl python3 make autoconf g++ flex bison ccache -y
    sudo dnf install libgoogle-perftools-dev numactl perl-doc -y
    sudo dnf install libfl2 -y # Ubuntu only (ignore if gives error)
    sudo dnf install libfl-dev -y # Ubuntu only (ignore if gives error)
    sudo dnf install zlibc zlib1g zlib1g-dev -y # Ubuntu only (ignore if gives error)
    sudo dnf install help2man -y
    git clone https://github.com/verilator/verilator.git verilator ### Only first time
    # Every time you need to build:
    unset VERILATOR_ROOT # For bash
    cd verilator
    git pull # Make sure git repository is up-to-date
    #git tag # See what versions exist

    #git checkout master # Use development branch (e.g. recent bug fixes)

    #git checkout stable # Use most recent stable release

    git checkout v5.008 # Switch to specified release version

    # 创建分区路径
    sudo mkdir -p /var/cache/swap/
    # 设置分区的大小
    # bs=64M是块大小，count=64是块数量，所以swap空间大小是bs*count=32GB
    sudo dd if=/dev/zero of=/var/cache/swap/swap0 bs=64M count=512
    # 设置该目录权限
    sudo chmod 0600 /var/cache/swap/swap0
    # 创建SWAP文件
    sudo mkswap /var/cache/swap/swap0
    # 激活SWAP文件
    sudo swapon /var/cache/swap/swap0
    # 查看SWAP信息是否正确
    sudo swapon -s

    autoconf # Create ./configure script
    ./configure # Configure and create Makefile
    sudo make -j ${MAX_THREAD} # Build Verilator itself (if error, try just 'make')
    sudo make install -j ${MAX_THREAD}

    #释放swap空间
    sudo swapoff /var/cache/swap/swap0
    sudo rm /var/cache/swap/swap0
    sudo swapoff -a

fi

#配置vim语法高亮
# cp /etc/vim/vimrc ~/.vimrc
# cd ~
# ls -a
# echo "syntax on
# set background=dark
# filetype plugin indent on
# set showmatch
# set ignorecase 
# set smartcase
# set incsearch
# set hidden
# set autowrite" >> .vimrc

# echo 'setlocal noswapfile " 不要生成swap文件
# set bufhidden=hide " 当buffer被丢弃的时候隐藏它
# colorscheme evening " 设定配色方案
# set number " 显示行号
# set cursorline " 突出显示当前行
# set ruler " 打开状态栏标尺
# set shiftwidth=2 " 设定 << 和 >> 命令移动时的宽度为 2
# set softtabstop=2 " 使得按退格键时可以一次删掉 2 个空格
# set tabstop=2 " 设定 tab 长度为 2
# set nobackup " 覆盖文件时不备份
# set autochdir " 自动切换当前目录为当前文件所在的目录
# set backupcopy=yes " 设置备份时的行为为覆盖
# set hlsearch " 搜索时高亮显示被找到的文本
# set noerrorbells " 关闭错误信息响铃
# set novisualbell " 关闭使用可视响铃代替呼叫
# set t_vb= " 置空错误铃声的终端代码
# set matchtime=2 " 短暂跳转到匹配括号的时间
# set magic " 设置魔术
# set smartindent " 开启新行时使用智能自动缩进
# set backspace=indent,eol,start " 不设定在插入状态无法用退格键和 Delete 键删除回车符
# set cmdheight=1 " 设定命令行的行数为 1
# set laststatus=2 " 显示状态栏 (默认值为 1, 无法显示状态栏)
# set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ Ln\ %l,\ Col\ %c/%L%) " 设置在状态行显示的信息
# set foldenable " 开始折叠
# set foldmethod=syntax " 设置语法折叠
# set foldcolumn=0 " 设置折叠区域的宽度
# setlocal foldlevel=1 " 设置折叠层数为 1
# nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR> " 用空格键来开关折叠' >> .vimrc

#tmux
echo ""
echo "install tumx"
sudo dnf install tmux -y
cd ~
echo -e 'bind-key c new-window -c "#{pane_current_path}" '> .tmux.conf
echo -e 'bind-key % split-window -h -c "#{pane_current_path}"'>> .tmux.conf
echo -e "bind-key '\"' split-window -c \"#{pane_current_path}\" ">> .tmux.conf

#llvm
echo ""
echo "install llvm"
cd ~
ls /usr/local/llvm-13.0.1 && llvm-as --version
if [ $? -ne 0 ] ; then

    sudo mkdir -p /usr/local
    sudo rm -f clang+llvm-13.0.1-x86_64-linux-gnu-ubuntu-18.04.tar.xz*
    wget https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.1/clang+llvm-13.0.1-x86_64-linux-gnu-ubuntu-18.04.tar.xz
    tar xvf clang+llvm-13.0.1-x86_64-linux-gnu-ubuntu-18.04.tar.xz
    if [ $? -eq 0 ] ; then
      echo "llvm have download" 

      sudo mv ~/clang+llvm-13.0.1-x86_64-linux-gnu-ubuntu-18.04 /usr/local/llvm-13.0.1
      export PATH="$PATH:/usr/local/llvm-13.0.1/bin"
    
      function addenv() {
        echo 'export PATH="$PATH:/usr/local/llvm-13.0.1/bin"' >> ~/.bashrc
        source ~/.bashrc
        echo "By default this script will add environment variables into ~/.bashrc."
        echo "After that, please run 'source ~/.bashrc' to let these variables take effect."
        echo "If you use shell other than bash, please add these environment variables manually."
      }

      llvm-as --version
      if [ $? -ne 0 ] ; then
          addenv
      fi
    fi
else 
    echo "llvm 13.0.1 is installed"
    llvm-as --version
fi

