# Merge starship.remote.toml + starship.local.toml -> starship.toml
python3 ~/.config/starship-merge.py 2>/dev/null
export EDITOR="vim"
export SUDO_EDITOR="$EDITOR"

HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000

setopt inc_append_history

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source local overrides (machine-specific config not tracked in dotfiles)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

eval "$(starship init zsh)"
