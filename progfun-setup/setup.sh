#!/bin/bash
# Simple setup.sh for configuring Ubuntu 14.04 LTS
# for headless setup of ProgFun course. 
#
# William DeMeo <williamdemeo@gmail.com>
# Date: 2014.05.17

echo
echo 'This script will install/configure some useful tools on a 64 bit Ubuntu Linux machine.'
echo
echo 'Here is a summary of what will be installed:'
echo
echo '    1.  git         git-core, main components of Git version control system'
echo '    2.  java        openjdk-7-jdk, unless a suitable JRE is already present'
echo '    3.  sbt         sbt-0.13.2, version of the Scala build tool'
echo '    4.  eclipse     scala-SDK-3.0.3-2.10-linux.gtk.x86_64, Scala-ized version of Eclipse (Kepler) IDE'
echo
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


#################################################
echo
echo "Step 1.  Install Git."
echo
sudo apt-get install -y git-core


#################################################
echo
echo "Step 2.  Setting up Java."
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


#################################################
echo
echo "Step 3.  Install sbt."
echo
if type -p sbt; then
    echo '         Found sbt executable in PATH.'
    _sbt=sbt
else
    echo
    read -p '         No sbt found. Install it? [Y/n]' -n 1 -r
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
    else
	echo 
	echo '         WARNING: skipping sbt setup!'
	echo
    fi
fi


#################################################
echo
echo "Step 4.  Install Eclipse IDE."
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
    else
	echo 
	echo '         WARNING: skipping sbt setup!'
	echo
    fi
fi
echo
echo
##############################################################################
echo
echo "Step 5. (optional) Adding $HOME/bin directory to PATH."
echo
read -p '   Add $HOME/bin to the PATH environmental variable? [Y/n]' -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "export PATH=$HOME/bin:$PATH" >> $HOME/.bash_profile
    export PATH=$HOME/bin:$PATH
fi
echo
echo
echo '    Setup is complete.'
echo
echo '    Assuming all went well, you can now use sbt and then import Scala projects in Eclipse.'
echo   
echo '    You can post comments, questions, or feedback in a comment box at:'
echo '    http://williamdemeo.org.'
echo

