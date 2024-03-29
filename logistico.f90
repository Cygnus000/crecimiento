program logistico
!Resuelucion la ecuacion logistica X'(t)=k_g*X(t)*(1-(x(t)/x_max)) con runge kutta de orden 2
implicit none

real(kind=8) t0,tmax,dt,x0,k,x_max
real(kind=8), allocatable, dimension (:) :: t,x
integer i,j,N

!**********************************************************************
t0   = 0.0d0
tmax = 100.0d0
N    = 10000
x0   = 0.05d0
k = 0.1d0
x_max = 120.0d0

allocate(t(0:N),x(0:N))
!**********************************************************************
dt = (tmax - t0) / dble(N) !llenando vector temporal
do i=0,N
  t(i) = t0 + dt * dble(i)
end do
!**********************************************************************
 x(0) = x0 !valores iniciales
!**********************************************************************
do i=1,N !runge kutta
  do j=1,2
    if (j.eq.1) then
      x(i) = x(i-1) + k * x(i-1) * (1 - (x(i-1) / x_max ) ) * dt
    else
      x(i) = 0.5d0 * (x(i-1) + k * x(i-1) * (1 - (x(i-1) / x_max ) )* dt + x(i))
    end if
  end do
end do
!**********************************************************************
open(1,file='logistico.dat') !llenando archivo
do i=0,N,1
  write(1,*) t(i),x(i)
end do
close(1)
call system('gnuplot -p logistico.p')
!**********************************************************************
end program logistico
