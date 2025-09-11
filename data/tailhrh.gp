call "data/common.gnuplot" "7.5in, 1.5in"
set output "`echo $OUT`"

mp_startx=0.01
mp_starty=0.10
mp_height=0.70
mp_rowgap=0.10
mp_colgap=0.02
mp_width=0.93

eval mpSetup(3, 1)
#set xtics ("0.3" 1, '1' 2 ,'3' 3, '10' 4, '20' 5, '40' 6)
#set xtics rotate ('1' 0, '2' 1 ,'4' 2, '8' 3, '16' 4, '28' 5, '56' 6, '84' 7, '112' 8, '140' 9, '168' 10, '196' 11, '224' 12)
set xtics rotate by -45 ('\sys' 1, 'ARC' 2, 'Cacheus' 3, 'Clock' 4, 'FIFO' 5, 'FIFO-Merge' 6, 'GDSF' 7, 'Hyperbolic' 8, 'LHD' 9, 'LIRS' 10, 'LeCaR' 11, 'QDLP' 12, 'S3FIFO' 13, 'S4LRU' 14, 'WTinyLFU' 15, 'TwoQ' 16)

eval mpNext
unset ylabel
#set style data histogram
#set style fill pattern
#set boxwidth 0.8 absolute
set ylabel 'Relative hit ratio' offset 1,0
#set xlabel 'cache size(\%)'
unset key
set xrange[0.5:17]
set ytics  0.1
set title '(a) AlibabaBlock' offset 0,-1

do for [i=1:8] {
    xpos = 2*i - 1  # x=1, 3, 5
    set object i rect from xpos-0.5, graph 0 to xpos+0.5, graph 1 \
        fc rgb "gray90" fs solid 1.0 behind
}
#cachesize accp4 ARC Cacheus Clock FIFO FIFO-Merge GDSF Hyperbolic LHD LIRS LeCaR QDLP S3FIFO S4LRU TwoQ WTinyLFU

plot "data/RHR/alibabaBlock0.4.dat" using ($0-0.2):6 with points pt 5 lc rgb "#bd0026" ps 1.5 title 'Mean', \
    "data/RHR/alibabaBlock0.4.dat" using ($0-0.2):6 with points pt 64 lc rgb "black" ps 1.5 title '', \
    "data/RHR/alibabaBlock0.4.dat" using ($0-0.2):4 with points pt 15 lc rgb "#fd8d3c" ps 1.5 title 'P10', \
    "data/RHR/alibabaBlock0.4.dat" using ($0-0.2):4 with points pt 69 lc rgb "black" ps 1.5 title '', \
    "data/RHR/alibabaBlock0.4.dat" using ($0-0.2):2 with points pt 11 lc rgb "#1f77b4" ps 1.5  title 'P1', \
    "data/RHR/alibabaBlock0.4.dat" using ($0-0.2):2 with points pt 67 lc rgb "black" ps 1.5 title '', \
    "data/RHR/alibabaBlock0.1.dat" using ($0-0.0):6 with points pt 5 lc rgb "#bd0026" ps 1 title '', \
    "data/RHR/alibabaBlock0.1.dat" using ($0-0.0):6 with points pt 64 lc rgb "black" ps 1 title '', \
    "data/RHR/alibabaBlock0.1.dat" using ($0-0.0):4 with points pt 15 lc rgb "#fd8d3c" ps 1 title '', \
    "data/RHR/alibabaBlock0.1.dat" using ($0-0.0):4 with points pt 69 lc rgb "black" ps 1 title '', \
    "data/RHR/alibabaBlock0.1.dat" using ($0-0.0):2 with points pt 11 lc rgb "#1f77b4" ps 1  title '', \
    "data/RHR/alibabaBlock0.1.dat" using ($0-0.0):2 with points pt 67 lc rgb "black" ps 1 title '', \
    "data/RHR/alibabaBlock0.03.dat" using ($0+0.2):6 with points pt 5 lc rgb "#bd0026" ps 0.7 title '', \
    "data/RHR/alibabaBlock0.03.dat" using ($0+0.2):6 with points pt 64 lc rgb "black" ps 0.7 title '', \
    "data/RHR/alibabaBlock0.03.dat" using ($0+0.2):4 with points pt 15 lc rgb "#fd8d3c" ps 0.7 title '', \
    "data/RHR/alibabaBlock0.03.dat" using ($0+0.2):4 with points pt 69 lc rgb "black" ps 0.7 title '', \
    "data/RHR/alibabaBlock0.03.dat" using ($0+0.2):2 with points pt 11 lc rgb "#1f77b4" ps 0.7  title '', \
    "data/RHR/alibabaBlock0.03.dat" using ($0+0.2):2 with points pt 67 lc rgb "black" ps 0.7 title '', \

    #"data/RHR/alibabaBlock0.4.dat" using ($0-0.2):3 with points pt 13 lc rgb "#fdd0a2" ps 1.5 title 'P5', \
    #"data/RHR/alibabaBlock0.4.dat" using ($0-0.2):3 with points pt 68 lc rgb "black" ps 1.5 title '', \

    #"data/RHR/alibabaBlock0.1.dat" using ($0-0.0):3 with points pt 13 lc rgb "#fdd0a2" ps 1 title '', \
    #"data/RHR/alibabaBlock0.1.dat" using ($0-0.0):3 with points pt 68 lc rgb "black" ps 1 title '', \

    #"data/RHR/alibabaBlock0.03.dat" using ($0+0.2):3 with points pt 13 lc rgb "#fdd0a2" ps 0.7 title '', \
    #"data/RHR/alibabaBlock0.03.dat" using ($0+0.2):3 with points pt 68 lc rgb "black" ps 0.7 title '', \

