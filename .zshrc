if [ -f "/opt/homebrew/bin/brew" ]
then
  HOMEBREW_PATH="/opt/homebrew"
fi

if [ -f "/usr/local/bin/brew" ]
then
  HOMEBREW_PATH="/usr/local"
fi

export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:${HOMEBREW_PATH}/bin:${PATH}"

# https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-pagination.html
export AWS_PAGER=""

# Increase GitHub API Rate Limits - https://developer.github.com/v3/#rate-limiting
# envchain --set github 'GITHUB_OAUTH_TOKEN'
export GITHUB_OAUTH_TOKEN="$(envchain github env | grep 'GITHUB_OAUTH_TOKEN' | cut -d '=' -f 2)"

export STARSHIP_CONFIG="${HOME}/.starship"
export ZSH="${HOME}/.oh-my-zsh"

plugins=(git kubectl)

source "${HOME}/.fzf.zsh"
source "${ZSH}/oh-my-zsh.sh"

source "${HOME}/.zsh_aliases"
source "${HOME}/.zsh_functions"

macchina

eval "$(starship init zsh)"
