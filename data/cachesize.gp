call "data/common.gnuplot" "3.3in, 1.5in"
set output "`echo $OUT`"

mp_startx=0.05
mp_starty=0.10
mp_height=0.70
mp_rowgap=0.10
mp_colgap=0.10
mp_width=1.0

eval mpSetup(2, 1)
set xtics ("0.3" 1, '1' 2 ,'3' 3, '10' 4, '20' 5, '40' 6)
#set xtics rotate ('1' 0, '2' 1 ,'4' 2, '8' 3, '16' 4, '28' 5, '56' 6, '84' 7, '112' 8, '140' 9, '168' 10, '196' 11, '224' 12)

eval mpNext
unset ylabel
set key at 4,0.8
#set style data histogram
#set style fill pattern
#set boxwidth 0.8 absolute
set ylabel 'Relative hit ratio'
set xlabel 'cache size(\%)'
set yrange [0.5:]
set ytics  0.1
set title '(a) Average performance' offset 0,-1

plot "data/cloudphysics.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '\sys', \
     "data/cloudphysics.dat" using 0:14 with linespoints ls 2 title "S3FIFO", \
     "data/cloudphysics.dat" using 0:11 with linespoints ls 3 title "LIRS", \
     "data/cloudphysics.dat" using 0:3 with linespoints ls 4 title "ARC", \
     "data/cloudphysics.dat" using 0:17 with linespoints ls 5 title "WTinyLFU", \
     #0.99 with lines dashtype 2 lc rgb "black" lw 1 title ""

eval mpNext
unset ylabel
unset xlabel
set style fill solid 0.5
set xrange [0:1]
set yrange [0:1]
set ytics 0.2
set xtics 0.2
#set xtics rotate by -30 ('\sys' 0, "S3FIFO" 1, "LIRS" 2, "ARC" 3)
set xlabel 'CDF for 3\% WSS'
set title '(b)Performance CDF' offset 0,-1
#set key at 0.8,0.5

plot "data/violincdf.dat" using ($1/106):2 with linespoints ls 1 lw 4 pt 9 ps 1 title '\sys', \
    "data/violincdf.dat" using ($1/106):3 with linespoints ls 2 lw 4 ps 1 title 'S3FIFO', \
    "data/violincdf.dat" using ($1/106):4 with linespoints ls 3 lw 4 ps 1 title 'LIRS', \
    "data/violincdf.dat" using ($1/106):5 with linespoints ls 4 lw 4 ps 1 title 'ARC', \
    "data/violincdf.dat" using ($1/106):6 with linespoints ls 5 lw 4 ps 1 title 'WTinyLFU', \
#    "data/violin.dat" using (1):3 with boxplot ls 2 title '', \
#    "data/violin.dat" using (2):3 with boxplot ls 3 title '', \
#    "data/violin.dat" using (3):4 with boxplot ls 4 title '', \

#    "data/violin.dat" using (1):2 with boxplot lc "black"



