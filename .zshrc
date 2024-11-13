if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/home/avi/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  aws
  # zsh-autocomplete
  zsh-autosuggestions
  zsh-syntax-highlighting
  fast-syntax-highlighting
  zsh-history-substring-search
  # virtualenvwrapper # NOTE - this plugin could replace the custom python venv activation func I have in `.profile` if I switched to `virtualenv`, which looks like a good alternative b/c it appears to be widely used & supported online
)

# fix text pasting lag zsh-syntax-highlighting.zsh (from: https://gist.github.com/magicdude4eva/2d4748f8ef3e6bf7b1591964c201c1ab)
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# oh-my-zsh integration
source $ZSH/oh-my-zsh.sh

# autojump - https://github.com/wting/autojump#automatic
# NOTE - for Mac OS, use: [ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
source /usr/share/autojump/autojump.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# load my profile (includes nvm, pyenv, aliases, etc)
[ ! -e ~/.profile ] || . ~/.profile

# bun completions
[ -s "/home/avi/.bun/_bun" ] && source "/home/avi/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/home/avi/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# enable true color - https://askubuntu.com/a/1329392/1567235
export COLORTERM=truecolor
