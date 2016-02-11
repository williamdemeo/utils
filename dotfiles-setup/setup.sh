#!/bin/bash
# Simple setup.sh for configuring Ubuntu 14.04 LTS EC2 instance
# for headless setup. 
# Originally copied from the Stanford Startup course and then modified
# by William DeMeo <williamdemeo@gmail.com>
# Date: 2013.07.14
# Last Modified: 2014.06.27

echo
echo 'This script will install/configure some useful tools on a Ubuntu Linux machine.'
echo
echo 'Here is a summary of what will be installed:'
echo
echo '    1.  git-core (main components required to use Git version control software)'
echo '    2.  emacs24 (a recent release of Emacs) and emacs-goodies-el'
echo '    3.  dotfiles.wjd (configuration files; see: https://github.com/williamdemeo/dotfiles.wjd'
echo '        .profile, .bashrc, .bash_aliases, .bash_profile, .bashrc_custom, .screenrc, .emacs.'
echo '    4.1  Java               openjdk-7-jdk (unless a suitable JRE is already present)'
echo '    4.2  Scala Build Tool   sbt-0.13.2 (unless sbt is already in the path)'
echo '    4.3  Eclipse            scala-SDK-3.0.3-2.10-linux.gtk.x86_64 (a version of Eclipse IDE with Scala support)'
echo ' '
echo '    Optionally, the following may be installed:'
echo ' '
echo '    5.1  Proof General '
echo '    5.2  Coq'
echo '    5.3  Agda'
echo ' '
echo
read -p 'Abort this setup script? [Y/n]' -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]] 
then
    echo
    echo 'Setup aborted.'
    echo
    exit
fi
echo

echo
echo '###############################################################################'
echo
echo '    1.  git-core (main components required to use Git version control software)'
echo
sudo apt-get install -y git-core

echo
echo '###############################################################################'
echo
echo '    2.  emacs24 (a recent release of Emacs) and emacs-goodies-el'
echo
# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo apt-add-repository -y ppa:cassou/emacs
sudo apt-get update
sudo apt-get install -y emacs24 emacs24-el emacs24-common-non-dfsg
sudo apt-get install emacs-goodies-el

echo
echo '###############################################################################'
echo
echo '    3.  dotfiles.wjd (configuration files; see: https://github.com/williamdemeo/dotfiles.wjd'
echo
cd $HOME
dotfiles_path=$HOME'/.dotfiles.wjd'

# Check for pre-existing .dotfiles.wjd directory
# If one exists, ask whether to rename it and continue. (Otherwise, abort.)
if [ -d $dotfiles_path/ ]; then
    echo
    echo '    Directory '$dotfiles_path' already exists...'
    read -p '    Rename it? [Y/n]' -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
	mv $dotfiles_path $dotfiles_path'_backup_'$(date +'%Y%m%d:%H:%M')

	# Also move pre-existing dotfiles.wjd out of the way:
	if [ -d $HOME'/dotfiles.wjd' ]; then
	    mv $HOME'/dotfiles.wjd' $HOME'/dotfiles.wjd.tmp'
	fi

	# Get the dotfiles.wjd repository, then rename it to keep $HOME looking cleaner:
	git clone https://github.com/williamdemeo/dotfiles.wjd.git
	cd dotfiles.wjd
	git remote set-url origin git@github.com:williamdemeo/dotfiles.wjd.git
	cd 
	mv dotfiles.wjd .dotfiles.wjd 

	# Restore possibly pre-existing dotfiles.wjd:
	if [ -d $HOME'/dotfiles.wjd.tmp' ]; then
	    mv $HOME'/dotfiles.wjd.tmp' $HOME'/dotfiles.wjd'
	fi

	# Create the required links.
	# (If a file or link of that name exists, rename it with .orig extension.)
	ln -sb --suffix='.orig' ~/.dotfiles.wjd/screenrc ~/.screenrc
	ln -sb --suffix='.orig' ~/.dotfiles.wjd/bashrc.wjd ~/.bashrc
	ln -sb --suffix='.orig' ~/.dotfiles.wjd/bashrc_custom.wjd ~/.bashrc_custom
	ln -sb --suffix='.orig' ~/.dotfiles.wjd/bash_profile.wjd ~/.bash_profile
	ln -sb --suffix='.orig' ~/.dotfiles.wjd/bash_aliases.wjd ~/.bash_aliases
	ln -sb --suffix='.orig' ~/.dotfiles.wjd/profile.wjd ~/.profile

	# Don't do the same for directory links as it might cause infinite link loops.
	# Instead, do:
	if [ -h $HOME'/.emacs.d' ]; then
	    mv $HOME'/.emacs.d' $HOME'/.emacs.d.orig'
	fi
	ln -s ~/.dotfiles.wjd/emacs.d.wjd ~/.emacs.d
	ln -sb --suffix='.orig' ~/.dotfiles.wjd/emacs.d.wjd/init.el ~/.emacs
    else
	echo
	echo '    ...skipping dotfiles setup.'
	echo
    fi
fi
echo
echo '###############################################################################'
echo ' '
echo '    4. Java JDK, Scala Build Tool (sbt), Eclipse (Optional)'
echo
echo
echo "       4.1 Java JDK..."
echo
if type -p java; then
    echo '         Found Java executable in PATH.'
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo '         Found Java executable in JAVA_HOME.'
    _java="$JAVA_HOME/bin/java"
else
    echo
    read -p '         No Java found. Install it? [Y/n]' -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
	sudo apt-get install openjdk-7-jdk
    else
	echo 
	echo '         WARNING: skipping java setup!'
	echo
	exit 1
    fi
