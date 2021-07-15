import json

import os

#from libqtile.command import lazy

layouts = ['us', 'latam']

def swap_layout():
    with open('/home/lvoidi/.config/qtile/settings.json', 'r+') as f:
        kbmap = json.load(f)

        del layouts[layouts.index(kbmap["keyboard"])]

        kbmap["keyboard"] = layouts[0]
        
        f.seek(0)
        
        json.dump(kbmap, f, indent=4)
        
        f.truncate()

    #run(f"setxkbmap {kbmap['keyboard']}", shell=True)
    os.system(f"setxkbmap {kbmap['keyboard']}")
    #lazy.spawn(f"setxkbmap {kbmap['keyboard']}")
    #return True

if __name__ == "__main__":
    swap_layout()
