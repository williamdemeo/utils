# Notes on i3 configuration and usage

##  Launching applications: `$met+d`

There are two ways I know of; both require knowing the name of the
application.

**First way:** open a terminal with the command `$met+Enter` and then type
the program name at the command line to launch it.
(For example, type `google-chrome` in a terminal window.)

**Second way:** `$met+d` brings up the handy `dmenu`---a command line at
the top of the desktop---where you can enter (part of) the name of the
desired application. e.g., typing `i3 exit` from the `dmenu` will logout.

## Creating/destroying/moving windows

    $met+Enter     -->  open a new terminal window
    $met+v         -->  switches to vertical mode
                        so $met+j splits window vertically
    $met+h         -->  switches to horizontal mode
                        so $met+j splits window horizontally (the default)
    $met+e         -->  move current window from horizontal to vertical
                        (or vice-versa)
    $met+Shift+num -->  (where num is a number) move current window to
                        workspace num
    $met+Shift+q   -->  kill current window
                        typing exit from terminal also works

Note: if you kill the window from which other apps were launched, this will
kill those apps too.

## Moving around

    $met+j         -->  move left
    $met+k         -->  move down
    $met+l         -->  move up
    $met+;         -->  move right

## Miscellaneous

+ **adjust screen brightness**

        tee /sys/class/backlight/acpi_video0/brightness <<< 50

+ **logout** of window manager

        $met+d i3 exit

+ **suspend**

        ???
