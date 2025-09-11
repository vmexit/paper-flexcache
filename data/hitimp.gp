call "data/common.gnuplot" "7.5in, 1.5in"
set output "`echo $OUT`"

mp_startx=0.01
mp_starty=0.20
mp_height=0.70
mp_rowgap=0.10
mp_colgap=0.01
mp_width=0.9

eval mpSetup(3, 1)
#set xtics ("0.3" 1, '1' 2 ,'3' 3, '10' 4, '20' 5, '40' 6)
#set xtics rotate ('1' 0, '2' 1 ,'4' 2, '8' 3, '16' 4, '28' 5, '56' 6, '84' 7, '112' 8, '140' 9, '168' 10, '196' 11, '224' 12)
#set xtics rotate by -45 ('\sys' 1, 'ARC' 2, 'Cacheus' 3, 'Clock' 4, 'FIFO' 5, 'FIFO-Merge' 6, 'GDSF' 7, 'Hyperbolic' 8, 'LHD' 9, 'LIRS' 10, 'LeCaR' 11, 'QDLP' 12, 'S3FIFO' 13, 'S4LRU' 14, 'WTinyLFU' 15, 'TwoQ' 16)

#Index(['systor', 'metaCDN', 'twitter', 'fiu', 'alibabaBlock', 'msr',       'tencentPhoto', 'tencentBlock', 'cloudphysics', 'metaKV', 'wikimedia'],      dtype='object')
set ytics ('systor' 1, 'metaCDN' 2, 'twitter' 3,'fiu' 4, 'alibabaBlock' 5, 'msr' 6, 'tencentPhoto' 7, 'tencentBlock' 8, 'cloudphysics' 9, 'metaKV' 10, 'wikimedia' 11)
eval mpNext
unset ylabel
#set boxwidth 0.8 absolute
#set xlabel 'cache size(\%)'
set key outside top horizontal width 12 font "Times,8" offset 0,-1
set xrange[0:]
set title '(a) 1\% WSS' offset 0,1

do for [i=1:5] {
    ypos = 0.2*i - 0.1  # x=1, 3, 5
    set object i rect from 0, graph ypos-0.05 to 1, graph ypos+0.05 \
        fc rgb "gray90" fs solid 1.0 behind
}


plot "data/hitimp/0.01.dat" using 2:0 with points ls 1 pt 9 ps 2 title '\sys', \
    "data/hitimp/0.01.dat" using 3:0 with points ls 2 title '', \
    "data/hitimp/0.01.dat" using 4:0 with points ls 3 title '', \
    "data/hitimp/0.01.dat" using 8:0 with points ls 7 title '', \
    "data/hitimp/0.01.dat" using 9:0 with points ls 8 title '', \
    "data/hitimp/0.01.dat" using 10:0 with points ls 9 title '', \
    "data/hitimp/0.01.dat" using 11:0 with points ls 10 title '', \
    "data/hitimp/0.01.dat" using 12:0 with points ls 11 title '', \
    "data/hitimp/0.01.dat" using 13:0 with points ls 12 title '', \
    "data/hitimp/0.01.dat" using 14:0 with points ls 13 title '', \
    "data/hitimp/0.01.dat" using 15:0 with points ls 14 title '', \
    "data/hitimp/0.01.dat" using 16:0 with points ls 15 title '', \
    "data/hitimp/0.01.dat" using 17:0 with points ls 17 title '', \
    "data/hitimp/0.01.dat" using 2:0 with points ls 1 pt 9 ps 2 title '', \
    "data/hitimp/0.01.dat" using 18:0 with points ls 1 pt 66 lc rgb "black" ps 1 title '\sys-C', \
    "data/hitimp/0.01.dat" using 19:0 with points ls 1 pt 67 lc rgb "black" ps 1 title '\sys-P', \
     #0.99 with lines dashtype 2 lc rgb "black" lw 1 title ""


eval mpNext
unset ylabel
#set boxwidth 0.8 absolute
#set xlabel 'cache size(\%)'
unset ytics
set key outside top horizontal width 3 font "Times,8"
set xrange[0:]
set title '(b) 3\% WSS' offset 0,1
set xlabel 'Performance improvement'

do for [i=1:5] {
    ypos = 0.2*i - 0.1  # x=1, 3, 5
    set object i rect from 0, graph ypos-0.05 to 1, graph ypos+0.05 \
        fc rgb "gray90" fs solid 1.0 behind
}

