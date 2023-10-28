set terminal pngcairo size 800,500 enhanced font 'Verdana,15'
set output 'expGeneralizado.png'
set title "Modelo Exponencial Generalizado"
unset key
set xlabel "Tiempo (d)"
set ylabel "Carga tumoral (mm)"
set grid
plot "expGeneralizado.dat" w l lt 6 lw 3

