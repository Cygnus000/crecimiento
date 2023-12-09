#set terminal pngcairo size 800,500 enhanced font 'Verdana,15'
#set output 'cuadratico.png'
set terminal tikz enhanced font 'Verdana,15' color
set out 'nanodot.t'
set title "Modelo Cuadratico"
unset key
set xlabel "Tiempo (d)"
set ylabel "Carga tumoral (mm)"
set grid
plot "cuadratico.dat" w l lt 6 lw 3

