#!/usr/bin/env python3
#  The program checks if discord is running
#  Icons: https://www.flaticon.com/free-icons/play-button Play button icons created by Hilmy Abiyyu A. - Flaticon
from typing import Tuple
import pypresence
import os
import subprocess
import time

spotify = False 
cmus = True

def get_current_uptime() -> str:
    output = subprocess.run(["uptime", "-p"], stdout=subprocess.PIPE, text=True).stdout
    return output.capitalize() 

def is_discord_opened() -> bool:
    try:
        subprocess.run("pgrep Discord", shell=True, check=True)
        return True
    except subprocess.CalledProcessError: 
        return False

def neovim_state() -> str: 
    nvim = subprocess.run("pgrep nvim", capture_output=True, shell=True)
    code = subprocess.run("pgrep code", capture_output=True, shell=True)
    if nvim.stdout and code.stdout:
        return "⌨️ Coding (vim & vscode)"
    elif nvim.stdout and not code.stdout:
        return "⌨️ Coding (vim)"
    elif not nvim.stdout and code.stdout:
        return "⌨️ Coding (vscode)"
    else:
        return "⌨️ Idling(:/)"

def get_status() -> Tuple:
    
    paused = "https://i.imgur.com/2GophkL.png"
    playing = "https://i.imgur.com/2zsBGMB.png"
    idling = "https://cdn0.iconfinder.com/data/icons/flat-round-system/512/archlinux-512.png"
    get_state = ""

    if spotify:
        get_state = subprocess.run("playerctl -p spotify status", shell=True, capture_output=True).stdout.decode().lower()
    elif cmus:
        get_state = subprocess.run("cmus-remote -Q | grep status", shell=True, capture_output=True).stdout.decode().lower()
    
    if "paused" in get_state:
        return ("Paused", paused)

    elif "playing" in get_state:
        return ("Playing", playing)

    return ("Idling", idling)


def get_current_song_spotify() -> str:
    path = os.path.expanduser('~') + "/.config/awesome/scripts/get_spotify_song.sh"
    output = subprocess.run([path], shell=True, capture_output=True)

    if output.stderr.decode():
        return "🔇Currently not playing Spotify"

    return "🎧 Playing: " + output.stdout.decode()

def get_current_song_cmus() -> str:
    title = subprocess.run("cmus-remote -Q | grep title", shell=True, capture_output=True).stdout.decode().replace("tag title ", "")
    albumartist = subprocess.run('cmus-remote -Q | grep "tag artist "', shell=True, capture_output=True).stdout.decode().replace("tag artist ", "") 

    return title + " - " + albumartist

def main():

    presence = pypresence.Presence(client_id="1115295203423690833")
    presence.connect()
    
    print("Succesfully connected to the client")

    while True:
        try:
            status = get_status()
            current_playing = "" 
            if cmus:
                current_playing = get_current_song_cmus()
            elif spotify:
                current_playing = get_current_song_spotify()
            presence.update(
                pid=os.getpid(),
                state=current_playing, 
                details=neovim_state(), 
                large_image="https://i.pinimg.com/736x/2e/a9/46/2ea946bbc0adedf4c9efaa0159948b49.jpg", 
                large_text=get_current_uptime(), 
                small_text=status[0],
                small_image=status[1],
                buttons=[{"label": "lVoidi github", "url": "https://github.com/lvoidi"}]
            )
            time.sleep(3)

        except KeyboardInterrupt:
            print("Closing program...")
            presence.close()
            presence.clear(os.getpid())

if is_discord_opened():
    main()
else: 
    while not is_discord_opened():
        print("Discord is not opened. Trying again in 10 seconds")
        time.sleep(10)
    main()
