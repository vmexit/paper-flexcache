call "data/common.gnuplot" "7.5in, 2.9in"
set output "`echo $OUT`"

mp_startx=0.01
mp_starty=0.05
mp_height=0.80
mp_rowgap=0.1
mp_colgap=0.03
mp_width=0.9

eval mpSetup(4, 2)
set xtics ("0.3" 1, '1' 2 ,'3' 3, '10' 4, '20' 5, '40' 6)

eval mpNext
unset ylabel
set key at 3.7,0.78
#set style data histogram
#set style fill pattern
#set boxwidth 0.8 absolute
set ylabel 'Relative hit ratio'
set yrange [:]
set ytics  0.1
set title '(a) FIU' offset 0,-1

#column = ["accp4", "ARC", "Cacheus", "Clock", "FIFO", "FIFO-Merge", "GDSF", "Hyperbolic", "LHD", "LIRS", "LeCaR", "QDLP", "S3FIFO", "S4LRU", "WTinyLFU", "TwoQ"]

plot "data/RHR/fiu.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '\sys', \
    "data/RHR/fiu.dat" using 0:3 with linespoints ls 2 title 'ARC', \
    "data/RHR/fiu.dat" using 0:4 with linespoints ls 3 title 'Cacheus', \
    "data/RHR/fiu.dat" using 0:5 with linespoints ls 4 title '', \
    "data/RHR/fiu.dat" using 0:6 with linespoints ls 5 title '', \
    "data/RHR/fiu.dat" using 0:7 with linespoints ls 6 title '', \
    "data/RHR/fiu.dat" using 0:8 with linespoints ls 7 title '', \
    "data/RHR/fiu.dat" using 0:9 with linespoints ls 8 title '', \
    "data/RHR/fiu.dat" using 0:10 with linespoints ls 9 title '', \
    "data/RHR/fiu.dat" using 0:11 with linespoints ls 10 title '', \
    "data/RHR/fiu.dat" using 0:12 with linespoints ls 11 title '', \
    "data/RHR/fiu.dat" using 0:13 with linespoints ls 12 title '', \
    "data/RHR/fiu.dat" using 0:14 with linespoints ls 13 title '', \
    "data/RHR/fiu.dat" using 0:15 with linespoints ls 14 title '', \
    "data/RHR/fiu.dat" using 0:16 with linespoints ls 15 title '', \
    "data/RHR/fiu.dat" using 0:17 with linespoints ls 16 title '', \
     #0.99 with lines dashtype 2 lc rgb "black" lw 1 title ""

eval mpNext
unset ylabel
set key at 6,0.94
set yrange [:]
set ytics  0.05
set title '(b) MetaCDN' offset 0,-1

plot "data/RHR/metaCDN.dat" using 0:3 with linespoints ls 2 title '', \
    "data/RHR/metaCDN.dat" using 0:4 with linespoints ls 3 title '', \
    "data/RHR/metaCDN.dat" using 0:5 with linespoints ls 4 title '', \
    "data/RHR/metaCDN.dat" using 0:6 with linespoints ls 5 title 'FIFO', \
    "data/RHR/metaCDN.dat" using 0:7 with linespoints ls 6 title 'FIFO-Merge', \
    "data/RHR/metaCDN.dat" using 0:8 with linespoints ls 7 title 'GDSF', \
    "data/RHR/metaCDN.dat" using 0:9 with linespoints ls 8 title '', \
    "data/RHR/metaCDN.dat" using 0:10 with linespoints ls 9 title '', \
    "data/RHR/metaCDN.dat" using 0:11 with linespoints ls 10 title '', \
    "data/RHR/metaCDN.dat" using 0:12 with linespoints ls 11 title '', \
    "data/RHR/metaCDN.dat" using 0:13 with linespoints ls 12 title '', \
    "data/RHR/metaCDN.dat" using 0:14 with linespoints ls 13 title '', \
    "data/RHR/metaCDN.dat" using 0:15 with linespoints ls 14 title '', \
    "data/RHR/metaCDN.dat" using 0:16 with linespoints ls 15 title '', \
    "data/RHR/metaCDN.dat" using 0:17 with linespoints ls 16 title '', \
    "data/RHR/metaCDN.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \
    
eval mpNext
unset ylabel
set key at 6,0.98
set yrange [:]
set ytics  0.05
set title '(c) MetaKV' offset 0,-1

