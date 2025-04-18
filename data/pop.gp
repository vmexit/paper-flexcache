call "data/common.gnuplot" "3.3in, 1.5in"
set output "`echo $OUT`"

mp_startx=0.05
mp_starty=0.10
mp_height=0.70
mp_rowgap=0.10
mp_colgap=0.13
mp_width=1.0

eval mpSetup(2, 1)
#set xtics ("0.3" 1, '1' 2 ,'3' 3, '10' 4, '20' 5, '40' 6)

eval mpNext
unset ylabel
#set key at 120,0.4
#set style data histogram
#set style fill pattern
#set boxwidth 0.8 absolute
#set ylabel 'Number of objects'
set xlabel 'Access frequency' offset 0,0.8

#set ytics  0.2
#set xtics 40
set logscale y
set logscale x
set xtics rotate
set title '(a) Alibaba' offset 0,-0.5

plot "data/pop.dat" using 1:2 with points ls 2 ps 0.3 title "Number of objects", \
    "data/pop.dat" using 1:3 with points ls 3 ps 0.3 title "Average reuse time", \
     


eval mpNext
unset ylabel
#set style data histogram
#set style fill pattern
#set boxwidth 0.8 absolute
set logscale y
set logscale x
set xtics rotate
set title '(B) Twitter' offset 0,-0.5
plot "data/pop2.dat" using 1:2 with points ls 2 ps 0.3 title "", \
    "data/pop2.dat" using 1:3 with points ls 3 ps 0.3 title "", \




