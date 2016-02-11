Introduction
============

This is a modified version of the setup used in the Stanford
Startup Engineering class.

The original repo is at: https://github.com/startup-class/setup

The setup.sh script in this repository contains some useful
commands for configuring some basic things in Ubuntu Linux.

If you try the instructions below and have problems, please [report the issue](https://github.com/williamdemeo/dotfiles.wjd/issues).

Installation
============

If you want to use the script, you don't need the whole repository.
You can just enter the following at the Linux command line (this has only been 
tested on a standard Ubuntu Linux 14.04 machine):

1.  wget https://raw.github.com/williamdemeo/dotfiles.wjd/master/setup.sh

2.  chmod a+x setup.sh

3.  ./setup.sh

The script will grab what it needs.  In particular, it will install the following:

1.  git-core (main components required to use Git version control software)  
2.  emacs24 (a recent release of Emacs) and emacs-goodies-el  
3.  dotfiles.wjd (configuration files; see: https://github.com/williamdemeo/dotfiles.wjd   
    .profile, .bashrc, .bash\_aliases, .bash\_profile, .bashrc\_custom, .screenrc, .emacs.

4. a) Java               openjdk-7-jdk (unless a suitable JRE is already present)   
   b) Scala Build Tool   sbt-0.13.2 (unless sbt is already in the path)  
   c) Eclipse            scala-SDK-3.0.3-2.10-linux.gtk.x86_64 (a version of Eclipse IDE with Scala support)  

5. Optionally, the following may also be installed:  
   a) Proof General  
   b) Coq  
   c) Agda


Old installation options
------------------------

The following programs are no longer installed by default.  To include them, edit the setup.sh script.

1.  node version manager (nvm)	
2.  curl
3.  jshint (for checking/running JS code in emacs)
4.  rlwrap (for libreadline features of node)
    (See: http://nodejs.org/api/repl.html#repl_repl)


Troubleshooting
===============
Once the setup completes successfully, if you try to type `node` at the command line, 
for example, it will say command not found.  Exit and open a new terminal so 
the environmental variables will be set properly.

Other Configuration Notes/Options for Ubuntu
=============================================

These configuration suggestions work for Ubuntu release 14.04, and possibly
other releases.

Activating workspaces
---------------------
Launch the System Settings app, then select Appearance and check the box next to
"Enable workspaces."

Swapping CapsLock and Ctrl Keys
-------------------------------
Install and run the gnome-tweak-tool. In a terminal window, enter the following:

    sudo apt-get install gnome-tweak-tool
	gnome-tweak-tool

There is a bug in the gnome-tweak-tool which makes it trasparent and *almost* impossible to
use.  For best results, make sure you have a light colored desktop background
and have no other applications open.  Alternatively, open a terminal window in
full screen mode and give it a light color. Otherwise, it will be impossible to
see the menu options in the gnome-tweak-tool.

To swap the default position of the CapsLock and Ctrl keys, on the left side of the
gnome-tweak-tool window, under "Tweaks", select "Typing." Then, on the
right side, use the drop-down menu next to "Ctrl key position" and select "Swap
Ctrl and CapsLock."

Reverting to the old window toggling behavior
---------------------------------------------
To change the annoying Unity behavior of limiting the toggling of windows (only
one window shown per app) back to the old behavior where every window appears in
a chronological list of windows, follow the steps below. 

1. install the compiz config setting manager and plugins:

        sudo apt-get install compizconfig-settings-manager
        sudo apt-get install compiz-plugins

2. open CompizConfig Settings manager.

3. Navigate the menus as follows: Desktop `--> Ubuntu Unity Plugin --> Switcher tab`  
   Edit “Key to Start Switcher” and disable it by unchecking the box next to "Enable".  
   Edit “Key to Start Switcher in Reverse” and disable it it by unchecking the box next to "Enable".  
   Click the Back button.

4. Navigate down to the `Window Management` menu and check the box next to “Static
   Application Switcher.”  

   You can resolve whatever conflicts appear by choosing, say, “Disable Key to…”

5. Click on the phrase “Static Application Switcher.”  This will open a window
   that lets you assign key strokes to various behaviors. Click on the edit
   button for “Next Window (All Windows)”, click grab key comibination, and then
   type the keys you want to assign to this action (e.g. Alt+tab). Do the same
   for “Previous Window (All Windows)” (e.g. Alt+shift+tab).



Cofiguring and Using Magit
==========================

Installing Magit
----------------

1.  Add a few lines to the bottom of your ~/.emacs.d/init.el file.
    (This was done for you if you ran the setup.sh script as described above.)

        (setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
            ("marmalade" . "http://marmalade-repo.org/packages/")
            ("melpa" . "http://melpa.milkbox.net/packages/")))

2.  Start emacs and do `M-x package-install`.
    When it prompts you with "Install package:", enter `magit`.

Using Magit
-----------

Follow the directions here: http://magit.github.io/magit/magit.html

You may find these directions a bit confusing at first, so here's a 
quick and dirty example to get you started:

1.  Stage a modified file for commit.

    After you've edited a file, say, textfile.txt, using emacs, enter M-x
    magit-status to open the magit status buffer.

    Switch to that buffer (Ctrl+x o), and move the cursor to the line
    where textfile.txt is listed.  Type s to stage that file for commit.

2.  Commit changes.

    Type c, which will bring up a new buffer. Write your commit comments
    there, then type Ctrl+c Ctrl+c to commit the change.

    The first two steps above are covered here: http://magit.github.io/magit/magit.html#Staging-and-Committing

3.  Push to github.

    Type  P P  (capitals!)

    This will push everything that is listed under "Unpushed"

    See also: http://magit.github.io/magit/magit.html#Pushing-and-Pulling

