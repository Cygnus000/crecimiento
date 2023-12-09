program norton
!Resolucion de la ecuacion diferencial X1'(t)=kg*X1*ln(Xmax/X1)-a*X1, 
! X2=a*X1-kd*X2 con runge kutta de orden 2
implicit none

real(kind=8) t0,tmax,dt,x10,x20,k_g,k_d,a,Xmax,u0
real(kind=8), allocatable, dimension (:) :: t,x1,x2,z,u
integer i,j,N

!**********************************************************************
t0   = 0.0d0
tmax = 100.0d0
N    = 10000
x10  = 30.0d0
x20  = 0.0d0
k_g  = 0.1d0
k_d  = 0.04d0
a    = 0.1d0
Xmax = 40.0d0
u0 = 0.0d0


allocate(t(0:N),x1(0:N),x2(0:N),z(0:N),u(0:N))
!**********************************************************************
dt = (tmax - t0) / dble(N) !llenando vector temporal
do i=0,N
  t(i) = t0 + dt * dble(i)
end do
!**********************************************************************
 x1(0) = x10 !valores iniciales
 x2(0) = x20
 u(0)  = u0
!**********************************************************************
do i=1,N !runge kutta
  do j=1,2
    if (j.eq.1) then
      z(i) = z(i-1) + 1.0d0 * dt
      u(i) = 30.0d0*(sqrt(z(i-1))/(sqrt(10.0d0)+sqrt(z(i-1))))
      x1(i) = x1(i-1) + ( k_g * x1(i-1) * log(Xmax/x1(i-1)) - a * u(i) * x1(i-1) ) * dt
      x2(i) = x2(i-1) + ( a * u(i) * x1(i-1) - k_d * x2(i-1) ) * dt
    else
      z(i) = 0.5d0 * ( z(i-1) + (1.0d0 ) * dt + z(i) )
      u(i) = 30.0d0*(sqrt(z(i-1))/(sqrt(10.0d0)+sqrt(z(i-1))))
      x1(i) = 0.5d0 * ( x1(i-1) + ( k_g * x1(i-1) * log(Xmax/x1(i-1)) - a * u(i) * x1(i-1) ) * dt + x1(i) )
      x2(i) = 0.5d0 * ( x2(i-1) + ( a * u(i) * x1(i-1) - k_d * x2(i-1) ) * dt + x2(i) )
    end if
  end do
end do
!**********************************************************************
open(1,file='norton.dat') !llenando archivo
do i=0,N,1
  write(1,*) t(i),x1(i)+x2(i),x1(i),x2(i),u(i)
end do
close(1)
call system('gnuplot -c norton.p')
!**********************************************************************
end program norton
