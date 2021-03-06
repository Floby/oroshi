# Nice to have:
# [ ] Autocompletion while I type, with the first tab-suggested suggestion
# already filled in a darker color (fish-like behavior)
# [ ] Move through suggestions using vim keys
# [ ] Complete host names in rsync and ssh

local zshConfigDir=~/.oroshi/config/zsh
source $zshConfigDir/completion/npm
source $zshConfigDir/completion/tmuxinator
source $zshConfigDir/completion/_docker-container-all
source $zshConfigDir/completion/_docker-container-running
source $zshConfigDir/completion/_docker-container-stopped
source $zshConfigDir/completion/_docker-image
source $zshConfigDir/completion/_git-branches
source $zshConfigDir/completion/_git-files
source $zshConfigDir/completion/_git-remotes
source $zshConfigDir/completion/_git-tags
source $zshConfigDir/completion/mark

# Auto escape &, ? and * when needed
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Enable completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# What to complete... {{{
# Try to complete first, and then correct
zstyle ':completion:*' completer _complete _correct
# Search for completion in the whole filename, not just on the start
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
# Disable showing the menu on first tab press
unsetopt MENU_COMPLETE
# In case of ambiguous match, complete up to the last ambiguous letter...
setopt LIST_AMBIGUOUS
# ... and then, pressing TAB will display the menu
setopt AUTO_MENU
# Try first to match regexp markers and continue as a normal char if nothing
# matches.
unsetopt NOMATCH
# Completion should also complete .dotfiles
setopt GLOB_DOTS
# Completion should not handle aliases as new commands, but internally expand
# them, and suggestion completion for the underlying command
unsetopt COMPLETE_ALIASES
# Wait 10s before rm ./*
setopt RM_STAR_WAIT
# }}}

# How to display completion... {{{
# File completion is colored
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Selected file is highlighted
zstyle ':completion:*' menu select
# Completion type separator
zstyle ':completion:*:descriptions' format '%F{069} %d%f'
# No completion found
zstyle ':completion:*:warnings' format '%F{136}  No completion found%f'
zstyle ':completion:*:messages' format '%F{136}  %d%f'
# Do not add trailing / to dirs or @ to symlinks
unsetopt LIST_TYPES
# Display suggestions horizontally
setopt LIST_ROWS_FIRST
# }}}

# Debug method to reload the completion functions {{{
r() {
  \rm -f ~/.zcompdump
  \rm -f ~/.zcompcache/grunt
  local f
  f=($zshConfigDir/completion/*(.))
  unfunction $f:t 2> /dev/null
  autoload -U $f:t
}
# }}}
