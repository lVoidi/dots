#!/usr/bin/env python
import re, os, subprocess, sys, shutil
run = lambda cmd: subprocess.run(cmd, stdout=subprocess.PIPE).stdout.decode()

class Fetch:
    def __init__(self):
        self.de        =  os.getenv("DESKTOP_SESSION")
        self.hostname  =  os.getenv("hostname")
        self.username  =  os.getenv("USER")
        self.shell     =  os.getenv("SHELL")
        self.term      =  os.getenv("TERM")
        self.syslang   =  os.getenv("LANG")
        self.path      =  os.getenv("PATH")

        
    def kernel(self):
        return run(["uname", "-r"])
    
    def disk(self):
        total, used, _ = shutil.disk_usage("/home")
        usage_percent = (used // (2**30))/(total // (2**30))
        return usage_percent

    def cpu(self):
        cmd_result = run(["cat", "/proc/cpuinfo"])
        MODEL_NAME = re.findall("model name.+:(.+)" , cmd_result)[0]

        MAX_SPEED = re.findall(r"\d.\d+GHz", cmd_result)[0]

        CORES = re.findall("cpu cores.+:(.+)", cmd_result)[0]
        
        THREADS = re.findall("siblings.+:(.+)", cmd_result)[0]
        
        CACHE = re.findall("cache size.+:(.+)", cmd_result)[0]

        SPEED = f"{float(re.findall('cpu MHz.+:(.+)', cmd_result)[0])/1000:.2f}/{MAX_SPEED}"
        
        return dict(
            NAME=MODEL_NAME,
            CORES=CORES,
            THREADS=THREADS,
            CACHE=CACHE,
            SPEED=SPEED
        )
    
    def memory(self):
        KEYS = ["TOTAL", "USED", "FREE", "SHARED", "BUFF/CACHE", "AVAILABLE"]
        RESULT = {}
        output = run(["free", "-m"])
        result_regex = re.findall(r"Mem:(.+\d)", output)[0].split()

        for i in range(len(result_regex)):
            RESULT[KEYS[i]] = result_regex[i]

        return RESULT


if __name__ == "__main__":
    try:
        fetch = Fetch()
        for arg in range(len(sys.argv)):
            if sys.argv[arg] in ["-u", "--usage"]:
                if sys.argv[arg+1] in ["r", "ram"]:
                    mem_data = fetch.memory()
                    print(round(int(mem_data["USED"])/int(mem_data["TOTAL"]), 2))
                
                elif sys.argv[arg+1] in ["s", "storage"]:
                    storage_data = fetch.disk()
                    print(storage_data)

    except Exception as e:
        print(type(e).__name__, e)
