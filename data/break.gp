call "data/common.gnuplot" "3.3in, 2.7in"
set output "`echo $OUT`"

mp_startx=0.05
mp_starty=0.10
mp_height=0.80
mp_rowgap=0.10
mp_colgap=0.10
mp_width=1.0

eval mpSetup(2, 2)

eval mpNext
unset ylabel
unset xlabel
set style fill solid 0.5
set ytics 0.2
set xtics 0.2
set yrange [0.6:1.2]
set ylabel 'AlibabaBlock'
#set xlabel 'CDF for 0.3\% WSS'
#set title '(a)Performance CDF' offset 0,-1
set key at 0.8,0.8

plot "data/break/alibabaBlock0.003.dat" using ($1/609):3 with lines ls 8 ps 0.5 title '\sys-C', \
    "data/break/alibabaBlock0.003.dat" using ($1/609):4 with lines ls 11 ps 0.5 title '\sys-P', \

eval mpNext
unset ylabel
unset xlabel
set style fill solid 0.5
set ytics 0.2
set xtics 0.2
#set ylabel 'AlibabaBlock'
#set xlabel 'CDF for 3\% WSS'
#set title '(a)Performance CDF' offset 0,-1
set key at 0.8,0.8

plot "data/break/alibabaBlock0.03.dat" using ($1/609):3 with lines ls 8 ps 0.5 title '', \
    "data/break/alibabaBlock0.03.dat" using ($1/609):4 with lines ls 11 ps 0.5 title '', \

eval mpNext
unset ylabel
unset xlabel
set style fill solid 0.5
set ytics 0.2
set xtics 0.2
set ylabel 'Cloudphysics'
set xlabel 'CDF for 0.3\% WSS'
#set title '(a)Performance CDF' offset 0,-1
set key at 0.8,0.8

plot "data/break/cloudphysics0.003.dat" using ($1/106):3 with lines ls 8 ps 0.5 title '', \
    "data/break/cloudphysics0.003.dat" using ($1/106):4 with lines ls 11 ps 0.5 title '', \

eval mpNext
unset ylabel
unset xlabel
set style fill solid 0.5
set ytics 0.2
set xtics 0.2
#set ylabel 'cloudphysics'
set xlabel 'CDF for 3\% WSS'
#set title '(a)Performance CDF' offset 0,-1
set key at 0.8,0.8

plot "data/break/cloudphysics0.03.dat" using ($1/106):3 with lines ls 8 ps 0.5 title '', \
    "data/break/cloudphysics0.03.dat" using ($1/106):4 with lines ls 11 ps 0.5 title '', \

