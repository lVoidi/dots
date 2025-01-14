# Dependencies
- picom
- pamixer recommended
- awesome git version
- These are the fonts you need: FiraCode Nerd Font. Recommended `noto-fonts-cjk`.
recommended: kitty or alacritty, neovim (with nvchad or your own config), blur and rounded corners in your picom config

# Installation
```bash
git clone https://github.com/lvoidi/dots ~/.config/awesome
cd ~/.config/awesome
# rubato submodule
git submodule init
git submodule update
```

# Configuration
Change your variables con config/declarations.lua  
![Declarations](https://i.imgur.com/79dGBLL.png)  
Modify or add keybinds on config/keys.lua  
![Keybinds](https://i.imgur.com/4Sztm2h.png)  
Add rules on config/rules.lua  
![Rules](https://i.imgur.com/UzeEguH.png)  
Change your color scheme inside theme.lua  
![Colors](https://i.imgur.com/2X7VCuN.png)  
Change your bar organization inside ui/bar/init.lua  
![Bar](https://i.imgur.com/AI6aH4T.png)  

## Menu 
You can find the configuration for the menu in ui/widgets/menu.lua. To change your username and description, make use 
of the file theme.lua and modify `theme.username` and `theme.description`. If your menu doesn't fit the screen, reduce the font size 
of every single piece of text inside of it. A patch allowing screen scaling will come soon! 


## It's screenshot time! 
Check screenshots folder!
