call "data/common.gnuplot" "3.3in, 3.9in"
set output "`echo $OUT`"

mp_startx=0.10
mp_starty=0.10
mp_height=0.80
mp_rowgap=0.10
mp_colgap=0.10
mp_width=0.8

eval mpSetup(2, 3)
set xtics ("1" 1, '3' 2 ,'5' 3, '10' 4, '30' 5, '50' 6)

eval mpNext
set yrange [0:]
set ytics  0.2
set ylabel 'Relative hit ratio'
set title '(a) Alibaba, small cache size' offset 0,-0.5
set key at 6,0.4
plot "data/RHR/withoutobjsize/alibabaBlockB0.03.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '\sys', \
     "data/RHR/withoutobjsize/alibabaBlockB0.03.dat" using 0:3 with linespoints ls 2 title "S3-FIFO", \
     "data/RHR/withoutobjsize/alibabaBlockB0.03.dat" using 0:4 with linespoints ls 3 title "", \
     "data/RHR/withoutobjsize/alibabaBlockB0.03.dat" using 0:5 with linespoints ls 4 title "", \
     "data/RHR/withoutobjsize/alibabaBlockB0.03.dat" using 0:6 with linespoints ls 5 title "", \
     "data/RHR/withoutobjsize/alibabaBlockB0.03.dat" using 0:7 with linespoints ls 8 title "", \
     "data/RHR/withoutobjsize/alibabaBlockB0.03.dat" using 0:8 with linespoints ls 7 title "", \
     "data/RHR/withoutobjsize/alibabaBlockB0.03.dat" using 0:9 with linespoints ls 6 title "", \
     "data/RHR/withoutobjsize/alibabaBlockB0.03.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \

eval mpNext
unset ylabel
set title '(b) Alibaba, large cache size' offset 0,-0.5
set key at 6,0.6
plot "data/RHR/withoutobjsize/alibabaBlockB0.1.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \
     "data/RHR/withoutobjsize/alibabaBlockB0.1.dat" using 0:3 with linespoints ls 2 title "", \
     "data/RHR/withoutobjsize/alibabaBlockB0.1.dat" using 0:4 with linespoints ls 3 title "ARC", \
     "data/RHR/withoutobjsize/alibabaBlockB0.1.dat" using 0:5 with linespoints ls 4 title "Cacheus", \
     "data/RHR/withoutobjsize/alibabaBlockB0.1.dat" using 0:6 with linespoints ls 5 title "LeCaR", \
     "data/RHR/withoutobjsize/alibabaBlockB0.1.dat" using 0:7 with linespoints ls 6 title "LIRS", \
     "data/RHR/withoutobjsize/alibabaBlockB0.1.dat" using 0:8 with linespoints ls 7 title "", \
     "data/RHR/withoutobjsize/alibabaBlockB0.1.dat" using 0:9 with linespoints ls 6 title "", \
     "data/RHR/withoutobjsize/alibabaBlockB0.1.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \

eval mpNext
set ylabel 'Relative hit ratio'
set title '(c) CloudPhysics, small cache size' offset 0,-0.5
plot "data/RHR/withoutobjsize/cloudphysicsB0.03.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \
     "data/RHR/withoutobjsize/cloudphysicsB0.03.dat" using 0:3 with linespoints ls 2 title "", \
     "data/RHR/withoutobjsize/cloudphysicsB0.03.dat" using 0:4 with linespoints ls 3 title "", \
     "data/RHR/withoutobjsize/cloudphysicsB0.03.dat" using 0:5 with linespoints ls 4 title "", \
     "data/RHR/withoutobjsize/cloudphysicsB0.03.dat" using 0:6 with linespoints ls 5 title "", \
     "data/RHR/withoutobjsize/cloudphysicsB0.03.dat" using 0:7 with linespoints ls 8 title "", \
     "data/RHR/withoutobjsize/cloudphysicsB0.03.dat" using 0:8 with linespoints ls 7 title "", \
     "data/RHR/withoutobjsize/cloudphysicsB0.03.dat" using 0:9 with linespoints ls 6 title "", \
     "data/RHR/withoutobjsize/cloudphysicsB0.03.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \

