###########################################################
# Common settings
###########################################################
call "data/common.gnuplot" "10in,2in"
set output "`echo $OUT`"

###########################################################
# 输入文件
###########################################################
file1 = "data/flash/flash-0.1-0.0010.dat"
file2 = "data/flash/flash-0.1-0.0100.dat"
file3 = "data/flash/flash-0.1-0.1000.dat"

###########################################################
# 输出过滤后的临时文件（两列：x y）
###########################################################
out1_flex   = "data/flash/tmp.00010.flex.dat"
out1_s3f    = "data/flash/tmp.00010.s3f.dat"

out2_flex   = "data/flash/tmp.00100.flex.dat"
out2_s3f    = "data/flash/tmp.00100.s3f.dat"

out3_flex   = "data/flash/tmp.01000.flex.dat"
out3_s3f    = "data/flash/tmp.01000.s3f.dat"

###########################################################
# 过滤规则： x < 3
# x = (1 - algo_mr) / (1 - fifo_mr)
# y = algo_wa / fifo_wa
###########################################################

# ------------ file1 -> flex ------------
set table out1_flex
plot file1 using \
    ( (1-$4)/(1-$2) < 3 ? (1-$4)/(1-$2) : 1/0 ) : ($5/$3) notitle
unset table

# ------------ file1 -> s3fifo ------------
set table out1_s3f
plot file1 using \
    ( (1-$6)/(1-$2) < 3 ? (1-$6)/(1-$2) : 1/0 ) : ($7/$3) notitle
unset table


# ------------ file2 -> flex ------------
set table out2_flex
plot file2 using \
    ( (1-$4)/(1-$2) < 3 ? (1-$4)/(1-$2) : 1/0 ) : ($5/$3) notitle
unset table

# ------------ file2 -> s3fifo ------------
set table out2_s3f
plot file2 using \
    ( (1-$6)/(1-$2) < 3 ? (1-$6)/(1-$2) : 1/0 ) : ($7/$3) notitle
unset table


# ------------ file3 -> flex ------------
set table out3_flex
plot file3 using \
    ( (1-$4)/(1-$2) < 3 ? (1-$4)/(1-$2) : 1/0 ) : ($5/$3) notitle
unset table

# ------------ file3 -> s3fifo ------------
set table out3_s3f
plot file3 using \
    ( (1-$6)/(1-$2) < 3 ? (1-$6)/(1-$2) : 1/0 ) : ($7/$3) notitle
unset table



###########################################################
# 绘图配置（复刻你上传的图）
###########################################################

set multiplot layout 1,3

set xlabel "relative hit ratio"
set ylabel "relative write bytes"

set xtics font ",10"
set ytics font ",10"

set grid lc rgb "#cccccc"
set xrange [0.7:1.4]
set yrange [0:1.05]

# 虚线参考线
set arrow from 1,0 to 1,1 nohead dashtype 2 lc rgb "#888888"
set arrow from 0,1 to 1.4,1 nohead dashtype 2 lc rgb "#888888"

flexstyle  = "pt 9  ps 1.4 lc rgb '#E53935'"
s3fstyle   = "pt 2  ps 1.4 lc rgb '#4CAF50'"

###########################################################
# 图 1
###########################################################
set title "flash ratio = 0.0010" font ",12"
plot out1_s3f  using 1:2 w p @s3fstyle title "s3fifo", \
     out1_flex using 1:2 w p @flexstyle title "flex"

###########################################################
# 图 2
###########################################################
set title "flash ratio = 0.0100" font ",12"
plot out2_s3f  using 1:2 w p @s3fstyle title "s3fifo", \
     out2_flex using 1:2 w p @flexstyle title "flex"

###########################################################
# 图 3
###########################################################
#set title "flash ratio = 0.1000" font ",12"
#plot out3_s3f  using 1:2 w p @s3fstyle title "s3fifo", \
#     out3_flex using 1:2 w p @flexstyle title "flex"


unset multiplot