fi
echo
echo "       4.2 Scala Build Tool..."
echo
if type -p sbt; then
    echo '         Found sbt executable in PATH.'
    _sbt=sbt
else
    echo
    read -p '         No sbt found in PATH. Install it? [Y/n]' -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
	mkdir -p $HOME/opt
	cd $HOME/opt
	wget -N http://dl.bintray.com/sbt/native-packages/sbt/0.13.2/sbt-0.13.2.tgz
	tar xzf sbt-0.13.2.tgz
	rm sbt-0.13.2.tgz
	mkdir -p $HOME/bin
	# Create link (if it already exists, rename it with .orig extension.)
	ln -sb --suffix='.orig' $HOME/opt/sbt/bin/sbt $HOME/bin/sbt
	echo
	echo '         ...sbt installed in $HOME/bin.  (Make sure $HOME/bin is in your PATH.)'
	echo
    else
	echo 
	echo '         WARNING: skipping sbt setup!'
	echo
    fi
fi
echo
echo "       4.3 Eclipse..."
echo
if type -p eclipse; then
    echo '         Found eclipse executable in PATH.'
    _eclipse=eclipse
else
    echo
    read -p '         No eclipse found. Install it? [Y/n]' -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
	wget -N http://downloads.typesafe.com/scalaide-pack/3.0.3.vfinal-210-20140327/scala-SDK-3.0.3-2.10-linux.gtk.x86_64.tar.gz
	tar xzf scala-SDK-3.0.3-2.10-linux.gtk.x86_64.tar.gz
	mv -i eclipse scala-SDK-3.0.3-2.10
	rm scala-SDK-3.0.3-2.10-linux.gtk.x86_64.tar.gz
	# Create link (if it already exists, rename it with .orig extension.)
	ln -sb --suffix='.orig' $HOME/opt/scala-SDK-3.0.3-2.10/eclipse $HOME/bin/eclipse
	echo
	echo '         ...eclipse installed in $HOME/bin.  (Make sure $HOME/bin is in your PATH.)'
	echo
    else
	echo 
	echo '         WARNING: skipping eclipse setup!'
	echo
    fi
fi
echo
echo '###############################################################################'
echo
echo '    6. Proof General, Coq, Cabal, and Agda  (Optional)'
echo ' '
read -p '       6.1 Would you like to install Proof General? [Y/n]' -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo
    echo '         Installing Proof General...'
    echo
    sudo apt-get install proofgeneral
    echo
    echo
else
    echo ' '
fi
echo ' '
read -p '       6.2 Would you like to install the Coq proof assistant? [Y/n]' -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo
    echo '         Installing Coq...'
    echo
    sudo apt-get install coq
    echo
    echo
else
    echo ' '
fi
    echo ' '
read -p '       6.3 Would you like to install Agda? (Warning: this will take LONG.) [Y/n]' -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo
    echo '           Installing Haskell Cabal (required for Agda install)...'
    echo
    sudo apt-get install cabal-install zlibc zlib1g-dev ncurses-base libncurses5-dev
    cabal update
    echo
    echo '           Installing Agda...'
    echo
    cabal install Agda
    $HOME/.cabal/bin/agda-mode setup
    echo
    echo '           Cloning a couple of Agda libraries from OPLSS 2014...'
    echo
    mkdir -p $HOME/git; cd $HOME/git
    if [ -h $HOME'/git/agda-summer-school' ]; then
	echo
	echo '           agda-summer-school repo found; skipping...'
	echo
    else 
	git clone https://github.com/williamdemeo/agda-summer-school.git
	# git clone git@github.com:williamdemeo/agda-summer-school.git
    fi
    if [ -h $HOME'/git/agda-prelude' ]; then
	echo
	echo '           agda-prelude repo found; skipping...'
	echo
    else 
	git clone https://github.com/williamdemeo/agda-prelude.git
	# git clone git@github.com:williamdemeo/agda-prelude.git
    fi
    cd $HOME/git/agda-prelude/agda-ffi
    cabal install
    echo
    echo
fi
echo
echo
echo
echo '    Configuration is complete.'
echo
echo '    Assuming all went well, the dotfiles.wjd repository has been cloned and'
echo '    saved at ~/.dotfiles.wjd (and your dot files now link to that directory).'
echo
echo '    If you want to use Magit in Emacs, see the instructions at the bottom of'
echo '    the file ~/.dotfiles.wjd/README.md.'
echo   
echo '    You can post comments, questions, or feedback in a comment box at:'
echo '    http://williamdemeo.org.'
echo

#### OLD OBSOLETE STUFF ##################################################################
#
# If you want this script to install node, jshint, and rlwrap, uncomment the lines below.
#
#
###############################################################################
# echo
# echo '    1.  node (server side JavaScript), and the node version manager (nvm)'
# echo
# # Install nvm: node-version manager
# # https://github.com/creationix/nvm
# git clone https://github.com/creationix/nvm.git ~/.nvm
# echo
# # Load nvm and install latest production node
# source $HOME/.nvm/nvm.sh
# nvm install v0.10.12
# nvm use v0.10.12

###############################################################################
# echo
# echo '    2.  jshint (allows checking JS code within emacs; see http://jshint.com/)'
# echo
# # Install jshint to allow checking of JS code within emacs
# # http://jshint.com/
# npm install -g jshint

###############################################################################
# echo
# echo '    3.  rlwrap (libreadline features for node; see: http://nodejs.org/api/repl.html)'
# echo
# # Install rlwrap to provide libreadline features with node
# # See: http://nodejs.org/api/repl.html#repl_repl
# sudo apt-get install -y rlwrap

