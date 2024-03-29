# My Setup

I want to keep track of the things that I use and and how they're set up. This should end up being my full dotfiles repo. 

## the tools

- [Alacritty](#alacritty)
    - zsh
- [neovim](#neovim)
    - nvchad
- [tmux](#tmux)
- [todoist](#todoist)
- notion calendar
- syncthing
- digital ocean
- ssh

And a small bit of hardware: my zsa moonlander mk1 setup. 

i realize that some of these will not have config files (notion calendar specifically) but I want to at least document *why* i use it. 

### Alacritty

I started using alacritty in 2021 in an attempt to replace my clunky terminal (iterm2 at the time) with something a bit more snappy and configurable. Now, it's the only terminal emmulator I want to use. 

My current configuration is a yaml file because only recently has TOML been the file type of choice for the config file. I'll be looking to make the change to TOML soon, so long as I accept the reason they made the switch.

### Tmux 

The most powerful terminal multiplexor around. An absolute chad of a program. my config is _very_ basic currently as i've mostly just made the key binding (which i should probably rebind again now that i think about it). I also need to look into attaching and detaching ssh sessions through tmux since I do a lot of that. 

### Neovim 

My journey with text editors feels like it's been an unnecessary one. I first started with visual studio code when I was first learning how to code, and honestly, it's still in the mix. Especially when it comes to multicursor editing as well as jupyter notebooks. But I wanted to use open source software that was relatively stripped down but highly configurable, as well as open sourced and lightweight. So, I messed around with sublime text a bit, but didn't quite fall in love with it. I tried emacs for a little, and aboslutely loved it, but I couldn't really get a handle on the keybindings, and i never really harnessed org mode on it, plus it's not that fast. 

I then ventured into "legacy" vim, and really enjoyed it, but it was _very_ basic in what it really did. I then tried helix itself, which was a great time, but by that time the vim bindings had taken ahold in my brain, so it was hard to really get a grasp on. And then, i landed on neovim, and haven't really looked back since. Because i primarily write python and markdown (currently), neovim has been a *great* switch because it's lightweight and extensible enough for me to put on my remote machines and just be able to ssh into those and use the same editor i use on my own machine. 

similar to my use with tmux, there's no way i'm getting the most out of neovim. but i feel like i'm getting closer with nvchad as well (my prebuilt configuration of choice). and again, because i only write python and markdown i really only have to change up the LSPs in place in favor of [python-language-server](https://github.com/python-lsp/python-lsp-server) and [marksman](https://github.com/artempyanykh/marksman). I'm sure that once i write other software, my plugins will change as well. 

### todoist


