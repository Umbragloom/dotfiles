#!/bin/bash
# i3 lock script: pixelates screen and adds lock pic
# requires imagemagick and scrot

tmpbg="/tmp/lockscreen.png"
#text="/tmp/locktext.png"
dir="/home/maggie/DocumentsO/lockscreen/"
images=($(find ${dir} -name 'lock_*.png'))
rnd=($(seq 0 $(expr ${#images[@]} - 1) | shuf))
if [ $1 ]; then
    pic=$dir'lock_'$1'.png'
else
    pic=${images[${rnd[i]}]}
fi

scrot "$tmpbg"
convert "$tmpbg" -scale 10% -scale 1000% -fill black -colorize 25% "$tmpbg"

if [ -f "$pic" ]; then
    convert "$tmpbg" "$pic" -gravity center -geometry +0+0 -composite -matte "$tmpbg"
fi

#not in use right now
#[ -f $text ] || {
#    convert -size 2560x60 xc:#2e3436 $text;
#    convert $text -alpha set -channel A -evaluate set 50% $text;
#    convert $text -font '/usr/share/fonts/TTF/DroidSans.ttf' -pointsize 26 -fill xc:#8b639b -gravity west -annotate +0+0 'Type password to unlock' $text;
#}
#convert $tmpbg $text -gravity center -geometry +0+200 -composite $tmpbg

i3lock -u -n -e -i "$tmpbg" >> /dev/null
