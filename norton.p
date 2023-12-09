#graficando modelo de norton simon
set terminal pngcairo size 800,500 enhanced font 'Verdana,15'
set output 'norton.png'
set title "Modelo de Norton-Simon"
set xlabel "Tiempo (d)"
set ylabel "concentración (celulas/litro , mg/litro)"
set grid
plot "norton.dat" u 1:4 w l  lt 7 lw 3 title "Celulas dañadas (d)", "norton.dat" u 1:3 w l lt 2 lw 3 title "Celulas sensibles (s)", "norton.dat" u 1:2 w l lt 6 lw 3 title "Carga tumoral (s+d)", "norton.dat" u 1:5 w l lt 1 lw 3 title "Fármaco"

