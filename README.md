# Dotfiles

Configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Font

These configs expect **Hack Nerd Font Regular** at size **12**.

Download: [Hack Nerd Font v3.4.0](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hack.zip)

## Install

### Prerequisites

Install GNU Stow:

```bash
# macOS
brew install stow

# Arch
sudo pacman -S stow

# Debian/Ubuntu
sudo apt install stow
```

### Usage

Clone the repo and stow individual packages:

```bash
git clone <repo-url> ~/git/egorps
cd ~/git/egorps

# Stow individual configs (symlinks into ~/.config/ or ~/ as appropriate)
stow tmux        # ~/.tmux.conf
stow kitty       # ~/.config/kitty/
stow starship    # ~/.config/starship.toml
stow hyprland    # ~/.config/hypr/hyprland.conf
stow hypridle    # ~/.config/hypr/hypridle.conf
stow hyprlock    # ~/.config/hypr/hyprlock.conf
stow hyprmocha   # ~/.config/hypr/mocha.conf
stow hyprpaper   # ~/.config/hypr/hyprpaper.conf
stow waybar      # ~/.config/waybar/
stow wofi        # ~/.config/wofi/
stow zshrc       # ~/.zshrc
```

Or stow everything at once:

```bash
stow */
```

### Uninstall

Remove symlinks for a package:

```bash
stow -D tmux
```

### Note

Each directory mirrors the target structure relative to `$HOME`. For configs that live in `~/.config/`, the package directory should contain a `.config/` subdirectory. For example:

```
kitty/.config/kitty/kitty.conf  ->  ~/.config/kitty/kitty.conf
tmux/.tmux.conf                 ->  ~/.tmux.conf
```
