set terminal pngcairo size 800,500 enhanced font 'Verdana,15'
set output 'gompertz.png'
set title "Modelo de Gompertz"
set xlabel "Tiempo"
set ylabel "Carga tumoral"
set grid
unset key
plot "gompertz.dat" w l lt 6 lw 3

