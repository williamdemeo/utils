# Linux on Lenovo X1 Yoga Gen 3

This page describes some of the steps I took to install and configure Ubuntu
Linux 18.04 on a Lenovo X1 Yoga (3rd Generation) laptop.

**This information is for my own reference.**
I am posting this information here just in case I forget how to do any of this
next time I configure a machine.

**Disclaimer.** If you make use of the information on this page, then you do
so at your own risk.  I am not responsible for any damages or injuries sustained
as a result of following the instructions below.

## Installing Ubuntu 18.04 alongside Windows 10

1. Download Ubuntu and make a startup iso image on a blank usb drive.
   (Use a utility like the Ubuntu Startup Disk Creator app.)

2. Boot the laptop and hit `Enter` when the Lenovo splash screen appears to
   enter the BIOS setup utility. (Be very careful to not change too many BIOS settings.  You can brick the machine if you mess around too much with the BIOS.)

3. As suggested
   [here](https://www.tecmint.com/install-ubuntu-16-04-alongside-with-windows-10-or-8-in-dual-boot/),
   modify the EFI BIOS settings and disable "Secure Boot" feature.  This
   setting is found in the "Security > Secure Boot" menu of the BIOS
   configuration program.

4. In the "Startup" BIOS menu item,
   - set the "UEFI/Legacy Boot" option to "Both"
   - set the "Boot Mode" option to "Diagnostics"

5. Boot into Windows, and follow the repartitioning instructions given at
   https://www.tecmint.com/install-ubuntu-16-04-alongside-with-windows-10-or-8-in-dual-boot/

(**Todo:** fill in more details)

### Installation of Ubuntu 18.04

When prompted for the type of installation, be sure to choose the **minimal** option to avoid installing too much bloatware.

---

## Things to do after installing ubuntu

This section describes how to implement the specific configuration and
customizations that I like.

### fix display resolution and zoom

The resolution on the latest X1s can reach 2560x1440, which is incredibly hight for a 14"-diagonal screen.  As a result, upon login, the window manager defaults to 200% zoom, which makes everything appear too big, as if the machine has pathetically low resolution.

On the other hand, 100% zoom (i.e., no zoom) requires a very good pair of eyes or a very good pair of binoculars (or both) to see what's on the screen.  To solve this, set the zoom to 100% and then use the command line to achieve a comfortable fractional zoom level of, say, 140% (i.e., 1.4 zoom factor), as follows:

1. Hit Windows key, then type `settings` and hit Enter.

2. In the "Devices > Displays" section, set the zoom level to 100% (no zoom).

3. If everything is too small (but too big at 200% zoom), then invoke the
   following command to obtain a 1.4x zoom factor:

   ```sh
   gsettings set org.gnome.desktop.interface text-scaling-factor 1.4
   ```

---

### upgrade installed packages

```sh
sudo apt update
sudo apt upgrade
```

---

### generate ssh keys

Generate ssh keys and and post the public key on your github and
bitbucket account pages.

```
ssh-keygen
# Hit Enter (to select default filename)
# Hit Enter twice (to select/confirm empty passphrase)
cat $HOME/.ssh/id_rsa.pub
```

Copy all of the output that the previous command produces including
`ssh-rsa` and your `usename@hostname` and past it into the input windows
on the "ssh keys" pages at github and bitbucket. (Login to account
at github.com and bitbucket.org and find the `Settings -> SSH` page.)

---



### fix window-toggling, mouse scroll direction, key repeat speed

1. Hit Windows key, then type `settings` and hit Enter.

2. In the "Devices > Keyboard" section, select "Switch windows" and
type `Alt+Tab` to set the switch-window behavior to the old-style.

3. In the "Mouse & Touchpad > Mouse" section, set "Natural Scrolling"
to OFF.

4. In the "Mouse & Touchpad > Touchpad" section, set "Natural Scrolling"
to OFF.

5. In the "Universal Access" Section select "Repeat Keys"

6. Move both the "Delay" and "Speed" sliders to the *left*.


---

### enable emacs style shortcuts, make Caps-Lock a Ctrl key, etc.

1. Install `gnome-tweak-tool` with the command

   ```sh
   sudo apt install gnome-tweak-tool
   ```

2. Launch gnome-tweak-tool by typing `gnome-tweaks` at the command
prompt.

3. In the "Keyboard & Mouse" section,
   - set "Emacs Input" to ON.
   - select the "Additional Layout Options" button, click the arrow next
     to "Caps Lock behavior" and select "Caps Lock is also a Ctrl"

---

### add Top Bar information

1. Launch gnome-tweak-tool by typing `gnome-tweaks` at the command
prompt.

2. In the "Top Bar" section, set "Battery Percentage" and "Clock >
Date" to ON.

---

### install some additional software from command line

The following is a list of apps I install from the command line using
`sudo apt install <name of package>`

(The command used to install all packages at once appears below.)

| Name               | Description                                         |
| ---                | ---                                                 |
| emacs              | GNU Emacs editor (metapackage)                      |
| coq                | the Coq proof assistant                             |
| proofgeneral       | a generic frontend (IDE) for proof assistants       |
| prooftree          | proof-tree visualization for Proof General          |
| git                | fast, scalable, distributed revision control system |
| mg                 | microscopic GNU Emacs-style editor                  |
| nemo               | File manager and graphical shell for Cinnamon       |
| build-essential    | Informational list of build-essential packages      |
| cmake              | cross-platform, open-source make system             |
| dconf-tools        | transitional dummy package                          |
| libgmp-dev         | Multiprecision arithmetic library developers tools  |
| pm-utils           | utilities and scripts for power management          |
| Okular             | Universal document viewer                           |
| djview4            | djvu document viewer                                |
| texlive                   | TeX Live: A decent selection of the TeX Live packages |
| texlive-bibtex-extra      | TeX Live: BibTeX additional styles           |
| texlive-generic-extra     | TeX Live: transitional dummy package         |
| texlive-latex-extra       | TeX Live: LaTeX additional packages          |
| texlive-latex-recommended | TeX Live: LaTeX recommended packages         |
| texlive-publishers        | TeX Live: Publisher styles, theses, etc.     |
| texlive-science           | TeX Live: Mathematics, natural sciences, computer science packages |
| texlive-xetex             | TeX Live: XeTeX and packages                 |

To install all of these at once, copy-and-paste the following into a terminal window:

```sh
sudo apt install emacs coq proofgeneral prooftree git mg nemo build-essential \ 
cmake dconf-tools pm-utils okular djview4 texlive texlive-latex-extra \ 
texlive-xetex texlive-science texlive-latex-recommended \
texlive-publishers texlive-generic-extra texlive-bibtex-extra
```

After installing the above, `apt` recommended installing more
packages, which I did as follows:

```sh
sudo apt install tcl-tclreadline python-pygments icc-profiles libfile-which-perl libspreadsheet-parseexcel-perl \
texlive-latex-extra-doc dot2tex prerex texlive-pictures-doc vprerex texlive-publishers-doc texlive-science-doc
```
View a brief description of these packages with the command:

```sh
dpkg -l tcl-tclreadline python-pygments icc-profiles libfile-which-perl \ 
libspreadsheet-parseexcel-perl texlive-latex-extra-doc dot2tex prerex \ 
texlive-pictures-doc vprerex texlive-publishers-doc texlive-science-doc
```

### install some add-on packages to the emacs editor

Launch emacs and invoke `M-x package-list-packages`.  From the list, choose to install the following:
+ magit
+ org
+ org-journal

---

### install some additional software directly from source or binaries

| App Name | Description                      |  url |
| ---      | ---                              | ---  |
| MEGAsync | synch between computer and MEGA cloud storage account | http://mega.nz |
| atom     | modern extensible editor         | https://atom.io |
| Chrome   | web browser | https://www.google.com/chrome |
| IntelliJ IDEA | IDE I use for programming in Scala | https://www.jetbrains.com/idea/download |
| Lean     | Interactive theorem prover and fp lang | https://leanprover.github.io |
| VS Code | IDE I use for programming in Lean | https://code.visualstudio.com/ |
| JDK | Java Development Kit | [oracle javase overview & download page](http://www.oracle.com/technetwork/java/javase/overview/index.html) |
| Acroread | pdf viewer | See [these instructions](https://linuxconfig.org/how-to-install-adobe-acrobat-reader-on-ubuntu-18-04-bionic-beaver-linux)

0. **MEGAsync** Go to http://mega.nz and use the hamburger menu on the right to select
   "Apps" > "sync client" and download the appropriate .deb package. Once the download
   finishes, click on the downloaded file and you should be asked whether to open
   the file with the Ubuntu App Installer.  Select "yes" and install MEGAsync.
   Alternatively, enter `sudo dpkg -i megasync*.deb` on the command line. Finally, launch
   the Megasync program and start syncing!

1. **atom**

   Go to https://atom.io and download `atom-amd64.deb`.  Once the download
   finishes, click on the downloaded file and you should be asked whether to open
   the file with the Ubuntu App Installer.  Select "yes" and install Atom.
   Alternatively, enter `sudo dpkg -i atom-*.deb` on the command line. Finally, launch
   Atom from the command line with the command `atom &` and start editing!

2. **Chrome** (see instructions for atom, except use https://www.google.com/chrome)

3. **IntelliJ IDEA**

   Go to https://www.jetbrains.com/idea/download login, indicate your
   academic status, and get a license to use the full version for free.
   Download the file `ideaIU-2018.1.4.tar.gz` (or similar) and extract it.

   ```sh
   tar xvzf ideaIU-*.gz
   mkdir -p $HOME/bin
   ln -s $HOME/opt/IntelliJ/idea-IU-181.5087.20/bin/idea.sh $HOME/bin/idea
   ```

   Then make sure `$HOME/bin` is in your search `$PATH`; e.g., input

   ```sh
   export PATH="$HOME/bin":$PATH
   ```

   at the command line, and also put this line in your `$HOME/.bash_profile`
   file to make it permanent.

4. **Lean**

   **Warning:** Installing Lean from source takes quite a while, say, 30 minutes.
   If you're not sure whether you need to compile Lean, consider trying the
   [precompiled binaries](https://leanprover.github.io/download/).

   ```sh
   sudo apt install git libgmp-dev cmake
   mkdir -p $HOME/git/PROGRAMMING/LEAN
   cd $HOME/git/PROGRAMMING/LEAN
   git clone git@github.com:leanprover/lean.git
   ```

   ```sh
   cd lean
   mkdir -p build/release
   cd build/release
   cmake ../../src
   make
   ```

5. **VS Code** and **vscode-lean**

   - Go to https://code.visualstudio.com/  and download the vscode .deb file.
   Once download finishes, open a terminal window, go to the directory where you
   downloaded the vscode .deb file, and install it with the command
   `sudo dpkg -i code_*.deb`.

   - Next, clone the `vscode-lean` repository with either

     ```sh
     mkdir -p $HOME/git; cd $HOME/git
     git clone git@github.com:leanprover/vscode-lean.git
     ```

     or

     ```sh
     mkdir -p $HOME/git; cd $HOME/git
     git clone https://github.com/leanprover/vscode-lean
     ```

   - Next, install the node package manager.

     ```sh
     sudo apt install npm
     ```

   - Next, install `vscode-lean`.

     ```sh
     cd $HOME/git/vscode-lean
     npm install
     ```

   - Finally, launch vscode by entering `code` on the command line, then open
     `vscode-lean` and start developing (F5 starts the debugger).

6. **JDK**  [This post](http://williamdemeo.github.io/2017/12/06/java-on-linux/) describes the best way to set up (multiple versions of) Java on Linux.




---

### install some add-on packages to the atom editor

Launch Atom by typing `atom&` at the command line.  Select "Edit > Preferences" from the menu,
then select "+Install".  Search for and install the following:

+ git-plus
+ git-control
+ tree-view-git-status
+ language-latex
+ language-markdown
+ markdown-preview-plus
+ markdown-toc

---

### install some add-on packages to the atom editor
Lauch vscode by typing `code &` at the command prompt. From the "View" menu, select
"Extensions".  A search box should appear in the left pane.  Type each of the
names of each of extensions in the list below, hitting enter after each name.
Each time a list of candidates should appear.  When you find the one you want, select
"install."

+ GitLens
+ Git History
+ Project Manager
+ Lean
+ reStructuredText
+ Zenburn Theme
+ Emacs Friendly Keymap (I found tihs to be the best Emacs keybinding extension)

### adjust trackpoint settings

Following the advice given in [this answer](https://askubuntu.com/a/761504/100671),
and on [this page](https://www.reddit.com/r/thinkpad/comments/5rcwlq/heres_how_to_get_the_perfect_trackpoint/),

**N.B.** The instructions in this section assume you have the `mg` 
(microscopic Emacs) editor installed.  You should either install `mg` 
before following these instructions (e.g., with `sudo apt install mg`), or
replace occurrences of `mg` with the name of your favorite text editor.

1. Make sure the `xserver-xorg-input-libinput` package is installed.

   ```sh
   sudo apt-get install xserver-xorg-input-libinput
   ```

2. Edit the file `/etc/udev/rules.d/10-trackpoint.rules`,

   ```sh
   sudo -i mg /etc/udev/rules.d/10-trackpoint.rules
   ```

   so that it includes the following lines:

   ```sh
   ACTION=="add",
   SUBSYSTEM=="input",
   ATTR{name}=="TPPS/2 IBM TrackPoint",
   ATTR{device/sensitivity}="132",
   ATTR{device/speed}="158",
   ATTR{device/inertia}="6",
   ATTR{device/press_to_select}="0"
   ```

4. Finally, change the acceleration of the cursor.

   ```
   sudo mg /usr/share/X11/xorg.conf.d/90-libinput.conf
   ```

   Replace the first section with the following code:

   ```
   Section "InputClass"  
     Identifier "libinput pointer catchall"  
     MatchIsPointer "on"  
     MatchDevicePath "/dev/input/event*"  
     Driver "libinput"  
     Option "AccelSpeed" "-0.40"  
   EndSection  
   ```

   Save the file with `Ctrl+O`.



---

### remove some bloatware

The steps in this section are probably unecessary if you select a **minimal**  installation when installing ubuntu.

#### remove some "favorites" icons

1. Rhythm Box
   rightclick on the Rhythm Box launcher icon and select "remove from favorites"

2. Ubuntu Software
   rightclick on the Software installer icon and select "remove from favorites"


#### uninstall some "favorites" apps

+ Amazon
  1. rightclick on the Amazon launcher icon and select "show details"
  2. select "Amazon" then select remove"

+ Firefox
  1. rightclick on the Firefox launcher icon and select "show details"
  2. select "Firefox Web Browser" then click "remove"

+ Libre Office Writer
  1. rightclick on the Libre Writer launcher icon and select "show details"
  2. select "LibreOffice Writer" then click "remove"


---

## Stuff that doesn't work yet

This sections mentions some of the issues I haven't been able to resolve yet.

### restore running apps upon reboot  (unsuccessful)

(Here's what I tried, but this doesn't seem to work yet.)

Install `dconf-tools`

```sh
sudo apt install dconf-tools
```

Then run the command `dconf-editor`

When dconf-editor starts, select org > gnome > gnome-session, then
check the box next to `auto-save-session`



### fix Lenovo X1Y3 wake-from-suspend problem (unsuccessful)

**WARNING:** The steps below bricked my machine.  Do not follow these steps!!!
(I'm leaving these steps posted here as a reminder, in case some other website
suggests them, these steps can be fatal.  Do not proceed!!!)

Below is how I tried to fix the weird mouse behaviour observed after waking from suspend, but the consequences of this attempt were disasterous.

**Do not follow the steps in this section!**

**Do NOT do the following!!!**
(You have been warned.)

- (DO NOT) Enable Thunderbolt 3 compatibility mode in the BIOS

- (DO NOT) Disable internal card reader in BIOS (under security settings)

- (DO NOT) Add kernel flag: acpi.ec_no_wakeup=1

  (DO NOT) Do this by adding the following line to the file `/etc/default/grub`

        GRUB_CMDLINE_LUNUX="acpi.ec_no_wakeup=1"

  And then (DO NOT) run `sudo update-grub`
