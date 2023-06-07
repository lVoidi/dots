#!/usr/bin/env python3
import pypresence
import os
import subprocess
import time

def get_current_uptime() -> str:
    output = subprocess.run(["uptime", "-p"], stdout=subprocess.PIPE, text=True).stdout
    return output.capitalize() 

def neovim_state() -> str: 
    output = subprocess.run("pgrep nvim", capture_output=True, shell=True)
    if output.stdout:
        return "⌨️ Coding (neovim)"
    return "💤Not coding anything "

def get_current_song_spotify() -> str:
    path = os.path.expanduser('~') + "/.config/awesome/scripts/get_spotify_song.sh"
    output = subprocess.run([path], shell=True, capture_output=True)
    if output.stderr.decode():
        return "🔇Currently not playing Spotify"
    return "🎧 Playing: " + output.stdout.decode()

presence = pypresence.Presence(client_id="1115295203423690833")
presence.connect()

while 1:
    try:
        presence.update(
            pid=os.getpid(),
            state=get_current_song_spotify(), 
            details=neovim_state(), 
            large_image="https://i.imgur.com/1apQVPT.png", 
            large_text=get_current_uptime(), 
            buttons=[{"label": "lVoidi github", "url": "https://github.com/lvoidi"}]
        )

    except KeyboardInterrupt:
        print("Closing program...")
        presence.close()
        presence.clear(os.getpid())
    time.sleep(1)
