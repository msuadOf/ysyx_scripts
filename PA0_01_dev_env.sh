#!/bin/sh

sh ./util_env.sh

sudo apt update
sudo apt-get install -y build-essential    # build-essential packages, include binary utilities, gcc, make, and so on
sudo apt-get install -y man                # on-line reference manual
sudo apt-get install -y gcc-doc            # on-line reference manual for gcc
sudo apt-get install -y gdb                # GNU debugger
sudo apt-get install -y git                # revision control system
sudo apt-get install -y libreadline-dev    # a library used later
sudo apt-get install -y libsdl2-dev        # a library used later
sudo apt-get install -y llvm llvm-dev      # llvm project, which contains libraries used later
sudo apt-get install -y llvm-11 llvm-11-dev # only for ubuntu20.04

#vim
sudo apt-get install vim -y

#tmux
sudo apt-get install tmux -y

#<h1>get code</h1>
cd ~
git clone -b master git@github.com:OSCPU/ysyx-workbench.git ysyx-workbench


#<h2>install verilator </h2>
cd ~
sudo apt-get install git perl python3 make autoconf g++ flex bison ccache -y
sudo apt-get install libgoogle-perftools-dev numactl perl-doc -y
sudo apt-get install libfl2 -y # Ubuntu only (ignore if gives error)
sudo apt-get install libfl-dev -y # Ubuntu only (ignore if gives error)
sudo apt-get install zlibc zlib1g zlib1g-dev -y # Ubuntu only (ignore if gives error)
sudo apt install help2man -y
git clone https://github.com/verilator/verilator.git verilator ### Only first time
# Every time you need to build:
unset VERILATOR_ROOT # For bash
cd verilator
git pull # Make sure git repository is up-to-date
#git tag # See what versions exist

#git checkout master # Use development branch (e.g. recent bug fixes)

#git checkout stable # Use most recent stable release

git checkout v5.008 # Switch to specified release version

# ��������·��
sudo mkdir -p /var/cache/swap/
# ���÷����Ĵ�С
# bs=64M�ǿ��С��count=64�ǿ�����������swap�ռ��С��bs*count=32GB
sudo dd if=/dev/zero of=/var/cache/swap/swap0 bs=64M count=512
# ���ø�Ŀ¼Ȩ��
sudo chmod 0600 /var/cache/swap/swap0
# ����SWAP�ļ�
sudo mkswap /var/cache/swap/swap0
# ����SWAP�ļ�
sudo swapon /var/cache/swap/swap0
# �鿴SWAP��Ϣ�Ƿ���ȷ
sudo swapon -s

autoconf # Create ./configure script
./configure # Configure and create Makefile
sudo make -j ${MAX_THREAD} # Build Verilator itself (if error, try just 'make')
sudo make install -j ${MAX_THREAD}

#�ͷ�swap�ռ�
sudo swapoff /var/cache/swap/swap0
sudo rm /var/cache/swap/swap0
sudo swapoff -a

#����vim�﷨����
cp /etc/vim/vimrc ~/.vimrc
cd ~
ls -a
echo "syntax on
set background=dark
filetype plugin indent on
set showmatch
set ignorecase 
set smartcase
set incsearch
set hidden
set autowrite" >> .vimrc

echo 'setlocal noswapfile " ��Ҫ����swap�ļ�
set bufhidden=hide " ��buffer��������ʱ��������
colorscheme evening " �趨��ɫ����
set number " ��ʾ�к�
set cursorline " ͻ����ʾ��ǰ��
set ruler " ��״̬�����
set shiftwidth=2 " �趨 << �� >> �����ƶ�ʱ�Ŀ��Ϊ 2
set softtabstop=2 " ʹ�ð��˸��ʱ����һ��ɾ�� 2 ���ո�
set tabstop=2 " �趨 tab ����Ϊ 2
set nobackup " �����ļ�ʱ������
set autochdir " �Զ��л���ǰĿ¼Ϊ��ǰ�ļ����ڵ�Ŀ¼
set backupcopy=yes " ���ñ���ʱ����ΪΪ����
set hlsearch " ����ʱ������ʾ���ҵ����ı�
set noerrorbells " �رմ�����Ϣ����
set novisualbell " �ر�ʹ�ÿ�������������
set t_vb= " �ÿմ����������ն˴���
set matchtime=2 " ������ת��ƥ�����ŵ�ʱ��
set magic " ����ħ��
set smartindent " ��������ʱʹ�������Զ�����
set backspace=indent,eol,start " ���趨�ڲ���״̬�޷����˸���� Delete ��ɾ���س���
set cmdheight=1 " �趨�����е�����Ϊ 1
set laststatus=2 " ��ʾ״̬�� (Ĭ��ֵΪ 1, �޷���ʾ״̬��)
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ Ln\ %l,\ Col\ %c/%L%) " ������״̬����ʾ����Ϣ
set foldenable " ��ʼ�۵�
set foldmethod=syntax " �����﷨�۵�
set foldcolumn=0 " �����۵�����Ŀ��
setlocal foldlevel=1 " �����۵�����Ϊ 1
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR> " �ÿո���������۵�' >> .vimrc

#tmux
apt-get install tmux -y
cd ~
echo -e 'bind-key c new-window -c "#{pane_current_path}" '> .tmux.conf
echo -e 'bind-key % split-window -h -c "#{pane_current_path}"'>> .tmux.conf
echo -e "bind-key '\"' split-window -c \"#{pane_current_path}\" ">> .tmux.conf 
