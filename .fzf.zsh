# Setup fzf
# ---------
if [[ ! "$PATH" == *${HOMEBREW_PATH}/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${HOMEBREW_PATH}/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${HOMEBREW_PATH}/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${HOMEBREW_PATH}/opt/fzf/shell/key-bindings.zsh"
