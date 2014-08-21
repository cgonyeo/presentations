% How to bash
% Derek Gonyeo

# The command line

## History

- Back in the good old days people used text interfaces to use computers
- In the late 70s to the early 80s, people invented graphical user interfaces
- Ever since then modern computers have gotten consistently more annoying to use
- With a simple command line interface, developers can focus on the
  functionality of their programs, instead of the gradient on their buttons.

# Getting started

## Operating System

You want to use Linux for this. If that's not an option, Mac OS X can do.

If you want to follow along, install putty and ssh into rancor. I'll explain
what ssh is later.

## Open a terminal

Open a terminal. Hooray you have a prompt! The default shell in most places is called
bash.

Side note: a shell is your command line. It's a program used to interact with
your computer from a text interface.

## Location, Location, Location

When you're using bash, you're always at a place in your filesystem. It defaults
to your home folder. This is the `~` you see. When you change the directory 
you're in, the `~` will be replaced with where you are.

## Basic commands

Let's interact with some files!

- `ls` will list all the files for you in the folder you're in
- `mv file1 file2` will move file1 into file2. This can be used to change where
  something is, or rename a file. This will overwrite whatever file2 was.
- `cp file1 file2` will copy file1 to file2. This will also overwrite file2.
- `cd Pictures` will change directories into the Pictures folder in the current
  folder. Now `ls` will show you different files!

## Shortcuts

As I alluded to earlier, `~` is your home folder. `cd ~` will change your
directory to your home folder, no matter where you are.

`/` is the root of your computer. It's the highest level directory, like `C:` in
Windows land except without the dumb drive letter.

`.` refers to the current directory you are in.

`..` refers to the parent of the directory you're in. For example, `cd ..` will
go up one level.

## Hidden files

On Linux, to hide a file you simply make its name start with a period. That
way, it doesn't show up in `ls`. If you want to see hidden files, use `ls -a`.

## I forget. How do I ...?

If you forget or don't know the particulars of using a command, just type in
`man command` and it'll pull up the manual page for that command. For example,
take a look at `man mv`

# My computer's boring

## Let's go somewhere else!

`ssh` is a cool tool. It lets you open a shell on a different computer. With it
you can interact with files the exact same way you would on your local computer.

`ssh` stands for Secure SHell.

## To rancor!

`rancor.csh.rit.edu` is the user machine for CSH, so it's a place where all of
our members can go and do things. Run the command `ssh
username@rancor.csh.rit.edu` and enter in your password.

## Look around

Now `ls` and `cd` around. You're on a different computer! You can interact with
rancor now just as if you were over in the server room with a keyboard and
monitor.

# Let's do real things

## Find a file

Let's say you want to find the file `tits.jpg`. It's somewhere under your home
directory, but you don't know where. Go to the folder you want to search in, and
type the command `find . -name tits.jpg`

## Downloading

Want to download a file to your current directory? 

`wget http://pornhub.com/tits.avi`

## Copying files between computers

Have a file on your computer you want on rancor?

`scp localfile username@rancor.csh.rit.edu:`

Have a file on rancor you want on your local computer?

`scp username@rancor.csh.rit.edu:remotefile .`

Note: when copying to a remote machine, that `:` at the end is _necessary_!

## Editing text files

If you don't know how to use a real editor, for now you can use `nano filename`.
That'll give you a basic editor you can move around in with the arrow keys and
type in.

Come to my next seminar on how to use vim!

## Web space

CSH offers free web hosting for our members. Just put files in `.html_pages` or
`public_html` on rancor. If it's in `.html_pages`, it'll only be accessible by
members, and if it's in `public_html` it'll be available to everyone.

## IRC

IRC is from the 80s, and thus it's only acceptable to access it from the command
line. Luckily, this is easy. ssh into rancor, and run `irssi`.

You'll be presented with a semi-blank screen, and your cursor is at the bottom.
Enter in `/connect -ssl skynet.csh.rit.edu 6697` and you'll connect to CSH's IRC
server. From there, type in `/join #freshmen` to join the freshmen channel and
then you can start chatting away!

For further information on using irssi, talk to me after this or look it up on
the internet.

## tmux

tmux is a program that "enables a number of terminals to be created, accessed, 
and controlled from a single screen." To see what I mean, run the command `tmux`
on rancor, and do some things. Then press `Ctrl`+`b` and then `d`. You're back
outside of tmux now. You can do whatever, log out and back in even, and when you
type in `tmux attach` you'll be dropped back into tmux with the session the same
way you left it.

Some people use tmux + irssi on rancor to always be in IRC.

## Gaming

One of the best games ever created is nethack, and we have our own fork of it.
To play, run the command `telnet nethack.csh.rit.edu`. I'm sure there'll be a
seminar on nethack eventually if you want details on how to play, or talk to me
whenever.

## Movies

You can also watch a full movie from the terminal! Just type in `telnet
towel.blinkenlights.nl`

# Permissions

## File permissions

There are three permissions flags for files, one for reading, one for writing,
and one for executing. You can set each of these flags for three different
groups: the owner, the owner's group, and everyone. If you type in `ls -l`, the
first column shows the permissions on each file.

## Understanding permissions

Often the default permissions are fine, but if you want to prevent other people
on rancor from reading your super secret love letters you keep there, I'll show
you how to change them.

You have three sets of three boolean flags. Imagine each flag being represented
with a binary number, 0 is not set and 1 is set. If we had the permissions read
and write but not execute, that would be 110.

So the permissions for a file that everyone can read and write to, but no one
can execute, would be 110 110 110. If you convert the binary numbers to decimal,
it would be 666. This 3 digit binary (octal, actually) number is what's used
when setting permissions.

## Setting permissions

Let's say we have the file tits.avi (remember we downloaded it?), and we want to
give everyone permission to both read from and write to the file, but not
execute the file. The command would be:

`chmod 666 tits.avi`

chmod stands for change mode, or change file mode bits.

## Useful permission values:

 - 777: everyone can do everything
 - 700: only you can read, write, or execute the file
 - 755: you can do anything with file, others can only read from it
 - 600: only you can read or write to the file

The execute flag means you can run the file as if it's a program, or `cd` into
the directory if it's a directory.

## root

On every Linux system, there's a root account. This account has the power to do
whatever it wants. Permissions settings won't keep it out, it can mess with
anyone's files, and has access to everything. This account is often used to
install software, and manage system services. Many distributions are set up to
allow you to run a command as this user with the `sudo` command.

# Redirection

## Pipes

In Linux when a program goes to print something to the screen, you can instead
send it's output directly into another program. This is useful for filtering out
long lists, logging the results of a program, and for many other things.

In Linux, we can connect programs together with the `|` symbol.

## `grep`

`curl` is just like the `wget` command we saw earlier, except it prints out what
it downloads instead of saving it into a file. So let's try `curl -s
http://www.pornhub.com/`. That's a lot of text. I wonder if they use jquery...

`curl -s http://www.pornhub.com/ | grep jquery`

## `>`

How about if you want to send a program's output to a file? The `>` symbol will
write whatever it gets into a file. So to emulate what wget does:

`curl -s http://www.pornhub.com/ > pornhub.html`

## `>>`

The `>` symbol will delete whatever was previously in the file it's writing to.
If you want to instead append to a file, use `>>`.

## stderr

When a program prints to the screen, it can do so via stdout or stderr. The pipe
and redirects I've shown you will grab stdout, and ignore stderr. If you want to
grab just stderr, or both, or send stderr to stdout, or other fanciness, I'll
leave that for you guys to look up on your own.
