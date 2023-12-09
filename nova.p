set terminal pngcairo size 800,500 enhanced font 'Verdana,15'
set output 'nova.png'
set title "Modelo de Stepanova"
set xlabel "Tiempo (d)"
set ylabel "concentración (células/litro)"
set grid
plot "nova.dat" w l lt 6 lw 3 title "Carga Tumoral","nova.dat" u 1:3 w l lt 1 lw 3 title "Células T-killer"

