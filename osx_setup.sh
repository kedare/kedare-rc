

# Install development tools
xcode-select --install

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install powerlines fonts

git clone --depth=1 https://github.com/powerline/fonts.git
cd fonts
bash install.sh
cd

# Installing development tools
brew cask install java visual-studio-code emacs
brew install git sonar-scanner vim emacs go python3 postgresql mongodb elixir erlang influxdb consul nodejs
brew install neovim/neovim/neovim

# Install operation tools
brew install mtr ipcalc sipcalc minicom

# Install common tools
brew cask install vlc istat-menus spotify
brew install wine
