program logkillResistencia
!Resolucion de la ecuacion diferencial X'(t)=kg*X-kd*X*U(t)*e^(-lambda*t) con runge kutta de orden 2
implicit none

real(kind=8) t0,tmax,dt,x0,k_g,k_d,lambda,u0
real(kind=8), allocatable, dimension (:) :: t,x,z,u
integer i,j,N

!**********************************************************************
t0   = 0.0d0
tmax = 50.0d0
N    = 10000
x0   = 30.0d0
k_g = 0.1d0
k_d = 0.04d0
lambda = 0.1d0
u0 = 0.0d0

allocate(t(0:N),x(0:N),z(0:N),u(0:N))
!**********************************************************************
dt = (tmax - t0) / dble(N) !llenando vector temporal
do i=0,N
  t(i) = t0 + dt * dble(i)
end do
!**********************************************************************
 x(0) = x0 !valores iniciales
 u(0) = u0
!**********************************************************************
do i=1,N !runge kutta
  do j=1,2
    if (j.eq.1) then
      z(i) = z(i-1) + 1.0d0 * dt
      u(i) = 30.0d0*(sqrt(z(i-1))/(sqrt(10.0d0)+sqrt(z(i-1))))
      x(i) = x(i-1) + ( k_g * x(i-1) - exp(-lambda*z(i-1)) *&
       k_d * x(i-1) * u(i) ) * dt
    else
      z(i) = 0.5d0 * ( z(i-1) + (1.0d0 ) * dt + z(i) )
      u(i) = 30.0d0*(sqrt(z(i-1))/(sqrt(10.0d0)+sqrt(z(i-1))))
      x(i) = 0.5d0 * &
      ( x(i-1) + ( k_g * x(i-1) - exp(-lambda*z(i-1)) *&
      k_d * x(i-1) * u(i) ) * dt + x(i) )
    end if
  end do
end do
!**********************************************************************
open(1,file='resistencia.dat') !llenando archivo
do i=0,N,1
  write(1,*) t(i),x(i),u(i)
end do
close(1)
call system('gnuplot -c resistencia.p')
!**********************************************************************
end program logkillResistencia