eval mpNext
unset ylabel
unset ylabel
unset key
#set xlabel 'cache size(\%)'
set xrange[0.5:17]
set ytics  0.1
set title '(b) Cloudphysics' offset 0,-1

#cachesize accp4 ARC Cacheus Clock FIFO FIFO-Merge GDSF Hyperbolic LHD LIRS LeCaR QDLP S3FIFO S4LRU TwoQ WTinyLFU

plot "data/RHR/cloudphysics0.4.dat" using ($0-0.2):6 with points pt 5 lc rgb "#bd0026" ps 1.5 title 'Mean', \
    "data/RHR/cloudphysics0.4.dat" using ($0-0.2):6 with points pt 64 lc rgb "black" ps 1.5 title '', \
    "data/RHR/cloudphysics0.4.dat" using ($0-0.2):4 with points pt 15 lc rgb "#fd8d3c" ps 1.5 title 'P10', \
    "data/RHR/cloudphysics0.4.dat" using ($0-0.2):4 with points pt 69 lc rgb "black" ps 1.5 title '', \
    "data/RHR/cloudphysics0.4.dat" using ($0-0.2):2 with points pt 11 lc rgb "#1f77b4" ps 1.5  title 'P1', \
    "data/RHR/cloudphysics0.4.dat" using ($0-0.2):2 with points pt 67 lc rgb "black" ps 1.5 title '', \
    "data/RHR/cloudphysics0.1.dat" using ($0-0.0):6 with points pt 5 lc rgb "#bd0026" ps 1 title '', \
    "data/RHR/cloudphysics0.1.dat" using ($0-0.0):6 with points pt 64 lc rgb "black" ps 1 title '', \
    "data/RHR/cloudphysics0.1.dat" using ($0-0.0):4 with points pt 15 lc rgb "#fd8d3c" ps 1 title '', \
    "data/RHR/cloudphysics0.1.dat" using ($0-0.0):4 with points pt 69 lc rgb "black" ps 1 title '', \
    "data/RHR/cloudphysics0.1.dat" using ($0-0.0):2 with points pt 11 lc rgb "#1f77b4" ps 1  title '', \
    "data/RHR/cloudphysics0.1.dat" using ($0-0.0):2 with points pt 67 lc rgb "black" ps 1 title '', \
    "data/RHR/cloudphysics0.03.dat" using ($0+0.2):6 with points pt 5 lc rgb "#bd0026" ps 0.7 title '', \
    "data/RHR/cloudphysics0.03.dat" using ($0+0.2):6 with points pt 64 lc rgb "black" ps 0.7 title '', \
    "data/RHR/cloudphysics0.03.dat" using ($0+0.2):4 with points pt 15 lc rgb "#fd8d3c" ps 0.7 title '', \
    "data/RHR/cloudphysics0.03.dat" using ($0+0.2):4 with points pt 69 lc rgb "black" ps 0.7 title '', \
    "data/RHR/cloudphysics0.03.dat" using ($0+0.2):2 with points pt 11 lc rgb "#1f77b4" ps 0.7  title '', \
    "data/RHR/cloudphysics0.03.dat" using ($0+0.2):2 with points pt 67 lc rgb "black" ps 0.7 title '', \

    #"data/RHR/cloudphysics0.4.dat" using ($0-0.2):3 with points pt 13 lc rgb "#fdd0a2" ps 1.5 title 'P5', \
    #"data/RHR/cloudphysics0.4.dat" using ($0-0.2):3 with points pt 68 lc rgb "black" ps 1.5 title '', \

    #"data/RHR/cloudphysics0.1.dat" using ($0-0.0):3 with points pt 13 lc rgb "#fdd0a2" ps 1 title '', \
    #"data/RHR/cloudphysics0.1.dat" using ($0-0.0):3 with points pt 68 lc rgb "black" ps 1 title '', \

    #"data/RHR/cloudphysics0.03.dat" using ($0+0.2):3 with points pt 13 lc rgb "#fdd0a2" ps 0.7 title '', \
    #"data/RHR/cloudphysics0.03.dat" using ($0+0.2):3 with points pt 68 lc rgb "black" ps 0.7 title '', \

