#!/bin/bash
killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

for m in $(polybar -m|sed -e 's/:.*$//g'); do
  MONITOR=$m polybar --reload -c "$HOME/.config/polybar/config_top.ini" bartop & 
  MONITOR=$m polybar --reload -c "$HOME/.config/polybar/config_bot.ini" barbot & 
done
