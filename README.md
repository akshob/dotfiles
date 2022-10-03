# dotfiles
## Introduction

This repository is a collection of shell startup file based on the analysis [here](https://blog.flowblok.id.au/2013-02/shell-startup-scripts.html)

The functions and environment variables are defined in the files under `.shell`. Depending on the shell you're using, relevant files are loaded. For ex, if you use `bash` then `.bash_profile` is loaded. If you use `zsh` then `.zprofile` is loaded. All these files load the files from `.shell` so there this project setup avoid duplication.

Sometimes, one would require defining functions that they don't want to be public (like work related scripts). If so, create a file `~/.secret_links` in your home directory, and add the links to the functions into the file. The initialization script will scan this file and curl the contents and place it in `.shell/login_secret`.
(In my case I chose to create a private gist. Remember, in order to keep the contents private, the link needs to be accessible to you and not to be public!)

## Installation

```
brew tap akshob/tools
brew install dotfiles-init
```

`brew` will spit out a message asking you to add links to your private scripts/functions, if any.

Now run
```
dotfiles-init
```
This will copy this project's dotfile setup into your home directory.

Enjoy!

## Contributing

If you feel something can be done better, or you have suggestions, please open an issue or submit a PR!

## Resources
- [Unix shell initialization](https://github.com/pyenv/pyenv/wiki/Unix-shell-initialization)
- https://unix.stackexchange.com/a/541092
- [Shell startup scripts](https://blog.flowblok.id.au/2013-02/shell-startup-scripts.html)
- https://unix.stackexchange.com/a/8658
- [Understanding the bin, sbin, usr/bin , usr/sbin split](http://lists.busybox.net/pipermail/busybox/2010-December/074114.html)

## Credits

[flowblok](https://github.com/flowblok)