eval mpNext
unset ylabel
unset ylabel
#set xlabel 'cache size(\%)'
set xrange[0.5:17]
set ytics  0.1
set yrange[0.4:]
set key horizontal at 17,0.5 
set title '(c) TencentBlock' offset 0,-1

#cachesize accp4 ARC Cacheus Clock FIFO FIFO-Merge GDSF Hyperbolic LHD LIRS LeCaR QDLP S3FIFO S4LRU TwoQ WTinyLFU

plot "data/RHR/tencentBlock0.4.dat" using ($0-0.2):6 with points pt 5 lc rgb "#bd0026" ps 1.5 title 'Mean', \
    "data/RHR/tencentBlock0.4.dat" using ($0-0.2):6 with points pt 64 lc rgb "black" ps 1.5 title '', \
    "data/RHR/tencentBlock0.4.dat" using ($0-0.2):4 with points pt 15 lc rgb "#fd8d3c" ps 1.5 title 'P10', \
    "data/RHR/tencentBlock0.4.dat" using ($0-0.2):4 with points pt 69 lc rgb "black" ps 1.5 title '', \
    "data/RHR/tencentBlock0.4.dat" using ($0-0.2):2 with points pt 11 lc rgb "#1f77b4" ps 1.5  title 'P1', \
    "data/RHR/tencentBlock0.4.dat" using ($0-0.2):2 with points pt 67 lc rgb "black" ps 1.5 title '', \
    "data/RHR/tencentBlock0.1.dat" using ($0-0.0):6 with points pt 5 lc rgb "#bd0026" ps 1 title '', \
    "data/RHR/tencentBlock0.1.dat" using ($0-0.0):6 with points pt 64 lc rgb "black" ps 1 title '', \
    "data/RHR/tencentBlock0.1.dat" using ($0-0.0):4 with points pt 15 lc rgb "#fd8d3c" ps 1 title '', \
    "data/RHR/tencentBlock0.1.dat" using ($0-0.0):4 with points pt 69 lc rgb "black" ps 1 title '', \
    "data/RHR/tencentBlock0.1.dat" using ($0-0.0):2 with points pt 11 lc rgb "#1f77b4" ps 1  title '', \
    "data/RHR/tencentBlock0.1.dat" using ($0-0.0):2 with points pt 67 lc rgb "black" ps 1 title '', \
    "data/RHR/tencentBlock0.03.dat" using ($0+0.2):6 with points pt 5 lc rgb "#bd0026" ps 0.7 title '', \
    "data/RHR/tencentBlock0.03.dat" using ($0+0.2):6 with points pt 64 lc rgb "black" ps 0.7 title '', \
    "data/RHR/tencentBlock0.03.dat" using ($0+0.2):4 with points pt 15 lc rgb "#fd8d3c" ps 0.7 title '', \
    "data/RHR/tencentBlock0.03.dat" using ($0+0.2):4 with points pt 69 lc rgb "black" ps 0.7 title '', \
    "data/RHR/tencentBlock0.03.dat" using ($0+0.2):2 with points pt 11 lc rgb "#1f77b4" ps 0.7  title '', \
    "data/RHR/tencentBlock0.03.dat" using ($0+0.2):2 with points pt 67 lc rgb "black" ps 0.7 title '', \

    #"data/RHR/tencentBlock0.4.dat" using ($0-0.2):3 with points pt 13 lc rgb "#fdd0a2" ps 1.5 title 'P5', \
    #"data/RHR/tencentBlock0.4.dat" using ($0-0.2):3 with points pt 68 lc rgb "black" ps 1.5 title '', \

    #"data/RHR/tencentBlock0.1.dat" using ($0-0.0):3 with points pt 13 lc rgb "#fdd0a2" ps 1 title '', \
    #"data/RHR/tencentBlock0.1.dat" using ($0-0.0):3 with points pt 68 lc rgb "black" ps 1 title '', \

    #"data/RHR/tencentBlock0.03.dat" using ($0+0.2):3 with points pt 13 lc rgb "#fdd0a2" ps 0.7 title '', \
    #"data/RHR/tencentBlock0.03.dat" using ($0+0.2):3 with points pt 68 lc rgb "black" ps 0.7 title '', \
