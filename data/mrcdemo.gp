call "data/common.gnuplot" "3.3in, 1.5in"
set output "`echo $OUT`"

mp_startx=0.05
mp_starty=0.10
mp_height=0.70
mp_rowgap=0.10
mp_colgap=0.10
mp_width=1.0

eval mpSetup(2, 1)
#set xtics ("0.3" 1, '1' 2 ,'3' 3, '10' 4, '20' 5, '40' 6)

eval mpNext
unset ylabel
set key at 120,0.4
#set style data histogram
#set style fill pattern
#set boxwidth 0.8 absolute
set ylabel 'Miss ratio'
set xlabel 'cache size(GB)'
set yrange [0:]
set ytics  0.2
set xtics 40
set title '(a) MRC for LUN1' offset 0,-0.5

plot "data/systor-lun1-mrc.dat" using 1:14 with linespoints ls 2 ps 1 title "S3FIFO", \
     "data/systor-lun1-mrc.dat" using 1:3 with linespoints ls 4 ps 1 title "ARC", \
     "data/systor-lun1-mrc.dat" using 1:11 with linespoints ls 5 ps 1 title "WTinyLFU", \
     "data/systor-lun1-mrc.dat" using 1:7 with linespoints ls 6 ps 1 title "", \
     "data/systor-lun1-mrc.dat" using 1:10 with linespoints ls 3 ps 1 title "", \
     "data/systor-lun1-mrc.dat" using 1:2 with linespoints ls 1 pt 9 ps 2 title '', \
     
     #0.99 with lines dashtype 2 lc rgb "black" lw 1 title ""
     #     "data/systor-lun1-mrc.dat" using 0:5 with linespoints ls 3 title "QDLP", \


eval mpNext
unset ylabel
set key at 140,0.4
#set style data histogram
#set style fill pattern
#set boxwidth 0.8 absolute
set xlabel 'cache size(GB)'
set ylabel 'Relative hit ratio' offset 1,0
set yrange [0:]
set ytics  0.2
set xtics 40
set title '(B) Relative performance' offset 0,-0.5
plot \
    "data/systor-lun1-retmrc.dat" using 1:2 with linespoints ls 1 pt 9 ps 2 title '\sys', \
    "data/systor-lun1-retmrc.dat" using 1:14 with linespoints ls 2 ps 1 title "", \
     "data/systor-lun1-retmrc.dat" using 1:3 with linespoints ls 4 ps 1 title "", \
     "data/systor-lun1-retmrc.dat" using 1:11 with linespoints ls 5 ps 1 title "", \
     "data/systor-lun1-retmrc.dat" using 1:7 with linespoints ls 6 ps 1 title "LeCaR", \
     "data/systor-lun1-retmrc.dat" using 1:10 with linespoints ls 3 ps 1 title "Cacheus", \
     "data/systor-lun1-retmrc.dat" using 1:2 with linespoints ls 1 pt 9 ps 2 title "", \

     #     "data/systor-lun1-retmrc.dat" using 0:5 with linespoints ls 3 title "QDLP", \



