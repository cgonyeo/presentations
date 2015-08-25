<!-- Note: These are more presenter notes than an actual slideshow.     -->
<!--       The presenter should be going through the game as they talk. -->
% Introduction to Bingehack

## It is written

> After the Creation, the cruel god Moloch rebelled
> against the authority of Marduk the Creator.
> Moloch stole from Marduk the most powerful of all
> the artifacts of the gods, the Amulet of Yendor,
> and he hid it in the dark cavities of Gehennom, the
> Under World, where he now lurks, and bides his time.

## Objective

Descend to the bottom of the dungeon, get the Amulet of Yendor, climb back to
the top.

## Log in

Telnet to `games-ng.csh.rit.edu`.

`games-ng.csh.rit.edu` is our development environment, the stable version is
hosted at `games.csh.rit.edu`.

It'll prompt you to make an account.

## Play the Game

Create a new character. For this intro, let's play as a Dwarven Valkyrie.

## The UI

(this will differ if your display is too small)

Inventory is on the right

On the left the panes from top to bottom are:

- Message log
- Map
- Player Status
- Suggested Actions

## The World

You're the `@`. The thing with the blue backing is your pet. `f` for kitten and
`d` for dog.

## Movement

Because we all use vim here, we're going to use `hjkl` for movement. Try to move
around.

Nethack is turn based, so you'll want to not just move around a lot for no
reason.

## Start exploring

There are many rooms connected by doors. Your objective is to find the down
staircase (`>`) and go down, while collecting mad loot and killing things as you
go.

Not all tiles on the map can be instantly seen by you. If you find a dead end,
try pressing `s` to search where it would make sense for there to be something.
You're also not guaranteed to find what you're looking for in one search. You
can type in a number before an action to do it that many times, so `10s`.

Note, some dead ends really are dead ends!

You can also kick down locked doors, with `Ctrl-D`.

## Combat

When you find something that wants to kill you, you'll need to fight it. For up
close combat (so no bows or spells or anything), just try to walk into the
baddie to fight it.

Your health will automatically regenerate slowly.

## Items

You have some things in your inventory. You can also pick things up when you're
standing over them with `,`.

## Levelling up

When you kill things you gain experience. More levels means you get better at
killing things, and sometimes means you gain cool new abilities. The level of
dungeon that you're on has nothing to do with your experience level.

## Going Down

Press `>` while on top of the down stairs to go down to the next level.

Your pet needs to be next to you if you want to bring it with you.

## Getting Hungry

Eventually you'll need to eat something. You'll have started with 1-2 food
rations, so when you see a red `Hungry` on the screen you'll want to eat it. You
can also wait until you get `Weak`. After that comes `Fainting` though, where
you'll just spend many turns unconscious.

Press `e` to eat.

## Getting Spoilers

If you don't want to figure out the whole game for yourself (which is a serious
lesson in masochism), you can look stuff up at
[nethackwiki.com](https://nethackwiki.com/), or ask any of the upperclassmen who
play.

## That's it

That's all I'm going to give you for now. A lot of the fun is figuring out the
game as you go. Get playing.
