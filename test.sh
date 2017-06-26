#!/bin/bash

clock() {
    date +"%m月%d日  %H:%M"
#:%S
}


groups() {
    cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
    tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`
	
workspaces=( "一" "二" "三" "四" "五" "六" "七" "八" "九" "十")

# %{A:gedit:}一%{A}"


    for w in `seq 0 $((cur - 1))`; do line="${line}${workspaces[$w]} "; done
    #val=3*$cur-1
    #line="${line:0:val}"
    line="${line}%{B#99736e F#ffffff} ${workspaces[$cur]} %{B- F-} "
    for w in `seq $((cur + 1)) $tot`; do line="${line}${workspaces[$w]} "; done
    echo $line
}

nowplaying() {
    cur=`mpc current`
    # this line allow to choose whether the output will scroll or not
    test "$1" = "scroll" && PARSER='skroll -n20 -d0.5 -r' || PARSER='cat'
    test -n "$cur" && $PARSER <<< $cur || echo "- stopped -"
}


while :; do


buf=""
    buf="%{T1}${buf} $(groups)       "
    buf2="%{r} $(nowplaying) %{}"
    buf3="%{T3} %{} %{} %{} %{} %{} %{} %{} %{A:mpc prev:}⏮ %{} %{A} %{A:mpc toggle:}⏯ %{} %{A} %{A:mpc next:}⏭%{A}"



    BAR_INPUT="%{T2}%{c} $(clock)"
    echo $buf$BAR_INPUT$buf3$buf2
    sleep .01
done
