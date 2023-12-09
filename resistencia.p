set terminal pngcairo size 800,500 enhanced font 'Verdana,15'
set output 'resistencia.png'
set title "Modelo Efecto Proporcional Con Resistencia al Fármaco"
set xlabel "Tiempo (d)"
set ylabel "Concentración (celulas/litro  mg/litro)"
set grid
plot "resistencia.dat" w l lt 6 lw 3 title "Carga Tumoral", "resistencia.dat" u 1:3 w l lt 1 lw 3 title "Fármaco"

