$env.config = {
  show_banner: false,

}

  alias in = sudo pacman -S
  alias un = sudo pacman -Rns
  alias up = sudo pacman -Syu
  alias la = ls -la
  alias ls = ls -f
  alias ll = ls -l
  alias vim = nvim

def hst [] {
    history | awk '{print $2, $4}' | fzf | wl-copy
}
 
def pmq [] {
    pacman -Q | fzf | wl-copy
}
