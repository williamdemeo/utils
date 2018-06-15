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
Hit `Enter` when the Lenovo splash screen appears to enter the BIOS setup utility.
We want to make sure Windows doesn't prevent us from booting off a usb drive.

1. As suggested
   [here](https://www.tecmint.com/install-ubuntu-16-04-alongside-with-windows-10-or-8-in-dual-boot/),
   modify the EFI BIOS settings and disable "Secure Boot" feature.  This
   setting is found in the "Security > Secure Boot" menu of the BIOS
   configuration program.

2. In the "Startup" BIOS menu item,
   - set the "UEFI/Legacy Boot" option to "Both"
   - set the "Boot Mode" option to "Diagnostics"

3. Boot into Windows, and follow the repartitioning instructions given at
   https://www.tecmint.com/install-ubuntu-16-04-alongside-with-windows-10-or-8-in-dual-boot/

(**Todo:** complete this section)

---

## Things to do after installing ubuntu

This section describes how to implement the specific configuration and
customizations that I like.

## upgrade installed packages

```sh
sudo apt update
sudo apt upgrade
```

---

## Generate ssh keys

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


## fix display resolution and zoom

1. Hit Windows key, then type `settings` and hit Enter.

2. In the "Devices > Displays" section, select the desired resolution
and scale.

(**Todo**: figure out how to get other scales besides 100, 200, 300)

---

## fix window-toggling, mouse scroll direction, key repeat speed

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

## enable emacs style shortcuts, make Caps-Lock a Ctrl key, etc.

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

## add Top Bar information

1. Launch gnome-tweak-tool by typing `gnome-tweaks` at the command
prompt.

2. In the "Top Bar" section, set "Battery Percentage" and "Clock >
Date" to ON.

---

## install some additional software from command line

The following is a list of apps I install from the command line using
`sudo apt install <name of package>`

(The command used to install all packages at once appears below.)

| Name  | Description                      |
| ---   | ---                              |
| emacs | GNU Emacs editor (metapackage) |
| git   | fast, scalable, distributed revision control system |
| jed   | editor for programmers (textmode version) |
| nemo  | File manager and graphical shell for Cinnamon |
| build-essential | Informational list of build-essential packages |
| cmake   | cross-platform, open-source make system |
| dconf-tools    | transitional dummy package |
| libgmp-dev | Multiprecision arithmetic library developers tools |
| pm-utils | utilities and scripts for power management |
| texlive                   | TeX Live: A decent selection of the TeX Live packages |
| texlive-bibtex-extra      | TeX Live: BibTeX additional styles |
| texlive-generic-extra     | TeX Live: transitional dummy package |
| texlive-latex-extra       | TeX Live: LaTeX additional packages |
| texlive-latex-recommended | TeX Live: LaTeX recommended packages |
| texlive-publishers        | TeX Live: Publisher styles, theses, etc. |
| texlive-science           | TeX Live: Mathematics, natural sciences, computer science packages|
| texlive-xetex             | TeX Live: XeTeX and packages |

To install all of these at once, copy-and-paste the following into a terminal window:

```sh
sudo apt install emacs git jed nemo build-essential cmake dconf-tools pm-utils \
texlive texlive-latex-extra texlive-xetex texlive-science texlive-latex-recommended \
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
dpkg -l tcl-tclreadline python-pygments icc-profiles libfile-which-perl libspreadsheet-parseexcel-perl \
texlive-latex-extra-doc dot2tex prerex texlive-pictures-doc vprerex texlive-publishers-doc texlive-science-doc
```

---

## restore running apps upon reboot

(Here's what I tried, but this doesn't seem to work yet.)

Install `dconf-tools`

```sh
sudo apt install dconf-tools
```

Then run the command `dconf-editor`

When dconf-editor starts, select org > gnome > gnome-session, then
check the box next to `auto-save-session`


---

## install some additional software directly from source or binaries

| App Name | Description                      |  url |
| ---      | ---                              | ---  |
| MEGAsync | synch between computer and MEGA cloud storage account | http://mega.nz |
| atom     | modern extensible editor         | https://atom.io |
| Chrome   | web browser | https://www.google.com/chrome |
| IntelliJ IDEA | IDE I use for Scala programming | https://www.jetbrains.com/idea/download |
| Lean     | Interactive theorem prover and fp lang | https://leanprover.github.io |
| VS Code | IDE I sometimes use for Lean | https://code.visualstudio.com/ |


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


---

## Remove some bloatware

### Remove some "favorites" icons

1. Rhythm Box
   rightclick on the Rhythm Box launcher icon and select "remove from favorites"

2. Ubuntu Software
   rightclick on the Software installer icon and select "remove from favorites"


### Uninstall some "favorites" apps

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

## Fix Lenovo X1Y3 wake-from-suspend problem

**WARNING:** The steps below bricked my machine.  Do not follow these steps!!!
(I'm leaving these steps posted here as a reminder, in case some other website
suggests them, these steps can be fatal.  Do not proceed!!!)

**Do NOT do the following!!!**
You have been warned.

- (DO NOT) Enable Thunderbolt 3 compatibility mode in the BIOS

- (DO NOT) Disable internal card reader in BIOS (under security settings)

- (DO NOT) Add kernel flag: acpi.ec_no_wakeup=1

  (DO NOT) Do this by adding the following line to the file `/etc/default/grub`

        GRUB_CMDLINE_LUNUX="acpi.ec_no_wakeup=1"

  And then (DO NOT) run `sudo update-grub`
