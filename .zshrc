# https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-pagination.html
export AWS_PAGER=""

export GOPATH="${HOME}/Documents/Source/Go"
export PATH="${GOPATH}/bin:${PATH}"
export STARSHIP_CONFIG="${HOME}/.starship"
export ZSH="${HOME}/.oh-my-zsh"

plugins=(git kubectl)

source "${ZSH}/oh-my-zsh.sh"

source "${HOME}/.zsh_aliases"
source "${HOME}/.zsh_functions"

macchina --bar --color blue --custom-ascii /etc/arch-ascii --palette full --theme beryllium

eval "$(starship init zsh)"