#column = ["accp4", "ARC", "Cacheus", "Clock", "FIFO", "FIFO-Merge", "GDSF", "Hyperbolic", "LHD", "LIRS", "LeCaR", "QDLP", "S3FIFO", "S4LRU", "WTinyLFU", "TwoQ"]

plot "data/hitimp/0.03.dat" using 2:0 with points ls 1 pt 9 ps 2 title '', \
    "data/hitimp/0.03.dat" using 3:0 with points ls 2 title 'ARC', \
    "data/hitimp/0.03.dat" using 4:0 with points ls 3 title 'Cacheus', \
    "data/hitimp/0.03.dat" using 8:0 with points ls 7 title 'GDSF', \
    "data/hitimp/0.03.dat" using 9:0 with points ls 8 title 'Hyperbolic', \
    "data/hitimp/0.03.dat" using 10:0 with points ls 9 title 'LHD', \
    "data/hitimp/0.03.dat" using 11:0 with points ls 10 title 'LIRS', \
    "data/hitimp/0.03.dat" using 12:0 with points ls 11 title '', \
    "data/hitimp/0.03.dat" using 13:0 with points ls 12 title '', \
    "data/hitimp/0.03.dat" using 14:0 with points ls 13 title '', \
    "data/hitimp/0.03.dat" using 15:0 with points ls 14 title '', \
    "data/hitimp/0.03.dat" using 16:0 with points ls 15 title '', \
    "data/hitimp/0.03.dat" using 17:0 with points ls 17 title '', \
    "data/hitimp/0.03.dat" using 2:0 with points ls 1 pt 9 ps 2 title '', \
    "data/hitimp/0.03.dat" using 18:0 with points ls 1 pt 66 lc rgb "black" ps 1 title '', \
    "data/hitimp/0.03.dat" using 19:0 with points ls 1 pt 67 lc rgb "black" ps 1 title '', \
     #0.99 with lines dashtype 2 lc rgb "black" lw 1 title ""

eval mpNext
unset ylabel
#set boxwidth 0.8 absolute
#set xlabel 'cache size(\%)'
unset ytics
set key outside top horizontal width 3 font "Times,8"
set xrange[0:]
set title '(c) 20\% WSS' offset 0,1
unset xlabel

do for [i=1:5] {
    ypos = 0.2*i - 0.1  # x=1, 3, 5
    set object i rect from 0, graph ypos-0.05 to 1, graph ypos+0.05 \
        fc rgb "gray90" fs solid 1.0 behind
}


plot "data/hitimp/0.2.dat" using 2:0 with points ls 1 pt 9 ps 2 title '', \
    "data/hitimp/0.2.dat" using 3:0 with points ls 2 title '', \
    "data/hitimp/0.2.dat" using 4:0 with points ls 3 title '', \
    "data/hitimp/0.2.dat" using 8:0 with points ls 7 title '', \
    "data/hitimp/0.2.dat" using 9:0 with points ls 8 title '', \
    "data/hitimp/0.2.dat" using 10:0 with points ls 9 title '', \
    "data/hitimp/0.2.dat" using 11:0 with points ls 10 title '', \
    "data/hitimp/0.2.dat" using 12:0 with points ls 11 title 'LeCaR', \
    "data/hitimp/0.2.dat" using 13:0 with points ls 12 title 'QDLP', \
    "data/hitimp/0.2.dat" using 14:0 with points ls 13 title 'S3FIFO', \
    "data/hitimp/0.2.dat" using 15:0 with points ls 14 title 'S4LRU', \
    "data/hitimp/0.2.dat" using 16:0 with points ls 15 title 'WTinyLFU', \
    "data/hitimp/0.2.dat" using 17:0 with points ls 17 title 'TwoQ', \
    "data/hitimp/0.2.dat" using 2:0 with points ls 1 pt 9 ps 2 title '', \
    "data/hitimp/0.2.dat" using 18:0 with points ls 1 pt 66 lc rgb "black" ps 1 title '', \
    "data/hitimp/0.2.dat" using 19:0 with points ls 1 pt 67 lc rgb "black" ps 1 title '', \
     #0.99 with lines dashtype 2 lc rgb "black" lw 1 title ""
     