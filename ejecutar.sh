#!/bin/bash
 out=".out"
 dat=".dat"
 read -p "RungeKutta2 -> 2, RungeKutta4 -> 4, Dopri45 -> 45: " rk;
 if [ "$rk" == "2" ]
 then
    nombres="*[^4].f90"
 elif [ "$rk" == "4" ]
 then
    nombres="*[+4].f90"
 elif [ "$rk" == "45" ]
 then
    nombres="*[+D][+P][+4][+5].f90"
 fi
for i in $nombres; do
    nombre=$(echo $i | cut -d '.' -f 1)
    echo "gfortran $nombre -o $nombre$out"
    gfortran $i -o $nombre$out
    echo "./$nombre$out"
    ./$nombre$out > /dev/null
    echo "rm $nombre$out"
    echo "rm $nombre$dat"
done
    rm *.dat *.out
 read -p "PRESIONE UNA TECLA PARA FINALIZAR" fin

