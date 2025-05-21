# `drag`

~~A commandline util~~ An app to drag & drop stuff. Useful for when you need to
drop something from somewhere while working from the command line, e.g.:

```sh
~/Applications/drag.app/Contents/MacOS/drag <file>
```

to open a tiny window you can drag the `<file>` from. Will close when you cancel
the process (`ctrl-c`) in your terminal.

I recommend you make an alias for this, e.g.

```sh
alias drag=~/Applications/drag.app/Contents/MacOS/drag
```

## Install

Just run `make`.

## File access

MacOS has complicated file access permissions. If you want to be able to use
`drag` on files from your Desktop, Downloads, Documents or anywhere else macOS
likes to be weird, the easiest way to achieve this is to give it *Full Disk
Access* in your system preferences. If you don't want to do this because you
don't trust the app, just read the code, it's tiny and you'll feel comfortable
in a couple of minutes.
