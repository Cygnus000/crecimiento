set terminal pngcairo size 800,500 enhanced font 'Verdana,15'
set output 'logkill-H.png'
set title "Modelo Efecto Proporcional Con farmaco"
unset key
set xlabel "Tiempo (d)"
set ylabel "Carga tumoral (mm)"
set grid
plot "logkill-H.dat" w l lt 6 lw 3

