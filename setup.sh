#!/bin/bash
declare -A default_path
declare -A dotfile_path

default_path["bashrc"]="$HOME/.bashrc"
default_path["zshrc"]="$HOME/.zshrc"
default_path["nvim"]="$HOME/.config/nvim"
default_path["tmux"]="$HOME/.tmux.conf"
default_path["editorconfig"]="$HOME/.editorconfig"
# default_path["oh-my-zsh"]="$HOME/.oh-my-zsh"

dotfile_path["bashrc"]="$PWD/bashrc/.bashrc"
dotfile_path["zshrc"]="$PWD/zshrc/.zshrc"
dotfile_path["nvim"]="$PWD/nvim/nvim-lucas-lxx/"
dotfile_path["tmux"]="$PWD/tmux/.tmux.conf"
dotfile_path["editorconfig"]="$PWD/editorconfig/.editorconfig"
# default_path["oh-my-zsh"]="$PWD/oh-my-zsh/.oh-my-zsh"

if command curl -v &> /dev/null; then
  echo "$(curl --version)"
else
  echo "Installing curl now..."
  sudo apt update && sudo apt install -y curl
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


for i in *; do
  z="${default_path["$i"]}"
  # -z checks if the variable is empty
  if [ -z "$z" ]; then
    continue
  fi
  # -e checks if the file exists
  if [ -e "$z" ]; then
    while true; do
      read -n 1 -p "do you want to overwrite the dotfile, '$i'? (y/n):" ans
      echo -e
      case "$ans" in
        [yY]) # If yes
          echo "overwriting $z"
          rm -rf "$z"
          ln -s "${dotfile_path["$i"]}" "${default_path["$i"]}"
          break
          ;;
        [nN]) # If no
          echo "keeping $z"
          break
          ;;
        *) # Invalid input
          echo "Please answear y or n"
          ;;
      esac
    done
    continue
  fi
  # echo "${dotfile_path["$i"]}"
  # echo "${default_path["$i"]}"
  # echo "======================"
  echo "setting $i"
  ln -s "${dotfile_path["$i"]}" "${default_path["$i"]}"
done
