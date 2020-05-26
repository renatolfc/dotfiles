# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME=flazz

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git archlinux ssh-agent vi-mode taskwarrior)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export BROWSER='firefox' \
       EDITOR='vim' \
       PAGER='less'

setopt NO_clobber \
       extended_history \
       glob_complete \
       hist_allow_clobber \
       hist_expire_dups_first \
       hist_ignore_all_dups \
       hist_ignore_dups \
       hist_ignore_space \
       hist_reduce_blanks \
       hist_verify \
       share_history \
       interactive_comments \
       list_packed \
       long_list_jobs \
       multios \
       numeric_glob_sort \
       posix_builtins \
       prompt_subst \
       pushd_ignore_dups \
       appendhistory \
       autocd

source $HOME/.zshrc.aliases

LESSPIPE=$(which lesspipe.sh)
if [ ! -z "$LESSPIPE" ]
then
    export LESSOPEN="| $LESSPIPE %s"
fi

export LESS='-iR'
export LESS_TERMCAP_mb=$'\E[01;31m'   # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'   # begin bold
export LESS_TERMCAP_me=$'\E[0m'       # end mode
export LESS_TERMCAP_se=$'\E[0m'       # end standout-mode
export LESS_TERMCAP_so=$'\E[1;33;40m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'       # end underline
export LESS_TERMCAP_us=$'\E[1;32m'    # begin underline

# Load/configure key bindings

bindkey -v
WORDCHARS='' # Use emacs-style word matching

autoload -Uz select-word-style
select-word-style normal
zstyle ':zle:*' word-style subword

autoload -Uz down-line-or-beginning-search up-line-or-beginning-search
zle -N down-line-or-history down-line-or-beginning-search
zle -N up-line-or-history up-line-or-beginning-search

tmux-copy-mode-pageup() { [[ "$TMUX" != "" ]] && tmux copy-mode -u }
tmux-copy-mode() { [[ "$TMUX" != "" ]] && tmux copy-mode }
zle -N tmux-copy-mode-pageup tmux-copy-mode-pageup
zle -N tmux-copy-mode tmux-copy-mode

bindkey '\e[3~' delete-char
#bindkey '^R' history-incremental-search-backward

if [[ "$TERM" = xterm* ]]
then
    bindkey '\e[1;5A' up-line-or-history \
            '\e[1;3A' up-line-or-history \
            '\e[1;5B' down-line-or-history \
            '\e[1;3B' down-line-or-history \
            '\e[1;5D' backward-word \
            '\e[1;3D' backward-word \
            '\e[1;5C' forward-word \
            '\e[1;3C' forward-word
fi

bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
case $TERM in (xterm*)
    bindkey '\eOH' beginning-of-line
    bindkey '\eOF' end-of-line
esac
bindkey '^[[3~' delete-char
bindkey '^[[6~' end-of-history
#bindkey '\e[2~' redisplay
bindkey ^R history-incremental-pattern-search-backward

#autoload zkbd
#function zkbd_file() {
#    [[ -f ~/.zkbd/${TERM}-${VENDOR}-${OSTYPE} ]] && printf '%s' ~/".zkbd/${TERM}-${VENDOR}-${OSTYPE}" && return 0
#    [[ -f ~/.zkbd/${TERM}-${DISPLAY}          ]] && printf '%s' ~/".zkbd/${TERM}-${DISPLAY}"          && return 0
#    return 1
#}
#[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
#keyfile=$(zkbd_file)
#ret=$?
#if [[ ${ret} -ne 0 ]]; then
#    zkbd
#    keyfile=$(zkbd_file)
#    ret=$?
#fi
#if [[ ${ret} -eq 0 ]] ; then
#    source "${keyfile}"
#else
#    printf 'Failed to setup keys using zkbd.\n'
#fi
#unfunction zkbd_file; unset keyfile ret

[[ -n "${key[Backspace]}" ]] && bindkey "${key[Backspace]}" \
                                        backward-delete-char
[[ -n "${key[Insert]}" ]] && bindkey "${key[Insert]}" beep
[[ -n "${key[Home]}" ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n "${key[PageUp]}" ]] && bindkey "${key[PageUp]}" tmux-copy-mode-pageup
[[ -n "${key[Delete]}" ]] && bindkey "${key[Delete]}" delete-char
[[ -n "${key[End]}" ]] && bindkey "${key[End]}" end-of-line
[[ -n "${key[PageDown]}" ]] && bindkey "${key[PageDown]}" tmux-copy-mode
[[ -n "${key[Up]}" ]] && bindkey "${key[Up]}" up-line-or-history && \
                         bindkey "\e${key[Up]}" up-line-or-history
[[ -n "${key[Left]}" ]] && bindkey "${key[Left]}" backward-char && \
                           bindkey "\e${key[Left]}" backward-word
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-history && \
                           bindkey "\e${key[Down]}" down-line-or-history
[[ -n "${key[Right]}" ]] && bindkey "${key[Right]}" forward-char && \
                            bindkey "\e${key[Right]}" forward-word
[[ -n "${key[Control-Left]}" ]] && bindkey "${key[Control-Left]}" backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey "${key[Control-Right]}" \
                                            forward-word

export GOPATH=~/go

export TEXMFHOME=~/texmf

export PATH=~/bin:$PATH

alias evince=okular

export HISTSIZE=100000

alias grep="grep --color=auto"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
alias open=xdg-open

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '$'
}

#PROMPT="$PROMPT
#$(prompt_char) "

if [[ $TERM == xterm-termite ]]; then
    . /etc/profile.d/vte.sh
    __vte_osc7
fi

if [ ! -z "$DISPLAY" ]; then
    export TERM=xterm-256color
fi

#export PATH=/home/renatoc/miniconda3/bin:/usr/local/bin:$PATH

export LANGUAGE=en_US.utf-8
export LC_DATE=en_DK.utf-8
export LC_ALL=en_US.utf-8

alias vim=nvim
