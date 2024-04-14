# Modelos de Crecimiento de Tumores
Codigos fortran 90 que implementan el metodo Runge Kutta de orden 2 para resolver Sistemas de Ecuaciones Diferenciales Ordinarias (EDOs) de diferentes modelos de crecimiento de tumores.
Los modelos resueltos son:

+ Crecimiento lineal (lineal.f90)
+ Crecimiento Cuadratico (cuadratico.f90)
+ Crecimiento Exponencial (exponencial.f90)
+ Crecimiento Exponencial-lineal (explin.f90)
+ Crecimiento Exponencial Generalizado (expGeneralizado.f90)
+ Crecimiento Von Bertalanffy (von.f90)
+ Crecimiento Logistico (logistico.f90)
+ Crecimiento Gompertz (gompertz.f90)

Modelos de Crecimiento de tumores con Runge Kutta de orden 4:

+ Crecimiento lineal (lineal4.f90)
+ Crecimiento Cuadratico (cuadratico4.f90)
+ Crecimiento Exponencial (exponencial4.f90)
+ Crecimiento Exponencial-lineal (explin4.f90)
+ Crecimiento Exponencial Generalizado (expGeneralizado4.f90)
+ Crecimiento Von Bertalanffy (von4.f90)
+ Crecimiento Logistico (logistico4.f90)
+ Crecimiento Gompertz (gompertz4.f90)

Modelos de Tratamiento de tumores con Dormand-Prince:

+ Crecimiento lineal (linealDP.f90)
+ Crecimiento Cuadratico (cuadraticoDP.f90)
+ Crecimiento Exponencial (exponencialDP.f90)
+ Crecimiento Exponencial-lineal (explinDP.f90)
+ Crecimiento Exponencial Generalizado (expGeneralizadoDP.f90)
+ Crecimiento Von Bertalanffy (vonDP.f90)
+ Crecimiento Logistico (logisticoDP.f90)
+ Crecimiento Gompertz (gompertzDP.f90)

Codigos gnuplot para generar graficos en formato png automaticamente a partir de los archivos de datos (*.dat) generados en fortran, estos son los mismos para RK2 y RK4:

+ Crecimiento lineal (lineal.p)
+ Crecimiento Cuadratico (cuadratico.p)
+ Crecimiento Exponencial (exponencial.p)
+ Crecimiento Exponencial-lineal (explin.p)
+ Crecimiento Exponencial Generalizado (expGeneralizado.p)
+ Crecimiento Von Bertalanffy (von.p)
+ Crecimiento Logistico (logistico.p)
+ Crecimiento Gompertz (gompertz.p)

Las siguientes grafiacas corresponden al método de RK4
![Modelo lineal](https://github.com/Cygnus000/crecimiento/blob/main/lineal.png)
![Modelo cuadratico](https://github.com/Cygnus000/crecimiento/blob/main/cuadratico.png)
![Modelo exponencial](https://github.com/Cygnus000/crecimiento/blob/main/exponencial.png)
![Modelo exponencial-lineal](https://github.com/Cygnus000/crecimiento/blob/main/explin.png)
![Modelo exponencial generalizado](https://github.com/Cygnus000/crecimiento/blob/main/expGeneralizado.png)
![Modelo von bertalanffy](https://github.com/Cygnus000/crecimiento/blob/main/von.png)
![Modelo logistico](https://github.com/Cygnus000/crecimiento/blob/main/logistico.png)
![Modelo gompertz](https://github.com/Cygnus000/crecimiento/blob/main/gompertz.png)

Al emplear el Metodo de Dormand-Prince se pueden llegar a obtener graficas con apariecia no suave por lo tanto se define un tamaño maximo de paso para evitar esto, en este detalle se puede ver como se mantiene la precisión en un menor número de pasos.

![comparacion de modelos](https://github.com/Cygnus000/crecimiento/blob/main/cuadratico-comparacion.png)
