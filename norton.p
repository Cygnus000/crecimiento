set terminal pngcairo size 800,500 enhanced font 'Verdana,15'
set output 'norton.png'
set title "Modelo de Norton-Simon"
unset key
set xlabel "Tiempo (d)"
set ylabel "Carga tumoral (mm)"
set grid
plot "norton.dat" w l lt 6 lw 3

