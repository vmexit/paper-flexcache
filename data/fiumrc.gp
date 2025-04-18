call "data/common.gnuplot" "1.3in, 1.4in"
set output "`echo $OUT`"

mp_startx=0.05
mp_starty=0.10
mp_height=0.70
mp_rowgap=0.10
mp_colgap=0.10
mp_width=1.0

eval mpSetup(1, 1)
#set xtics ("0.3" 1, '1' 2 ,'3' 3, '10' 4, '20' 5, '40' 6)

eval mpNext
unset ylabel
set key at 2,0.8
#set style data histogram
#set style fill pattern
#set boxwidth 0.8 absolute
set ylabel 'Miss ratio' offset 1,0
set xlabel 'cache size(MB)'
set yrange [0:]
set ytics  0.2
set xtics 0.4
#set title '(a) MRC for Fiu' offset 0,-0.5

plot "data/fiumrc.dat" using 1:4 with linespoints ls 2 ps 1 title "S3FIFO", \
     "data/fiumrc.dat" using 1:5 with linespoints ls 5 ps 1 title "QDLP", \
     "data/fiumrc.dat" using 1:6 with linespoints ls 6 ps 1 title "LIRS", \
     "data/fiumrc.dat" using 1:2 with linespoints ls 1 pt 9 ps 1 title '\sys', \
     "data/fiumrc.dat" using 1:3 with linespoints ls 4 ps 1 title "ARC", \