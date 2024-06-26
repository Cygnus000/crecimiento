program cuadratico
!Resolucion de la ecuacion diferencial X'(t)=k_1+2k_2*t con runge kutta de orden 2
implicit none
integer, parameter :: dp = 8
real(dp) t0,tmax,dt,x0,z0,k1,k2
real(dp), allocatable, dimension (:) :: t,x,z
integer i,j,N

!**********************************************************************
t0   = 0.0_dp
tmax = 100.0_dp
N    = 10000
x0   = 0.0_dp
z0 = 0.0_dp
k1 = 0.1_dp
k2 = 0.1_dp

allocate(t(0:N),x(0:N),z(0:N))
!**********************************************************************
dt = (tmax - t0) / dble(N) !llenando vector temporal
do i=0,N
  t(i) = t0 + dt * dble(i)
end do
!**********************************************************************
 x(0) = x0 !valores iniciales
 z(0) = z0 !valor del tiempo
!**********************************************************************
do i=1,N !runge kutta
  do j=1,2
    if (j.eq.1) then
      z(i) = z(i-1) + 1.0_dp * dt
      x(i) = x(i-1) + ( k1 + 2.0_dp*k2*z(i) ) * dt
    else
      z(i) = 0.5_dp * ( z(i-1) + (1.0_dp ) * dt + z(i) )
      x(i) = 0.5_dp * ( x(i-1) + ( k1 + 2.0_dp*k2*z(i) ) * dt + x(i) )
    end if
  end do
end do
!**********************************************************************
open(1,file='cuadratico.dat') !llenando archivo
do i=0,N,1
  write(1,*) t(i),x(i)
end do
close(1)
call system('gnuplot -c cuadratico.gplot')
!**********************************************************************
end program cuadratico
