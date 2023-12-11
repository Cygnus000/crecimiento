set terminal pngcairo size 1200,750 enhanced font 'Verdana,23'
set output 'cuadratico.png'
set title "Modelo Cuadratico"
unset key
set xlabel "Tiempo (d)"
set ylabel "Carga tumoral (mm)"
set grid
plot "cuadratico.dat" w l lt 6 lw 5

