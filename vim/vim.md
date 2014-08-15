% How to vim
% Derek Gonyeo

# What is vim?

# What would I use vim for?

# Let's write something

## Open vim

You're welcome to install it on your own machine, but for the sake of this
seminar let's all go use vim on rancor. If you have a Linux or Apple machine,
just do this from terminal. If you have a windows machine, you'll need to go
grab putty or something.

- `ssh USERNAME@rancor.csh.rit.edu`
- `vim testfile.txt`

## Go into insert mode

When you first open vim if you try to type something, things aren't going to go
your way. To be able to type stuff, press `i`.

## Type some stuff

1. Type things
2. Write some sweet code
3. ???
4. Profit

## Leave insert mode

Press `Esc` to go back to the normal mode.

# Normal Mode

## Moving the cursor

        ▲
        k
    ◀ h   l ▶
        j
        ▼

Move the cursor with the `h`, `j`, `k`, and `l` keys. This keeps your fingers in
the center of the keyboard, and means you can work more comfortably and faster.

## Delete (cut) a line

Want to delete a line? That's done with the `d` key. Move your cursor to the
right line, and press `dd`.

## Put (paste) a line

Let's put that line you just took somewhere else. Put the cursor somewhere, and
press `p`.

## Yank (copy) a line 

Want to duplicate a line? Press `yy` on a line to yank it, and then you can
press `p` wherever you want to put it there.

## Doing things more than once

You can do things multiple times. Want to move the cursor in a direction 10
times? Type in `10` and then hit one of the movement keys.

## Why `dd` instead of just `d`?

The first `d` means "delete", the second `d` means "this line". You can give it
other commands, for example `d5j` will delete the current line and 5 lines below
it. This also applies to yanking and putting.

# Visual Mode

## Select some text

Counting how many lines or characters you want to delete can be a pain, so I'm
going to show you visual mode. Press `v`, and then move the cursor. You can
highlight text like this, and pressing `d` or `y` will delete or yank
specifically the text you have highlighted.

## Select some lines

Press `Shift` + `v` to go in to Visual Line mode. This means you select lines at
a time, instead of characters.

# Searching

## Search forward

Press `/` and then enter in your search query. When you press enter, you'll be
taken to the next occurrence of the search. You can press `n` to go to the next
occurrence, and keep going until you find what you want.

## Search backwards

Same thing as searching forwards, just use `?` instead of `/`.

## Searches are regexes

Your search queries are regular expressions. If you know how to use them, it's a
powerful feature. If you don't you can mostly ignore them (or learn them!), but
be aware you may not get what you want if you start throwing non-alphanumeric
characters into your searches.

# Search and replace

## In visual mode

Let's say you have some variable named `foo`, and you want to rename it to
`bar`. The easiest way to do this is a search and replace. Enter visual mode and
select some text, and then type in `:s/foo/bar` and hit `Enter`.

## Globally

Let's say you want to do this on an entire file. Selecting all the lines in
visual mode would be silly, so you can do this: `:%s/foo/bar`

## Tips and tricks

- The first part here is still a regular expression
- It'll only replace the first occurrence it finds on each line. To replace
  more, add `/g` on to the end of it

# `:`

## Commands

The `:` character allows you to type in a command to vim. We used it in the last
section for searching and replacing

## Getting help

Don't know what a key does? Type in `:help z` where z is whatever key you're
curious about. The documentation is pretty good, and there's help for just about
anything.

## Do something globally

You can do a lot of things on an entire file (again, like in the last section)
by typing in `:%` and then the command. 

Want to delete an entire file? `:%d`

Want to yank an entire file? `:%y`

## Save the file

Don't use `Ctrl` + `s`. Either nothing will happen, or your terminal will freeze
(`Ctrl` + `q` unfreezes). To save the file, type in `:w` and hit `Enter`. You'll
see something like `"testfile.txt" 153L, 4187C written` appear at the bottom of
the screen.

## Quit vim

I don't know why you'd ever do this, but you can enter in `:q` and hit `Enter`
to quit vim. For added convenience, `:wq` will save the file and exit.

# More Learning

## How to get better

- Just start using it!
- Run the command `vimtutor` on rancor
- Google is your friend
- Look up some random help page in vim

# Advanced usage

## Visual block select

`Ctrl` + v

- `dyp` are all kinda nifty in it
- `Shift` + `i` will insert some string before the block on every line

## .vimrc

You can (and should) customize vim. Put settings in a text file called `.vimrc`
in your home folder. If you want to see what mine's like, it's available
[here](https://github.com/dgonyeo/dotfiles/blob/master/.vimrc). You definitely
don't need something as lengthy as mine to get started.

## Plugins

Vim doesn't do something you want or doesn't behave how you like? There's a 
bunch of plugins, and even plugins for managing your plugins.

## Macros

Want to do some combinations of key 500000 times? Read up on how to use macros.

## Multiple files

You can edit multiple files at the same time. If you want tabs google around for
it, I'll cover window splits in a bit.

## Random useful key bindings

- `Shift` + `i` == enter insert mode at the beginning of the line
- `Shift` + `a` == enter insert mode at the end of the line
- `o` means make a new line below the current and put the cursor there in input
  mode
- `s` in visual mode will delete the text you have selected and put you in
  insert mode
- `w` and `e` will jump to the next word (they jump to different locations)
- `:` + a number will move the cursor to that line number

## Window splits

You can view multiple parts of a file at the same time, or have multiple files
on the screen at the same time.

- `Ctrl` + `w` and then `s` or `v` will split the screen
- `Ctrl` + `w` and then `hjkl` will move between the splits
- `:e` is "edit a file". Type in `:e path/to/file` in a split and it'll open the
  file there.
