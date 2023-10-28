set terminal pngcairo size 800,500 enhanced font 'Verdana,15'
set output 'exponencialCorr.png'
set title "Modelo Exponencial"
set xlabel "Tiempo (d)"
set ylabel "Carga tumoral (mm)"
set grid
unset key
plot "exponencial.dat" w l lt 1 lw 3, "exponencialCorr.dat" w l lt 6 lw 3


