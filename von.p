set terminal pngcairo size 800,500 enhanced font 'Verdana,15'
set output 'von.png'
set title "Modelo de Von Bertalanffy"
set xlabel "Tiempo (d)"
set ylabel "Carga tumoral (mm)"
set grid
unset key
plot "von.dat" w l lt 6 lw 3

