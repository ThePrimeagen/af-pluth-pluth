## Alternate File pluth pluth
I have been bothered by my navigation lately.  I want to love marks, but I
don't, probably my fault.  I don't like fuzzy finders to use consistently.  I
feel like its an anti-pattern.  `:e` is worse.  Alternate file is amazing, but
only works with 1 file.  This is literally what it sounds like.  It allows
jumping back up to two files.


## How to use
### Requirements
* Vim
* Coconut Oil
* Bouncy Ball Chair

### Install
Favorite Plugin Manage

```viml
Plug 'ThePrimeagen/af-pluth-pluth'
```

### Remaps
I use a [Kinesis Advantage 2](bit.ly/primeagen-adv2) so the arrow keys are
simple to get to.  Therefore I do the following keys

```viml
" This replaces the usage of <C-^> for me
" You really don't have to do this, it just works better if you also use pluth
" pluth.
nnoremap <C-Left> :call AfPPAlternate()

" This allows for the retrieval of 2 files ago
nnoremap <C-Up> :call AfPPAlternatePluthPluth()
```

## This is just an idea
I am trying to come up with some better ways to navigate since I cannot stand
my current experience.  I want something where I press a key and it goes where
I want.  Marks seem to be the most promising, just haven't found my jam yet
with them.

### Downside
It works when you use `<C-^>`, but it messes up the state a bit which does hurt
my feels.  This is why I have 2 functions available (example below).

Lets say you have the following 3 files opened, `a`, `b`, and `c` in that order.

If you were to spam `<C-^>` you would swap back and forth between `a` and `b`.
The same would happen if you `:call AfPPAlternate()`.  If you were to call
`:call AfPPAlternatePluthPluth()` you would go to `c` from `a`.  If you call it
multiple times you go back and forth between `a` and `c`.  But this means your
alternate file becomes `a` (or `c` depending on your current file) which means
you lose access to `b`.  But if you use `:call AfPPAlternate()` it will
actually get `b`.  This allows for you to actually swap back and forth between
1 and 3 and 1 and 2.  It keeps state.  If you manually navigate it will reset
the state.

### Support
Come join me on [Twitch](https://twitch.tv/ThePrimeagen)