plot "data/RHR/metaKV.dat" using 0:3 with linespoints ls 2 title '', \
    "data/RHR/metaKV.dat" using 0:4 with linespoints ls 3 title '', \
    "data/RHR/metaKV.dat" using 0:5 with linespoints ls 4 title 'Clock', \
    "data/RHR/metaKV.dat" using 0:6 with linespoints ls 5 title '', \
    "data/RHR/metaKV.dat" using 0:7 with linespoints ls 6 title '', \
    "data/RHR/metaKV.dat" using 0:8 with linespoints ls 7 title '', \
    "data/RHR/metaKV.dat" using 0:9 with linespoints ls 8 title 'Hyperbolic', \
    "data/RHR/metaKV.dat" using 0:10 with linespoints ls 9 title 'LHD', \
    "data/RHR/metaKV.dat" using 0:11 with linespoints ls 10 title 'LIRS', \
    "data/RHR/metaKV.dat" using 0:12 with linespoints ls 11 title 'LeCaR', \
    "data/RHR/metaKV.dat" using 0:13 with linespoints ls 12 title 'QDLP', \
    "data/RHR/metaKV.dat" using 0:14 with linespoints ls 13 title '', \
    "data/RHR/metaKV.dat" using 0:15 with linespoints ls 14 title '', \
    "data/RHR/metaKV.dat" using 0:16 with linespoints ls 15 title '', \
    "data/RHR/metaKV.dat" using 0:17 with linespoints ls 16 title '', \
    "data/RHR/metaKV.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \

eval mpNext
unset ylabel
set key at 4,0.8
set yrange [:]
set ytics  0.1
set title '(d) MSR' offset 0,-1

plot "data/RHR/msr.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \
    "data/RHR/msr.dat" using 0:3 with linespoints ls 2 title '', \
    "data/RHR/msr.dat" using 0:4 with linespoints ls 3 title '', \
    "data/RHR/msr.dat" using 0:5 with linespoints ls 4 title '', \
    "data/RHR/msr.dat" using 0:6 with linespoints ls 5 title '', \
    "data/RHR/msr.dat" using 0:7 with linespoints ls 6 title '', \
    "data/RHR/msr.dat" using 0:8 with linespoints ls 7 title '', \
    "data/RHR/msr.dat" using 0:9 with linespoints ls 8 title '', \
    "data/RHR/msr.dat" using 0:10 with linespoints ls 9 title '', \
    "data/RHR/msr.dat" using 0:11 with linespoints ls 10 title '', \
    "data/RHR/msr.dat" using 0:12 with linespoints ls 11 title '', \
    "data/RHR/msr.dat" using 0:13 with linespoints ls 12 title '', \
    "data/RHR/msr.dat" using 0:14 with linespoints ls 13 title '', \
    "data/RHR/msr.dat" using 0:15 with linespoints ls 14 title '', \
    "data/RHR/msr.dat" using 0:16 with linespoints ls 15 title '', \
    "data/RHR/msr.dat" using 0:17 with linespoints ls 16 title '', \
    
eval mpNext
unset ylabel
set key at 3.2,0.78
#set style data histogram
#set style fill pattern
#set boxwidth 0.8 absolute
set ylabel 'Relative hit ratio'
set xlabel 'cache size(\%)'
set yrange [:]
set ytics  0.1
set title '(e) Systor' offset 0,0.05

plot "data/RHR/systor.dat" using 0:3 with linespoints ls 2 title '', \
    "data/RHR/systor.dat" using 0:4 with linespoints ls 3 title '', \
    "data/RHR/systor.dat" using 0:5 with linespoints ls 4 title '', \
    "data/RHR/systor.dat" using 0:6 with linespoints ls 5 title '', \
    "data/RHR/systor.dat" using 0:7 with linespoints ls 6 title '', \
    "data/RHR/systor.dat" using 0:8 with linespoints ls 7 title '', \
    "data/RHR/systor.dat" using 0:9 with linespoints ls 8 title '', \
    "data/RHR/systor.dat" using 0:10 with linespoints ls 9 title '', \
    "data/RHR/systor.dat" using 0:11 with linespoints ls 10 title '', \
    "data/RHR/systor.dat" using 0:12 with linespoints ls 11 title '', \
    "data/RHR/systor.dat" using 0:13 with linespoints ls 12 title '', \
    "data/RHR/systor.dat" using 0:14 with linespoints ls 13 title '', \
    "data/RHR/systor.dat" using 0:15 with linespoints ls 14 title '', \
    "data/RHR/systor.dat" using 0:16 with linespoints ls 15 title '', \
    "data/RHR/systor.dat" using 0:17 with linespoints ls 16 title '', \
    "data/RHR/systor.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \
    
     #0.99 with lines dashtype 2 lc rgb "black" lw 1 title ""

eval mpNext
unset ylabel
set key at 3.2,0.78
#set style data histogram
#set style fill pattern
#set boxwidth 0.8 absolute
set xlabel 'cache size(\%)'
set yrange [:]
set ytics  0.1
set title '(f) TencentPhoto' offset 0,0.05

