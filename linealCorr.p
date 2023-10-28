set terminal pngcairo size 800,500 enhanced font 'Verdana,15'
set output 'linealCorr.png'
set title "Modelo Lineal"
unset key
set xlabel "Tiempo (d)"
set ylabel "Carga tumoral (mm)"
set grid
plot "lineal.dat" w l lt 6 lw 1,  "linealCorr.dat" w l lt 1 lw 3
