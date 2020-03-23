tap 'homebrew/services'

brews = %w[
  bash
  bash-completion
  bash-completion@2
  coreutils
  curl
  findutils
  gawk
  git
  gnu-sed
  grep
  htop
  jq
  lftp
  netcat
  nmap
  pidof
  reattach-to-user-namespace
  rename
  tcpdump
  watch
  wget
]

casks = %w[
  android-platform-tools
  hammerspoon
  karabiner-elements
  scapple
  wireshark
]

appstore = {
}

brews.each {|p| brew p}
casks.each {|c| cask c}
appstore.each {|app,id| mas app, id: id}

# vim: ft=ruby
