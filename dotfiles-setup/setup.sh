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
echo "1. Git  (git-core)"
echo "2. Emacs (emacs25, emacs24-el, and emacs25-common-non-dfsg)"
echo "3. Dot Files (.profile, .bashrc, .bash\_aliases, .bash\_profile, .bashrc\_custom, .screenrc, .emacs)."
echo "4. Java (openjdk-8-jdk, unless a suitable JRE is already present)"
echo "5. Scala (sbt-0.13.2, unless sbt is already in the path)"
echo "6. Optionally, the following may also be installed:"
echo "   a. IntelliJ (my favorite IDE for coding in Scala and Java)"
echo "   b. Proof General (for doing type theory and constructive math in emacs)"
echo "   c. The Lean Prover (my favorite proof assistant and functional programming language)"
echo "   d. Coq (my second favorite proof assistant)"
echo " "
echo
read -p 'Abort this setup script? [Y/n]' -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]];then
  echo
  echo 'Setup aborted.'
  echo
  exit
fi
echo
echo '###############################################################################'
echo
echo '    1.  git-core (main components required to use Git version control software)'
echo
sudo apt install -y git-core
echo
echo '###############################################################################'
echo
echo '    2.  emacs25 (a recent release of Emacs) and emacs-goodies-el'
echo
sudo apt install -y emacs25 emacs25-el emacs25-common-non-dfsg
echo
echo '###############################################################################'
echo
echo '    3.  dotfiles.wjd (configuration files)'
echo
cd $HOME
dotfiles_path=$HOME'/.bash.d'

# Check for pre-existing .dotfiles.wjd directory
# If one exists, ask whether to rename it and continue. (Otherwise, abort.)
if [ -d $dotfiles_path/ ]; then
  echo
  echo '    Directory '$dotfiles_path' already exists...renaming it.'
  mv $dotfiles_path $dotfiles_path'_backup_'$(date +'%Y%m%d:%H:%M')
fi

if [ -d $HOME'/bash.d.tar.gz' ]; then
  mv $HOME'/bash.d.tar.gz' $HOME'/bash.d.tar.gz_backup_'$(date +'%Y%m%d:%H:%M')
fi
if [ -d $HOME'/bash.d' ]; then
  mv $HOME'/bash.d' $HOME'/bash.d_backup_'$(date +'%Y%m%d:%H:%M')
fi
cd $HOME
sudo apt install -y rlwrap
wget https://github.com/williamdemeo/utils/raw/master/dotfiles-setup/bash.d.tar.gz
tar xvzf bash.d.tar.gz
mv bash.d .bash.d

# Create the required links.
# (If a file or link of that name exists, rename it with .orig extension.)
ln -sb --suffix='.orig' ~/.bash.d/screenrc ~/.screenrc
ln -sb --suffix='.orig' ~/.bash.d/bashrc.wjd ~/.bashrc
ln -sb --suffix='.orig' ~/.bash.d/bashrc_custom.wjd ~/.bashrc_custom
ln -sb --suffix='.orig' ~/.bash.d/bash_profile.wjd ~/.bash_profile
ln -sb --suffix='.orig' ~/.bash.d/bash_aliases.wjd ~/.bash_aliases
ln -sb --suffix='.orig' ~/.bash.d/profile.wjd ~/.profile

if [ -d $HOME'/.emacs.d' ]; then
  mv $HOME'/.emacs.d' $HOME'/.emacs.d_backup_'$(date +'%Y%m%d:%H:%M')
fi
cd $HOME
wget https://github.com/williamdemeo/utils/raw/master/dotfiles-setup/emacs.d.tar.gz
tar xvzf emacs.d.tar.gz
mv emacs.d .emacs.d
if [ -d $HOME'/.emacs' ]; then
  mv $HOME'/.emacs' $HOME'/.emacs_backup_'$(date +'%Y%m%d:%H:%M')
fi
ln -sb --suffix='.orig' ~/.emacs.d/init.el ~/.emacs

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
  if [[ $REPLY =~ ^[Yy]$ ]];then
    sudo apt install -y openjdk-9-jdk
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
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
      sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
      sudo apt update
      sudo apt install -y sbt
    else
      echo
      echo '      ...ok, skipping sbt setup!'
      echo
    fi
fi
echo
echo "       4.3 IntelliJ..."
echo
if type -p idea; then
  echo '         Found idea executable in PATH.'
  _idea=idea
else
  echo
  read -p '         No IntelliJ found. Install it? [Y/n]' -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    mkdir -p $HOME/opt
    mkdir -p $HOME/opt/JETBRAINS
    cd $HOME/opt/JETBRAINS
    wget -N https://download.jetbrains.com/idea/ideaIC-2017.3.3.tar.gz
	  tar xvzf ideaIC-2017.3.3.tar.gz
	  ln -sb --suffix='.orig' $HOME/opt/JETBRAINS/idea-IC-*/bin/idea.sh $HOME/bin/idea
	  echo
	  echo "     --------------------------------------------------------"
	  echo "     |   RUN IntelliJ IDE with the command $HOME/bin/idea   |"
	  echo "     --------------------------------------------------------"
  else
	echo
	echo '      ...ok, skipping IntelliJ setup.'
	echo
  fi
fi
echo
echo '###############################################################################'
echo
echo '    6. Proof General, Lean, Coq'
echo ' '
read -p '       6.1 Would you like to install Proof General? [Y/n]' -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo
  echo '         Installing Proof General...'
  echo
  sudo apt install -y proofgeneral
  echo
else
	echo
	echo '      ...ok, skipping Proof General setup.'
	echo
fi
echo ' '
read -p '       6.2 Would you like to install the Lean proof assistant? [Y/n]' -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo
  echo '         Installing Lean...'
  echo
  mkdir -p $HOME/opt
  mkdir -p $HOME/opt/Lean
  cd $HOME/opt/Lean
  wget -N https://leanprover.github.io/lean-nightly/build/lean-nightly-linux.tar.gz
  tar xvzf lean-nightly-linux.tar.gz
  ln -sb --suffix='.orig' $HOME/opt/Lean/lean-nightly-linux/bin/lean $HOME/bin/lean
  echo
  echo "     ------------------------------------------------"
  echo "     |   RUN Lean with the command $HOME/bin/lean   |"
  echo "     ------------------------------------------------"
else
	echo
	echo '      ...ok, skipping Lean setup.'
	echo
fi
echo ' '
read -p '       6.3 Would you like to install the Coq proof assistant? [Y/n]' -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo
  echo '         Installing Coq...'
  echo
  sudo apt install -y coq
  echo
  echo
else
	echo
	echo '      ...ok, skipping Coq setup.'
	echo
fi
echo
echo '    Configuration is complete.'
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
# sudo apt install -y rlwrap
