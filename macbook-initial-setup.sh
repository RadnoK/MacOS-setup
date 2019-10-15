#!/bin/bash

# install homebrew apps repositories manager
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# add repo with drivers to cask (needed for Steelseries Engine)
brew tap homebrew/cask-drivers

# add repo with different versions to cask (needed for java8)
brew tap homebrew/cask-versions

# list of non-AppStore apps
nonAppStoreApps=(
    # Security
    little-snitch
    
    # Work
    iterm2 # Alternative terminal
    paw
    sublime-text
    java # OPEN JDK for apps that needs java
    java8 # ORACLE java8
    virtualbox # Virtual Machine
    virtualbox-extension-pack # Extensions for virtualbox such as display resolution and USB
    jetbrains-toolbox
    charles # Web debugging proxy
    postman # HTTP requests tool
    visual-studio-code # Electron based modern code editor
    vagrant
    docker
    
    # Office
    skype # Communicator
    zoomus
    
    # Tools
    soulver
    daisydisk
    boom-3d
    ballast
    coconutbattery
    keka # Rar extractor
    AmorphousDiskMark # HDD benchmark
    drivedx # SMART status and HDD health tool
    unetbootin # Live USB systems maker
    
    # Other
    setapp
    google-chrome # Browser
    firefox # Browser
    tor-browser # Browser preconfigured with TOR network
    opera # Browser
    spotify # Music streaming service
    teamviewer
    mactracker
    steam # Gaming platform
    origin # Gaming platform
)

# install non-AppStore apps
brew cask install ${nonAppStoreApps[@]}

# Install AppStore CLI installer
brew install mas

# Install Battle.net
open /usr/local/Caskroom/battle-net/latest/Battle.net-Setup.app

# list of AppStore apps
appStoreApps=(
    497799835 # Xcode (Apple IDE)
    1333542190 # 1Password 7 (Password Manager)
    1176895641 # Spark (e-mail client)
    1116599239 # NordVPN
    441258766 # Magnet (windows managed like on Windows)
    403504866 # PCalc (calculator)
    1289197285 # MindNode (mind mapping tool)
    937984704 # Amphetamine (sceen saver disabler)
    897118787 # Shazam (music recognition)
    904280696 # Things 3 (TODO app)
    803453959 # Slack (communicator)
    462054704 # Microsoft Word (Documents editor)
    462058435 # Microsoft Excel (Spreadsheets editor)
    462062816 # Microsoft PowerPoint (Presentations editor)
    409201541 # Pages (Documents editor)
    409203825 # Numbers (Spreadsheets editor)
    409183694 # Keynote (Presentations editor)
    1120214373 # Battery Health 2 (Battery stats and health)
    425424353 # The Unarchiver (Archives extractor)
)

# Install AppStore apps
mas install ${appStoreApps[@]}

# Install terminal colors for Bash (choose between light and dark theme)
echo -e "export CLICOLOR=1\n#light theme\nexport LSCOLORS=ExFxBxDxCxegedabagacad\n#dark theme\n#export LSCOLORS=GxFxCxDxBxegedabagaced" >> ~/.bash_profile

# Change login shell to zsh. This is default shell for MacOS Catalina and above, this is only for legacy systems
chsh -s /bin/zsh

#Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install terminal colors for zsh (light theme)
echo -e 'export LSCOLORS="ExFxBxDxCxegedabagacad"' >> ~/.zshrc
echo -e 'export LS_COLORS="di=1;34:ln=1;35:so=1;31:pi=1;33:ex=1;32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"' >> ~/.zshrc
echo -e "zstyle ':completion:*:default' list-colors \${(s.:.)LS_COLORS}" >> ~/.zshrc

# Replaces default theme with jreese theme (works with light theme)
sed -i -e 's/ZSH_THEME="robbyrussell"/ZSH_THEME="jreese"/g' ~/.zshrc

# Uncomment en_US.UTF-8 locale for console, making them undependable from macOS locale settings
sed -i -e 's/#export LANG=en_US.UTF-8/export LANG=en_US.UTF-8/g' ~/.zshrc


# Copy SF Mono font (available only in Xcode and Terminal.app) to system
cp -R /Applications/Utilities/Terminal.app/Contents/Resources/Fonts/. /Library/Fonts/

# List of brew packages
brewPackages=(
    php
    mysql
    elasticsearch
    nmap
    ansible
    python # Python version 3.7, preinstalled is 2.7
    gnupg # OpenPGP for signing and encrypting
    wget # Terminal network downloader
)

# install brew packages
brew install ${brewPackages[@]}

# Xcode won't ask for password with every build
DevToolsSecurity -enable

# Set your PGP key for git. WARNING: You need to replace the <KeyIdVALUE> with the actual GPG key id.
git config --global user.signingkey <KeyIdVALUE>

# Add your GPG key to bash
echo 'export GPG_TTY=$(tty)' >> ~/.bash_profile

# Add your GPG key to zsh
echo 'export GPG_TTY=$(tty)' >> ~/.zshrc

# Make all commits signed by default
git config --global commit.gpgsign true

# Import GPG keys. WARNING: You need to replace the <Path to pub key> and <Path to prv key> with the actual paths.
gpg --import <Path to pub key>
gpg --allow-secret-key-import --import <Path to prv key>
