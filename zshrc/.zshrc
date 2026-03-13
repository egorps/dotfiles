# Merge starship config with local overrides (if ~/.config/starship.local.toml exists)
_starship_cfg=$(python3 ~/.config/starship-merge.py 2>/dev/null)
if [[ -n "$_starship_cfg" ]]; then
  export STARSHIP_CONFIG="$_starship_cfg"
fi
unset _starship_cfg
export EDITOR="vim"
export SUDO_EDITOR="$EDITOR"

HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000

setopt inc_append_history

source ~/miniconda3/bin/activate

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source local overrides (machine-specific config not tracked in dotfiles)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

eval "$(starship init zsh)"
