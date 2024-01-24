#!/usr/bin/env python

import random
import subprocess
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    result = subprocess.run(
        ["cowsay", random.choice(["Nix rules!"] * 6 + ["Nix sucks!"])],
        capture_output=True,
    )
    result.check_returncode()
    return {"message": result.stdout.decode()}

def run():
    app.run(host="0.0.0.0", port=5000)

if __name__ == "__main__":
    run()
