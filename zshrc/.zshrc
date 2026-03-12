# Merge starship config with local overrides (if ~/.config/starship.local.toml exists)
_starship_cfg=$(python3 ~/.config/starship-merge.py 2>/dev/null)
if [[ -n "$_starship_cfg" ]]; then
  export STARSHIP_CONFIG="$_starship_cfg"
fi
unset _starship_cfg
eval "$(starship init zsh)"
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000

setopt inc_append_history

source ~/miniconda3/bin/activate

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/john/.lmstudio/bin"
# End of LM Studio CLI section

export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
export JAVA_HOME="/opt/homebrew/opt/openjdk@21"
export PATH="$JAVA_HOME/bin:$PATH"

# Added by Antigravity
export PATH="/Users/john/.antigravity/antigravity/bin:$PATH"
