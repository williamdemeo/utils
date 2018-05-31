# Things I do after installing ubuntu

The sections below describe how I like to configure a new ubuntu
installation.  This is mainly for my own reference, so I remember how
to do all these things next time.

The information here is accurate as of Ubuntu 18.04, newly installed on May 29, 2018.

**Disclaimer.** Use this information at your own risk.


## upgrade installed packages

    sudo apt update
    sudo apt upgrade
    
---

## Generate ssh keys

Generate ssh keys and and post the public key on your github and
bitbucket account pages. 

    ssh-keygen
    # Hit Enter (to select default filename)
    # Hit Enter (to select empty passphrase)
    # Hit Enter (to confirm empty passphrase)

    cat $HOME/.ssh/id_rsa.pub
    
Then copy all of the output that the previous command displays
including `ssh-rsa` and your `usename@hostname` and past this into the
input windows on the ssh keys pages at github and bitbucket. (Go to 
Github.com and bitbucket.org and login to each site and find 
`Settings -> SSH`.)

---


## fix display resolution and zoon

1. Hit Windows key, then type `settings` and hit Enter.

2. In the "Devices > Displays" section, select the desired resolution
and scale. 

(**todo**: figure out how to get other scales besides 100, 200, 300)

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

        sudo apt install gnome-tweak-tool
    
2. Launch gnome-tweak-tool by typing `gnome-tweaks` at the command
prompt.

3. In the "Keyboard & Mouse" section, set "Emacs Input" to ON.

4. In the "Keyboard & Mouse section", select "Additional Layout Options"
button, click the arrow next to "Caps Lock behavior" and select "Caps
Lock is also a Ctrl"

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

To install all of these, at the command prompt enter:

    sudo apt install emacs git jed nemo build-essential cmake dconf-tools pm-utils \
    texlive texlive-latex-extra texlive-xetex texlive-science texlive-latex-recommended \ 
    texlive-publishers texlive-generic-extra texlive-bibtex-extra

After installing the above, `apt` recommended installing more
packages, which I did as follows:

    sudo apt install tcl-tclreadline python-pygments icc-profiles libfile-which-perl libspreadsheet-parseexcel-perl \
    texlive-latex-extra-doc dot2tex prerex ruby-tcltk libtcltk-ruby texlive-pictures-doc vprerex \
    texlive-publishers-doc texlive-science-doc
    
View a brief description of these packages with the command:

    dpkg -l tcl-tclreadline python-pygments icc-profiles libfile-which-perl libspreadsheet-parseexcel-perl \
    texlive-latex-extra-doc dot2tex prerex ruby-tcltk libtcltk-ruby texlive-pictures-doc vprerex \
    texlive-publishers-doc texlive-science-doc

---

## restore running apps upon reboot

Install `dconf-editor` 

    sudo apt install dconf-tools
    dconf-editor
    
When dconf-editor starts, select org > gnome > gnome-session, then
check the box next to `auto-save-session`

(this doesn't seem to work)

---

## install some additional software directly from source or binaries

| App Name | Description                      |  url |
| ---      | ---                              | ---  | 
| atom     | modern extensible editor         | https://atom .io |
| Chrome   | web browser | https://www.google.com/chrome |
| IntelliJ IDEA | IDE I use for Scala programming | https://www.jetbrains.com/idea/download |
| Lean     | Interactive theorem prover and fp lang | https://leanprover.github.io |
| VS Code | IDE I sometimes use for Lean | https://code.visualstudio.com/ |


1. **atom**

   Go to https://atom.io and download `atom-amd64.deb`.  Once download
   finishes, enter `sudo dpkg -i atom-amd64.deb` on the command line.

2. **Chrome** (see instructions for atom, except use https://www.google.com/chrome)

3. **IntelliJ IDEA**

   Go to https://www.jetbrains.com/idea/download login, indicate your
   academic status, and get a license to use the full version for free.
   Download the file `ideaIU-2018.1.4.tar.gz` (or similar) and extract it.

        tar xvzf ideaIU-2018.1.4.tar.gz
        mkdir -p $HOME/bin
        ln -s $HOME/opt/IntelliJ/idea-IU-181.5087.20/bin/idea.sh $HOME/bin/idea
    
   Then make sure $HOME/bin is in your search $PATH; e.g., input

        export PATH="$HOME/bin":$PATH
    
   at the command line, and in your `$HOME/.bash_profile` file.

4. *Lean*

        sudo apt install git libgmp-dev cmake
	mkdir -p $HOME/git/PROGRAMMING/LEAN
        cd $HOME/git/PROGRAMMING/LEAN
        git clone git@github.com:leanprover/lean.git
        cd lean
	mkdir -p build/release
	cd build/release
	cmace ../../src
	make
	
5. *VS Code* and *vscode-lean*

   First, go to https://code.visualstudio.com/  and download the vscode .deb file.

   Next, clone the `vscode-lean` repository with either 
   `git clone git@github.com:leanprover/vscode-lean.git`
   or 
   `git clone https://github.com/leanprover/vscode-lean`

   Then invoke the following at the command prompt of a terminal window:

   ```sh
   sudo dpkg -i code*.deb    # (installs vscode)
   sudo apt install npm      # (installs node package manager)
   cd $HOME/git/vscode-lean
   npm install
   ```
   Finally, open `vscode-lean` in vscode and start developing (F5 starts the debugger).


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

- Enable Thunderbolt 3 compatibility mode in the BIOS

- Disable internal card reader in BIOS (under security settings)

- Add kernel flag: acpi.ec_no_wakeup=1
  
  Do this by adding the following line to the file `/etc/default/grub`
  
        GRUB_CMDLINE_LUNUX="acpi.ec_no_wakeup=1"
  
  And then run `sudo update-grub`


---

## Install vscode-lean
