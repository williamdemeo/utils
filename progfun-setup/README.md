## progfun-setup

The script `setup.sh` will, on a 64 bit Ubuntu Linux machine, install some of the software
required for the Coursera course *Functional Programming Principles in Scala*, by Martin Odersky.

Here is what will be installed:

1. **git**  git-core, main components of Git version control system
2. **java** openjdk-7-jdk, unless a suitable JRE is already present
3. **sbt** sbt-0.13.2, version of the Scala build tool
4. **eclipse** scala-SDK-3.0.3-2.10-linux.gtk.x86_64, Eclipse IDE with Scala plugins

To run the script from a network connected Ubuntu 14.04 instance, invoke the following
three commands in a terminal window:

    wget https://raw.githubusercontent.com/williamdemeo/progfun-setup/master/setup.sh
	chmod a+x setup.sh
	. ./setup.sh

N.B. the dot (.) in front of ./setup.sh.

The first command above assumes wget is already installed on your system. If it
isn't, you can install it with:

    sudo apt-get install wget

**Help make it better!** If you try this script on a Ubuntu Linux machine and it doesn't work, I want to know!  Please open a [new issue](https://github.com/williamdemeo/progfun-setup/issues/new).


-----------------------------------------------------------------

### Testing with GitHub

You can test your setup with the following steps:

1. Clone ProgFun.git (a minimal version of the `example` project) and change to the example subdirectory:

        git clone git@github.com:williamdemeo/ProgFun.git
		cd ProgFun/example

2. Startup sbt *from within the example directory*.

        sbt

   Assuming sbt was installed correctly and is in your path, you should see
   something like

        [info] Loading project definition from /home/williamdemeo/git/ProgFun/example/project/project
        [info] Loading project definition from /home/williamdemeo/git/ProgFun/example/project
        [info] Set current project to progfun-example (in build file:/home/williamdemeo/git/ProgFun/example/)

   and then you arrive at the `>` prompt, which is the sbt command prompt.

3. At the sbt command prompt, enter `test`. If that went well, then at least
   your sbt is probably set up correctly. Type `exit` to leave sbt.

   (Step 3 is important since it causes sbt to pull down a copy of the
   lib_managed directory and jar files, which are not kept in my ProgFun
   repo, but which are required when importing the project into
   Eclipse. Otherwise Eclipse will complain that the Scala compiler is not in
   the CLASSPATH.)

4. Finally, test Eclipse (with Scala plugin).  Launch the program by entering `eclipse` in a terminal window.
   From the File menu,

        File --> Import
		
   then

        General --> Existing Projects into Workspace

   Browse to the location where you cloned the GitHub repostory in Step 1 above
   and click Finish.  The project should now be imported and you should be able to run
   the tests in the file:

        ProgFun/example/src/test/scala/example/ListSuite.scala

   Navigate to this file in the package browser tree and right click on it and then choose `Run as JUnit Test`.
