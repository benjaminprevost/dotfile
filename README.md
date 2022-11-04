# Dotfile

```
apt install git stow
stow -d ~/Projets/dotfile/ -t ~/ dot
```

cat dpkg/get-selections-base | xargs sudo apt install -y


change for zsh default
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

Config sudoers

`visudo`
Ajouter à la fin
`ben ALL=(ALL) NOPASSWD:ALL`


sudo update-alternatives --config editor



pip install -r requirements.txt

