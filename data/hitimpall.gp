call "data/common.gnuplot" "7.5in, 3in"
set output "`echo $OUT`"

mp_startx=0.10
mp_starty=0.10
mp_height=0.80
mp_rowgap=0.02
mp_colgap=0.02
mp_width=0.8

eval mpSetup(2, 3)
#set xtics ("0.3" 1, '1' 2 ,'3' 3, '10' 4, '20' 5, '40' 6)
#set xtics rotate ('1' 0, '2' 1 ,'4' 2, '8' 3, '16' 4, '28' 5, '56' 6, '84' 7, '112' 8, '140' 9, '168' 10, '196' 11, '224' 12)
#set xtics rotate by -45 ('\sys' 1, 'ARC' 2, 'Cacheus' 3, 'Clock' 4, 'FIFO' 5, 'FIFO-Merge' 6, 'GDSF' 7, 'Hyperbolic' 8, 'LHD' 9, 'LIRS' 10, 'LeCaR' 11, 'QDLP' 12, 'S3FIFO' 13, 'S4LRU' 14, 'WTinyLFU' 15, 'TwoQ' 16)

set style line 101 lc rgb '#808080' lt 1 lw 0.5  # 灰色虚线

#Index(['systor', 'metaCDN', 'twitter', 'fiu', 'alibabaBlock', 'msr',       'tencentPhoto', 'tencentBlock', 'cloudphysics', 'metaKV', 'wikimedia'],      dtype='object')
#row_rename = ["Twitter", "MetaKV", "MetaCDN", "TencentPhoto", "Wikimedia", "Tencent", "Systor", "fiu", "MSR", "Alibaba", "CloudPhysics"]
set ytics ('Twitter' 1, 'MetaKV' 2, 'MetaCDN' 3,'TencentPhoto' 4, 'Wikimedia' 5, 'Tencent' 6, 'Systor' 7, 'fiu' 8, 'MSR' 9, 'Alibaba' 10, 'CloudPhysics' 11)
set ytics font "Times,5"
set ytics nomirror
set yrange [0.5:11.5]   # 给 y 轴留一点空隙，避免顶到底部边界
set border 15 lw 1.2     # 仅显示左下边框，风格更简洁
set tics scale 0.5
### ============ 网格线风格（虚线灰） =============
set style line 101 lc rgb '#b0b0b0' lt 2 lw 0.7

### ============ 背景条纹 =============
# 删除旧的 object，避免重复叠加
unset object
unset grid
set grid xtics lc rgb "#aaaaaa" lw 0.7
 
eval mpNext
unset ylabel
#set boxwidth 0.8 absolute
#set xlabel 'cache size(\%)'
set key outside top horizontal maxrows 1 spacing 1.2 width 0 offset 0,-1
set format x ""
set xrange[0:0.4]
#set title 'Relative hit ratio improvement' offset 0,1
set ylabel '1\% WSS'

# 交替灰白条（浅灰#f5f5f5 类似论文图）
do for [i=1:11] {
    if (i%2 == 0) {
        set object i rect from graph 0, first (i-0.5) to graph 1, first (i+0.5) \
            fc rgb "#e0e0e0" fs solid 1.0 behind
    }
}

#column = ["FlexCache", "S3-FIFO", "ARC", "Cacheus", "LeCaR", "LIRS", "WTinyLFU"]

plot "data/hitimp/withoutobjsize/0.01.dat" using 2:0 with points ls 1 pt 9 ps 2 title '\sys', \
    "data/hitimp/withoutobjsize/0.01.dat" using 3:0 with points ls 2 title 'S3-FIFO', \
    "data/hitimp/withoutobjsize/0.01.dat" using 4:0 with points ls 3 title 'ARC', \
    "data/hitimp/withoutobjsize/0.01.dat" using 5:0 with points ls 4 title 'Cacheus', \
    "data/hitimp/withoutobjsize/0.01.dat" using 6:0 with points ls 5 title '', \
    "data/hitimp/withoutobjsize/0.01.dat" using 7:0 with points ls 8 title '', \
    "data/hitimp/withoutobjsize/0.01.dat" using 8:0 with points ls 7 title '', \
    "data/hitimp/withoutobjsize/0.01.dat" using 9:0 with points ls 6 title '', \
    "data/hitimp/withoutobjsize/0.01.dat" using 2:0 with points ls 1 pt 9 ps 2 title '', \
     #0.99 with lines dashtype 2 lc rgb "black" lw 1 title ""


