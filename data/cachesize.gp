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
set key at 4,0.7
#set style data histogram
#set style fill pattern
#set boxwidth 0.8 absolute
set ylabel 'Performance'
set xlabel 'cache size(\%)'
set yrange [0.5:]
set ytics  0.1

plot "data/cloudphysics.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '\sys', \
     "data/cloudphysics.dat" using 0:13 with linespoints ls 2 title "S3FIFO", \
     "data/cloudphysics.dat" using 0:11 with linespoints ls 3 title "LIRS", \
     #0.99 with lines dashtype 2 lc rgb "black" lw 1 title ""
