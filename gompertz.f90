program gompertz
!Resolucion de la ecuacion de gompertz X'(t)=k_g*X(t)*ln(1-(X_max/X(t))) con runge kutta de orden 2
implicit none
integer, parameter :: dp = 8
real(dp) t0,tmax,dt,x0,k_g,x_max
real(dp), allocatable, dimension (:) :: t,x
integer i,j,N

!**********************************************************************
t0    = 0.0_dp
tmax  = 100.0_dp
N     = 10000
x0    = 0.05_dp
k_g   = 0.1_dp
x_max = 120.0_dp

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
      x(i) = x(i-1) + k_g * x(i-1) * log( x_max / x(i-1) ) * dt
    else
      x(i) = 0.5_dp * (x(i-1) + k_g * x(i-1) * log( x_max / x(i-1) ) * dt + x(i))
    end if
  end do
end do
!**********************************************************************
open(1,file='gompertz.dat') !llenando archivo
do i=0,N,1
  write(1,*) t(i),x(i)
end do
close(1)
call system('gnuplot -p gompertz.gplot')
!**********************************************************************
end program gompertz
