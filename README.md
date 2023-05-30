# Dotfiles

# Dependencies
- picom
- awesome git version
- These are the fonts you need: JetBrainsMono Nerd Font, FiraCode Nerd Font, Krinkes, Varsity and Collegerion. You can replace the last three ones with
just Roboto, but you'll need to modify the code. Specificly, menu.lua (that's the only file that uses those 3 last fonts). Just search the names of 
those fonts and change them by just "Roboto" (obviously you'll need roboto font installed previously).

# Before you install it 
- Make sure that the wallpaper fits with your monitor. In case it doesn't, change it in images/global/wallpaper.png. 

# Installation
```bash
git clone https://github.com/MrJakeSir/dots
mv ~/.config/awesome ~/.config/awesome.bak
mkdir ~/.config/awesome 
cp -r dots/* ~/.config/awesome/
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


## It's screenshot time! 
![Desktop example 1](https://i.imgur.com/NdGAs1r.png)
![Desktop example 2](https://i.imgur.com/Sw6qvGK.png)
![Desktop example 3](https://imgur.com/DoVRpC7.png)
![Desktop example 4](https://imgur.com/YhovkuF.png)