eval mpNext
unset ylabel
#set boxwidth 0.8 absolute
#set xlabel 'cache size(\%)'
unset ytics
set key outside top horizontal maxrows 1 spacing 1.0 width -2 offset 0,-1
set xrange[0:0.6]
#set title 'Relative byte hit ratio improvement' offset 0,1

do for [i=1:11] {
    if (i%2 == 0) {
        set object i rect from graph 0, first (i-0.5) to graph 1, first (i+0.5) \
            fc rgb "#e0e0e0" fs solid 1.0 behind
    }
}

plot "data/hitimp/withobjsize/0.01.dat" using 2:0 with points ls 1 pt 9 ps 2 title '', \
    "data/hitimp/withobjsize/0.01.dat" using 3:0 with points ls 2 title '', \
    "data/hitimp/withobjsize/0.01.dat" using 4:0 with points ls 3 title '', \
    "data/hitimp/withobjsize/0.01.dat" using 5:0 with points ls 4 title '', \
    "data/hitimp/withobjsize/0.01.dat" using 6:0 with points ls 5 title 'LeCaR', \
    "data/hitimp/withobjsize/0.01.dat" using 7:0 with points ls 8 title 'LIRS', \
    "data/hitimp/withobjsize/0.01.dat" using 8:0 with points ls 7 title 'WTinyLFU', \
    "data/hitimp/withobjsize/0.01.dat" using 9:0 with points ls 6 title 'GDSF', \
    "data/hitimp/withobjsize/0.01.dat" using 2:0 with points ls 1 pt 9 ps 2 title '', \
     #0.99 with lines dashtype 2 lc rgb "black" lw 1 title ""

eval mpNext
unset ylabel
#set boxwidth 0.8 absolute
#set xlabel 'cache size(\%)'
set ytics ('Twitter' 1, 'MetaKV' 2, 'MetaCDN' 3,'TencentPhoto' 4, 'Wikimedia' 5, 'Tencent' 6, 'Systor' 7, 'fiu' 8, 'MSR' 9, 'Alibaba' 10, 'CloudPhysics' 11)
set ytics font "Times,5"
set ytics nomirror
set ylabel '3\% WSS'
set key outside top horizontal width 1 font "Times,8" offset 0,-1
set xrange[0:0.4]
unset title

do for [i=1:11] {
    if (i%2 == 0) {
        set object i rect from graph 0, first (i-0.5) to graph 1, first (i+0.5) \
            fc rgb "#e0e0e0" fs solid 1.0 behind
    }
}

plot "data/hitimp/withoutobjsize/0.03.dat" using 2:0 with points ls 1 pt 9 ps 2 title '', \
    "data/hitimp/withoutobjsize/0.03.dat" using 3:0 with points ls 2 title '', \
    "data/hitimp/withoutobjsize/0.03.dat" using 4:0 with points ls 3 title '', \
    "data/hitimp/withoutobjsize/0.03.dat" using 5:0 with points ls 4 title '', \
    "data/hitimp/withoutobjsize/0.03.dat" using 6:0 with points ls 5 title '', \
    "data/hitimp/withoutobjsize/0.03.dat" using 7:0 with points ls 8 title '', \
    "data/hitimp/withoutobjsize/0.03.dat" using 8:0 with points ls 7 title '', \
    "data/hitimp/withoutobjsize/0.03.dat" using 9:0 with points ls 6 title '', \
    "data/hitimp/withoutobjsize/0.03.dat" using 2:0 with points ls 1 pt 9 ps 2 title '', \
     #0.99 with lines dashtype 2 lc rgb "black" lw 1 title ""

eval mpNext
unset ylabel
#set boxwidth 0.8 absolute
#set xlabel 'cache size(\%)'
unset ytics
set key outside top horizontal width 1 font "Times,8" offset 0,-1
set xrange[0:0.6]

do for [i=1:11] {
    if (i%2 == 0) {
        set object i rect from graph 0, first (i-0.5) to graph 1, first (i+0.5) \
            fc rgb "#e0e0e0" fs solid 1.0 behind
    }
}