plot "data/RHR/tencentPhoto.dat" using 0:3 with linespoints ls 2 title '', \
    "data/RHR/tencentPhoto.dat" using 0:4 with linespoints ls 3 title '', \
    "data/RHR/tencentPhoto.dat" using 0:5 with linespoints ls 4 title '', \
    "data/RHR/tencentPhoto.dat" using 0:6 with linespoints ls 5 title '', \
    "data/RHR/tencentPhoto.dat" using 0:7 with linespoints ls 6 title '', \
    "data/RHR/tencentPhoto.dat" using 0:8 with linespoints ls 7 title '', \
    "data/RHR/tencentPhoto.dat" using 0:9 with linespoints ls 8 title '', \
    "data/RHR/tencentPhoto.dat" using 0:10 with linespoints ls 9 title '', \
    "data/RHR/tencentPhoto.dat" using 0:11 with linespoints ls 10 title '', \
    "data/RHR/tencentPhoto.dat" using 0:12 with linespoints ls 11 title '', \
    "data/RHR/tencentPhoto.dat" using 0:13 with linespoints ls 12 title '', \
    "data/RHR/tencentPhoto.dat" using 0:14 with linespoints ls 13 title '', \
    "data/RHR/tencentPhoto.dat" using 0:15 with linespoints ls 14 title '', \
    "data/RHR/tencentPhoto.dat" using 0:16 with linespoints ls 15 title '', \
    "data/RHR/tencentPhoto.dat" using 0:17 with linespoints ls 16 title '', \
    "data/RHR/tencentPhoto.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \


eval mpNext
unset ylabel
set key at 6,0.95
#set style data histogram
#set style fill pattern
#set boxwidth 0.8 absolute
set xlabel 'cache size(\%)'
set yrange [:]
set ytics  0.05
set title '(g) Twitter' offset 0,0.05

plot "data/RHR/twitter.dat" using 0:3 with linespoints ls 2 title '', \
    "data/RHR/twitter.dat" using 0:4 with linespoints ls 3 title '', \
    "data/RHR/twitter.dat" using 0:5 with linespoints ls 4 title '', \
    "data/RHR/twitter.dat" using 0:6 with linespoints ls 5 title '', \
    "data/RHR/twitter.dat" using 0:7 with linespoints ls 6 title '', \
    "data/RHR/twitter.dat" using 0:8 with linespoints ls 7 title '', \
    "data/RHR/twitter.dat" using 0:9 with linespoints ls 8 title '', \
    "data/RHR/twitter.dat" using 0:10 with linespoints ls 9 title '', \
    "data/RHR/twitter.dat" using 0:11 with linespoints ls 10 title '', \
    "data/RHR/twitter.dat" using 0:12 with linespoints ls 11 title '', \
    "data/RHR/twitter.dat" using 0:13 with linespoints ls 12 title '', \
    "data/RHR/twitter.dat" using 0:14 with linespoints ls 13 title 'S3FIFO', \
    "data/RHR/twitter.dat" using 0:15 with linespoints ls 14 title 'S4LRU', \
    "data/RHR/twitter.dat" using 0:16 with linespoints ls 15 title 'WTinyLFU', \
    "data/RHR/twitter.dat" using 0:17 with linespoints ls 16 title 'TwoQ', \
    "data/RHR/twitter.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \

eval mpNext
unset ylabel
set key at 3.2,0.78
#set style data histogram
#set style fill pattern
#set boxwidth 0.8 absolute
set xlabel 'cache size(\%)'
set yrange [:]
set ytics  0.1
set title '(f) Wikimedia' offset 0,0.05

plot "data/RHR/wikimedia.dat" using 0:3 with linespoints ls 2 title '', \
    "data/RHR/wikimedia.dat" using 0:4 with linespoints ls 3 title '', \
    "data/RHR/wikimedia.dat" using 0:5 with linespoints ls 4 title '', \
    "data/RHR/wikimedia.dat" using 0:6 with linespoints ls 5 title '', \
    "data/RHR/wikimedia.dat" using 0:7 with linespoints ls 6 title '', \
    "data/RHR/wikimedia.dat" using 0:8 with linespoints ls 7 title '', \
    "data/RHR/wikimedia.dat" using 0:9 with linespoints ls 8 title '', \
    "data/RHR/wikimedia.dat" using 0:10 with linespoints ls 9 title '', \
    "data/RHR/wikimedia.dat" using 0:11 with linespoints ls 10 title '', \
    "data/RHR/wikimedia.dat" using 0:12 with linespoints ls 11 title '', \
    "data/RHR/wikimedia.dat" using 0:13 with linespoints ls 12 title '', \
    "data/RHR/wikimedia.dat" using 0:14 with linespoints ls 13 title '', \
    "data/RHR/wikimedia.dat" using 0:15 with linespoints ls 14 title '', \
    "data/RHR/wikimedia.dat" using 0:16 with linespoints ls 15 title '', \
    "data/RHR/wikimedia.dat" using 0:17 with linespoints ls 16 title '', \
    "data/RHR/wikimedia.dat" using 0:2 with linespoints ls 1 pt 9 ps 2 title '', \
