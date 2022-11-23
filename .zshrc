# ZSH options
setopt autocd extendedglob nomatch notify
setopt interactive_comments
setopt magicequalsubst
setopt numericglobsort
unsetopt beep

# History configurations
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory
setopt hist_expire_dups_first
setopt histignorespace
setopt histignorealldups 
setopt sharehistory

# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^U' backward-kill-line                   # ctrl + U
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action

# custom completion features
fpath=($HOME/.zsh/zsh-completions/src $fpath)
zstyle :compinstall filename '/home/orion/.zshrc'
autoload -Uz compinit && compinit -i
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Sourcing scripts from zsh-scripts 
[[ -f ~/.zsh/zsh-scripts/aliases.zsh ]] && source ~/.zsh/zsh-scripts/aliases.zsh
[[ -f ~/.zsh/zsh-scripts/functions.zsh ]] && source ~/.zsh/zsh-scripts/functions.zsh
[[ -f ~/.zsh/zsh-scripts/starship.zsh ]] && source ~/.zsh/zsh-scripts/starship.zsh
[[ -f ~/.zsh/zsh-scripts/wsl2fix.zsh ]] && source ~/.zsh/zsh-scripts/wsl2fix.zsh

# Loads the Starship Prompt
eval "$(starship init zsh)"

# Symlink folder added to path
export PATH="$HOME/.local/bin:$PATH"

# zplug settings
source $HOME/.zplug/init.zsh

zplug 'b4b4r07/zplug-doctor', lazy:yes
zplug 'b4b4r07/zplug-cd', lazy:yes
zplug 'b4b4r07/zplug-rm', lazy:yes
zplug "changyuheng/fz", defer:1
zplug "rupa/z", use:z.sh

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
    echo
fi

zplug load

# ZSH features settings
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern line cursor)

# FZF configurations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_BASE="$HOME/.fzf"
export FZF_DEFAULT_COMMAND='fd --type f --color=auto --hidden'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS=" --no-height --preview 'bat --color=always --line-range :50 {}'"

export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"

# Enable ZSH features
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