plot "data/hitimp/withobjsize/0.03.dat" using 2:0 with points ls 1 pt 9 ps 2 title '', \
    "data/hitimp/withobjsize/0.03.dat" using 3:0 with points ls 2 title '', \
    "data/hitimp/withobjsize/0.03.dat" using 4:0 with points ls 3 title '', \
    "data/hitimp/withobjsize/0.03.dat" using 5:0 with points ls 4 title '', \
    "data/hitimp/withobjsize/0.03.dat" using 6:0 with points ls 5 title '', \
    "data/hitimp/withobjsize/0.03.dat" using 7:0 with points ls 8 title '', \
    "data/hitimp/withobjsize/0.03.dat" using 8:0 with points ls 7 title '', \
    "data/hitimp/withobjsize/0.03.dat" using 9:0 with points ls 6 title '', \
    "data/hitimp/withobjsize/0.03.dat" using 2:0 with points ls 1 pt 9 ps 2 title '', \
     #0.99 with lines dashtype 2 lc rgb "black" lw 1 title ""

eval mpNext
unset ylabel
set ytics ('Twitter' 1, 'MetaKV' 2, 'MetaCDN' 3,'TencentPhoto' 4, 'Wikimedia' 5, 'Tencent' 6, 'Systor' 7, 'fiu' 8, 'MSR' 9, 'Alibaba' 10, 'CloudPhysics' 11)
set ytics font "Times,5"
set ytics nomirror
set ylabel '10\% WSS'
set key outside top horizontal width 5 font "Times,8" offset 0,-1
set xrange[0:0.4]
set format x "%g"        # 显示刻度文字
set xlabel 'Hit ratio improvement from LRU'

do for [i=1:11] {
    if (i%2 == 0) {
        set object i rect from graph 0, first (i-0.5) to graph 1, first (i+0.5) \
            fc rgb "#e0e0e0" fs solid 1.0 behind
    }
}


plot "data/hitimp/withoutobjsize/0.1.dat" using 2:0 with points ls 1 pt 9 ps 2 title '', \
    "data/hitimp/withoutobjsize/0.1.dat" using 3:0 with points ls 2 title '', \
    "data/hitimp/withoutobjsize/0.1.dat" using 4:0 with points ls 3 title '', \
    "data/hitimp/withoutobjsize/0.1.dat" using 5:0 with points ls 4 title '', \
    "data/hitimp/withoutobjsize/0.1.dat" using 6:0 with points ls 5 title '', \
    "data/hitimp/withoutobjsize/0.1.dat" using 7:0 with points ls 8 title '', \
    "data/hitimp/withoutobjsize/0.1.dat" using 8:0 with points ls 7 title '', \
    "data/hitimp/withoutobjsize/0.1.dat" using 9:0 with points ls 6 title '', \
    "data/hitimp/withoutobjsize/0.1.dat" using 2:0 with points ls 1 pt 9 ps 2 title '', \
     #0.99 with lines dashtype 2 lc rgb "black" lw 1 title ""

eval mpNext
unset ylabel
unset ytics
set key outside top horizontal width 5 font "Times,8" offset 0,-1
set xrange[0:0.6]
set xlabel 'Byte hit ratio improvement from LRU'

do for [i=1:11] {
    if (i%2 == 0) {
        set object i rect from graph 0, first (i-0.5) to graph 1, first (i+0.5) \
            fc rgb "#e0e0e0" fs solid 1.0 behind
    }
}


plot "data/hitimp/withobjsize/0.1.dat" using 2:0 with points ls 1 pt 9 ps 2 title '', \
    "data/hitimp/withobjsize/0.1.dat" using 3:0 with points ls 2 title '', \
    "data/hitimp/withobjsize/0.1.dat" using 4:0 with points ls 3 title '', \
    "data/hitimp/withobjsize/0.1.dat" using 5:0 with points ls 4 title '', \
    "data/hitimp/withobjsize/0.1.dat" using 6:0 with points ls 5 title '', \
    "data/hitimp/withobjsize/0.1.dat" using 7:0 with points ls 8 title '', \
    "data/hitimp/withobjsize/0.1.dat" using 8:0 with points ls 7 title '', \
    "data/hitimp/withobjsize/0.1.dat" using 9:0 with points ls 6 title '', \
    "data/hitimp/withobjsize/0.1.dat" using 2:0 with points ls 1 pt 9 ps 2 title '', \
     #0.99 with lines dashtype 2 lc rgb "black" lw 1 title ""
     