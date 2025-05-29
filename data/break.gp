call "data/common.gnuplot" "3.3in, 2.7in"
set output "`echo $OUT`"

mp_startx=0.05
mp_starty=0.10
mp_height=0.80
mp_rowgap=0.10
mp_colgap=0.10
mp_width=0.9

eval mpSetup(2, 2)

eval mpNext
unset ylabel
unset xlabel
set ytics 0.2
set xtics 0.2
set yrange [0.4:1]
set ylabel 'Relative hit ratio' offset 1,0
#set xlabel 'CDF for 0.3\% WSS'
set title '(a)AlibabaBlock' offset 0,-1
set key at 0.8,0.8

plot "data/break/RHRalibabaBlock0.003.dat" using ($1/609):2 with points ls 1 pt 9 ps 0.4 title '\sys', \
    "data/break/RHRalibabaBlock0.003.dat" using ($1/609):4 with points ls 2 pt 2 ps 0.2 title '\sys-P', \
    "data/break/RHRalibabaBlock0.003.dat" using ($1/609):3 with points ls 8 pt 5 ps 0.4 title '\sys-C', \
    "data/break/RHRalibabaBlock0.003.dat" using ($1/609):2 with points ls 1 pt 9 ps 0.3 title '', \

eval mpNext
unset ylabel
unset xlabel
set ytics 0.2
set xtics 0.2
#set ylabel 'AlibabaBlock'
#set xlabel 'CDF for 3\% WSS'
set title '(b)AlibabaBlock' offset 0,-1
set yrange [0.2:1]

plot "data/break/RHRalibabaBlock0.03.dat" using ($1/609):3 with points ls 8 pt 5 ps 0.4 title '', \
    "data/break/RHRalibabaBlock0.03.dat" using ($1/609):4 with points ls 2 pt 2 ps 0.2 title '', \
    "data/break/RHRalibabaBlock0.03.dat" using ($1/609):2 with points ls 1 pt 9 ps 0.3 title '', \


eval mpNext
unset ylabel
unset xlabel
set ytics 0.2
set xtics 0.2
set ylabel 'Relative hit ratio'
set xlabel 'CDF for 0.3\% WSS'
set title '(c)Cloudphysics' offset 0,-1
set key at 0.8,0.8
set yrange[0.4:1]

plot "data/break/RHRcloudphysics0.003.dat" using ($1/106):4 with points ls 2 pt 2 ps 0.5 title '', \
    "data/break/RHRcloudphysics0.003.dat" using ($1/106):3 with points ls 8 pt 5 ps 0.5 title '', \
    "data/break/RHRcloudphysics0.003.dat" using ($1/106):2 with points ls 1 pt 9 ps 0.5 title '', \

eval mpNext
unset ylabel
unset xlabel
set ytics 0.1
set xtics 0.2
#set ylabel 'cloudphysics'
set xlabel 'CDF for 3\% WSS'
set title '(d)Cloudphysics' offset 0,-1
set key at 0.8,0.8
set yrange[0.6:1]


plot "data/break/RHRcloudphysics0.03.dat" using ($1/106):3 with points ls 8 pt 5 ps 0.5 title '', \
    "data/break/RHRcloudphysics0.03.dat" using ($1/106):4 with points ls 2 pt 2 ps 0.5 title '', \
    "data/break/RHRcloudphysics0.03.dat" using ($1/106):2 with points ls 1 pt 9 ps 0.5 title '', \

