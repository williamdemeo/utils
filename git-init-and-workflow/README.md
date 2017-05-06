# Git init and workflow

This page explains how to initialize a git repository and how to execute the three most basic git commands used to manage project files.  The aim of this guide is to help students get started with git, and it covers only the bare minimum needed to get going.

## Prerequisites

This guide assumes the following:

+ **Git.** You already installed the `git` program on your machine. 
  (If not see the
  [install-git tutorial](https://www.atlassian.com/git/tutorials/install-git).)

+ **Bitbucket or GitHub.** You have a Bitbucket or GitHub
  account. (If not, go to
   [bitbucket.org](https://bitbucket.org/) or
   [github.com](https://github.com) to create one.)

+ **SSH keys.** You shared your public ssh-key with Bitbucket or GitHub. (If not, see
   the instructions for [Bitbucket](https://confluence.atlassian.com/bitbucket/add-an-ssh-key-to-an-account-302811853.html#AddanSSHkeytoanaccount-HowtoaddakeyusingSSHforOSXorLinux)
   or 
   [GitHub](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/).

-------------------------------------------

## Create a remote repository for your project (in the cloud)

The commands described here are known to work at the Linux command line, but
they probably also work in a terminal window on a Mac.

+ This is where you will store, organize, and keep records of your files.

+ As of this writing, the two most commonly used websites that offer free and easy hosting of git repositories are GitHub.com and Bitbucket.org.

+ For GitHub, follow [these instructions](https://help.github.com/articles/create-a-repo/).

+ For Bitbucket, follow [these instructions](https://confluence.atlassian.com/bitbucket/create-a-repository-for-your-existing-files-800695576.html).

In the next step, I will assume you named your new remote repository `project1`.

--------------------------------------------

## Create a local repo for your project (on your own harddrive)

Here is are the steps required to create a local repository.
For the precise syntax, see the example below.

1. Create a directory called `project1` and `cd` into that directory.
2. Create a `README.md` file for your project.
3. Initialize project1 as a new git repo with the `git init` command.
4. Connect the local repo with the remote repo using `git remote add origin`.

At the command line, these steps are accomplished as follows:

    mkdir project1
    cd project1
    echo "# project1" >> README.md
    git init
    git remote add origin git@github.com:your_git_username/project1.git

--------------------------------------

## Add and commit new files and changes, then push to the remote repo

1. *Stage* the README.md file using the `git add` command (as shown below).
2. *Commit* the staged changes using the `git commit`command.
3. *Push* the changes to the remote repo using the `git push` command.

        git add README.md
        git commit -m "first commit"
        git push -u origin master

If all went well, then from now on when you want to add new files to
the `project1` repo or commit changes to existing files, you will repeat
these three simple steps: 1. stage, 2. commit, 3. push.

----------------------------------

## Branching and pull requests
The next thing you should learn how to do is to create and merge
branches, and submit and accept pull requests.  These topics are
covered in many place already, and the point of this little tutorial was to simply demonstrate a very basic git workflow.

For a nice and easy explanation of basic things like branching and pull requests, I recommend [git--the simple guide](http://rogerdudler.github.io/git-guide/).
