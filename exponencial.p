set terminal pngcairo size 800,500 enhanced font 'Verdana,15'
set output 'exponencial.png'
set title "Modelo Exponencial"
set xlabel "Tiempo"
set ylabel "Carga tumoral"
set grid
unset key
plot "exponencial.dat" w l lt 6 lw 3

