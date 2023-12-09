program nova
!Resolucion del modelo de stepanova
implicit none

real(kind=8) t0,tmax,dt,x0,z0,gama,kI,beta,delta,mu,kg,xm
real(kind=8), allocatable, dimension (:) :: t,x,z
integer i,j,N

!**********************************************************************
t0   = 0.0d0
tmax = 100.0d0
N    = 10000
x0   = 1.0d0
z0 = 0.0d0
kg = 0.6d0
xm = 7.5d0
gama = 1.0d0
kI = 0.5d0
beta = 0.3d0
delta = 0.4d0
mu = 0.1d0

allocate(t(0:N),x(0:N),z(0:N))
!**********************************************************************
dt = (tmax - t0) / dble(N) !llenando vector temporal
do i=0,N
  t(i) = t0 + dt * dble(i)
end do
!**********************************************************************
 x(0) = x0 !valores iniciales
 z(0) = z0
!**********************************************************************
do i=1,N !runge kutta
  do j=1,2
    if (j.eq.1) then
      x(i) = x(i-1) + ( kg * x(i-1) * (1.0 - x(i-1)/xm) - gama * x(i-1) * z(i-1) ) * dt
      z(i) = z(i-1) + ( kI * ( x(i-1) - beta * x(i-1)**2 ) * z(i-1) - delta * z(i-1) + mu ) * dt
    else
      x(i) = 0.5d0 * ( x(i-1) + ( kg * x(i-1) * (1.0 - x(i-1)/xm) - gama * x(i-1) * z(i-1) ) * dt + x(i) )
      z(i) = 0.5d0 * ( z(i-1) + ( kI * ( x(i-1) - beta * x(i-1)**2 ) * z(i-1) - delta * z(i-1) + mu ) * dt + z(i) )
    end if
  end do
end do
!**********************************************************************
open(1,file='nova.dat') !llenando archivo
do i=0,N,1
  write(1,*) t(i),x(i),z(i)
end do
close(1) 
call system('gnuplot -c nova.p')
!**********************************************************************
end program nova
