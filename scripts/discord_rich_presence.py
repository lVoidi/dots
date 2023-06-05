#!/usr/bin/env python3
import pypresence
import os
import subprocess
import time

def get_current_uptime() -> str:
    output = subprocess.run(["uptime", "-p"], stdout=subprocess.PIPE, text=True).stdout
    return output.capitalize() 

def get_current_song_spotify() -> str:
    path = os.path.expanduser('~') + "/.config/awesome/scripts/get_spotify_song.sh"
    output = subprocess.run([path], stdout=subprocess.PIPE, text=True).stdout
    return "🔇 Currently not playing music" + output if "error" in output.lower() else "🔊 Playing: " + output 


presence = pypresence.Presence(client_id="1115295203423690833")
presence.connect()

while 1:
    try:
        presence.update(
            pid=os.getpid(),
            state=get_current_song_spotify(), 
            details="Awesome WM", 
            large_image="https://i.imgur.com/1apQVPT.png", 
            large_text=get_current_uptime(), 
            buttons=[{"label": "lVoidi github", "url": "https://github.com/lvoidi"}]
        )

    except KeyboardInterrupt:
        print("Closing program...")
        presence.close()
        presence.clear(os.getpid())
    time.sleep(1)
