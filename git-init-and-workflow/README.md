This guide assumes you have already installed the git program on your machine.
(See the [instructions here](https://help.github.com/articles/set-up-git/) if
you don't yet have git istalled on your machine.)

The commands described below are known to work at the Linux command line, but
they probably also work in a terminal window on a Mac.

1. *Create a remote repository for your project* (in the cloud)

   + This is where you will store, organize, and keep records of your files.

   + As of this writing, the two most commonly used websites that offer free and easy
     hosting of git repositories are GitHub.com and Bitbucket.org.

   For GitHub, follow [these instructions](https://help.github.com/articles/create-a-repo/).

   For Bitbucket, follow [these instructions](https://confluence.atlassian.com/bitbucket/create-a-repository-for-your-existing-files-800695576.html).

   In the next step, I will assume you named your new remote repository project1.
   Also, we sometimes use the abbreviation "repo" to mean "repository."

2. *Create a local repo for your project* (on your own harddrive)

   (a) Create a directory called project1.
   (b) Make project1 the current working directory.
   (c) Create a README.md file for your project.
   (d) Initialize project1 as a new git repo with the `git init` command.
   (e) Connect the local repo with the remote repo using `git remote add origin`.

   At the command line, these steps are accomplished as follows:

           mkdir project1
           cd project1
           echo "# project1" >> README.md
           git init
           git remote add origin git@github.com:your_git_username/project1.git

3. *Add and commit new files and changes, then push to the remote repo*

   (a) "Stage" the README.md file using `git add`
   (b) "Commit" the staged changes using `git commit`
   (c) "Push" the changes to the remote repo using `git push`

           git add README.md
           git commit -m "first commit"
           git push -u origin master

If all went well, then from now on, when you want to add new files to the
project1 repo, or commit changes to existing files, you will repeat the three
simple steps---(a), (b), (c)---described in Part 3 above.