eval mpNext
unset ylabel
set title '(d) CloudPhysics, large cache size' offset 0,-0.5
set key at 6,0.4
plot "data/RHR/withoutobjsize/cloudphysicsB0.1.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \
     "data/RHR/withoutobjsize/cloudphysicsB0.1.dat" using 0:3 with linespoints ls 2 title "", \
     "data/RHR/withoutobjsize/cloudphysicsB0.1.dat" using 0:4 with linespoints ls 3 title "", \
     "data/RHR/withoutobjsize/cloudphysicsB0.1.dat" using 0:5 with linespoints ls 4 title "", \
     "data/RHR/withoutobjsize/cloudphysicsB0.1.dat" using 0:6 with linespoints ls 5 title "", \
     "data/RHR/withoutobjsize/cloudphysicsB0.1.dat" using 0:7 with linespoints ls 6 title "", \
     "data/RHR/withoutobjsize/cloudphysicsB0.1.dat" using 0:8 with linespoints ls 7 title "WTinyLFU", \
     "data/RHR/withoutobjsize/cloudphysicsB0.1.dat" using 0:9 with linespoints ls 6 title "GDSF", \
     "data/RHR/withoutobjsize/cloudphysicsB0.1.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \

eval mpNext
set ylabel 'Relative hit ratio'
set yrange [0.4:]
set ytics  0.1
set title '(e) Tencent, small cache size' offset 0,-0.5
set xlabel 'Cumulative distribution'
plot "data/RHR/withoutobjsize/tencentBlockB0.03.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \
     "data/RHR/withoutobjsize/tencentBlockB0.03.dat" using 0:3 with linespoints ls 2 title "", \
     "data/RHR/withoutobjsize/tencentBlockB0.03.dat" using 0:4 with linespoints ls 3 title "", \
     "data/RHR/withoutobjsize/tencentBlockB0.03.dat" using 0:5 with linespoints ls 4 title "", \
     "data/RHR/withoutobjsize/tencentBlockB0.03.dat" using 0:6 with linespoints ls 5 title "", \
     "data/RHR/withoutobjsize/tencentBlockB0.03.dat" using 0:7 with linespoints ls 8 title "", \
     "data/RHR/withoutobjsize/tencentBlockB0.03.dat" using 0:8 with linespoints ls 7 title "", \
     "data/RHR/withoutobjsize/tencentBlockB0.03.dat" using 0:9 with linespoints ls 6 title "", \
     "data/RHR/withoutobjsize/tencentBlockB0.03.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \

eval mpNext
unset ylabel
set title '(f) Tencent, large cache size' offset 0,-0.5
plot "data/RHR/withoutobjsize/tencentBlockB0.1.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \
     "data/RHR/withoutobjsize/tencentBlockB0.1.dat" using 0:3 with linespoints ls 2 title "", \
     "data/RHR/withoutobjsize/tencentBlockB0.1.dat" using 0:4 with linespoints ls 3 title "", \
     "data/RHR/withoutobjsize/tencentBlockB0.1.dat" using 0:5 with linespoints ls 4 title "", \
     "data/RHR/withoutobjsize/tencentBlockB0.1.dat" using 0:6 with linespoints ls 5 title "", \
     "data/RHR/withoutobjsize/tencentBlockB0.1.dat" using 0:7 with linespoints ls 6 title "", \
     "data/RHR/withoutobjsize/tencentBlockB0.1.dat" using 0:8 with linespoints ls 7 title "", \
     "data/RHR/withoutobjsize/tencentBlockB0.1.dat" using 0:9 with linespoints ls 6 title "", \
     "data/RHR/withoutobjsize/tencentBlockB0.1.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \

