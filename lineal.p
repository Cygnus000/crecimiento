set terminal pngcairo size 800,500 enhanced font 'Verdana,15'
set output 'lineal.png'
set title "Modelo Lineal"
unset key
set xlabel "Tiempo"
set ylabel "Carga tumoral"
set grid
plot "lineal.dat" w l lt 6 lw 3

