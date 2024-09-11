#!/usr/bin/env bash

## Run
cliphist list | wofi --show dmenu | cliphist decode | wl-copy
