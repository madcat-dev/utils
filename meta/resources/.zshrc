#
# ~/.zshrc
#

[[ -f ~/.profile ]] && source ~/.profile

# Включить автодополнение
autoload -U compinit && compinit
autoload -U promptinit && promptinit

# Completion for kitty
if [[ ! `which kitty | grep "not found"` ]]; then
    kitty + complete setup zsh | source /dev/stdin
fi

# Для pacman
[[ -a $(whence -p pacman-color) ]] && compdef _pacman pacman-color=pacman

# Корректировка ввода
setopt CORRECT_ALL
# Если в слове есть ошибка, предложить исправить её
SPROMPT="Ошибка! ввести %r вместо %R? ([Y]es/[N]o/[E]dit/[A]bort) "
# Не нужно всегда вводить cd
# просто наберите нужный каталог и окажитесь в нём
setopt autocd
# При совпадении первых букв слова вывести меню выбора
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Команда Help
autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
unalias run-help
alias help=run-help

# Горячие клавиши
bindkey -e

bindkey '^[[H'  beginning-of-line
bindkey '^[[F'  end-of-line
bindkey '^[[2~' overwrite-mode
bindkey '^[[3~' delete-char
bindkey '^[[A'  up-line-or-history
bindkey '^[[B'  down-line-or-history
bindkey '^[[D'  backward-char
bindkey '^[[C'  forward-char
bindkey '^[[5~' beginning-of-buffer-or-history
bindkey '^[[6~' end-of-buffer-or-history

# History
# хранить историю в указанном файле
export HISTFILE=~/.zsh_history
# максимальное число команд, хранимых в сеансе
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE
# включить историю команд
setopt APPEND_HISTORY
# убрать повторяющиеся команды, пустые строки и пр.
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS


# установка title терминала
precmd() {
    if [[ $VIRTUAL_ENV ]]; then
        print -Pn "\e]0;(`basename \"$PWD\"`) ${PWD/$HOME/\~}\a"
    else
        print -Pn "\e]0;${PWD/$HOME/\~}\a"
    fi
}


# Цвета
autoload -U colors && colors
# Set CLICOLOR if you want Ansi Colors
export CLICOLOR=1

# Information from version control systems
autoload -Uz vcs_info
zstyle ':vcs_info:*:*' formats ' %F{3}[%b]%f'
precmd_vcs_info() {
    vcs_info 
}
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# Приглашение командной строки
export PROMPT='%F{2}%n@%m%f:%F{4}%~%f${vcs_info_msg_0_} >>> '

