brew install gsed
brew install alacritty
brew install lsd
brew tap homebrew/cask-fonts && brew install --cask font-mononoki-nerd-font

echo -e "alias Con='~/Desktop/code/M1_Scripts_Config/configSync.sh'" >> ~/.zshrc
# echo -e "alias nv='nvim'" >> ~/.zshrc
# echo -e "export EDITOR='nvim'" >> ~/.zshrc

# write working dir to dir.txt 
echo -e $PWD >> dir.txt 

