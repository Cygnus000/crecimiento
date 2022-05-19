set terminal pngcairo size 800,500 enhanced font 'Verdana,15'
set output 'logistico.png'
set title "Modelo Logistico"
set xlabel "Tiempo"
set ylabel "Carga tumoral"
set grid
unset key
plot "logistico.dat" w l lt 6 lw 3

