program logkill
!Resolucion de la ecuacion diferencial X'(t)=kg*X-kd*X con runge kutta de orden 2
implicit none

real(kind=8) t0,tmax,dt,x0,k_g,k_d
real(kind=8), allocatable, dimension (:) :: t,x
integer i,j,N

!**********************************************************************
t0   = 0.0d0
tmax = 100.0d0
N    = 10000
x0   = 30.0d0
k_g = 0.1d0
k_d = 0.4d0

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
      x(i) = x(i-1) + ( k_g * x(i-1) - k_d * x(i-1) ) * dt
    else
      x(i) = 0.5d0 * ( x(i-1) + ( k_g * x(i-1) - k_d * x(i-1) ) * dt + x(i) )
    end if
  end do
end do
!**********************************************************************
open(1,file='logkill.dat') !llenando archivo
do i=0,N,1
  write(1,*) t(i),x(i)
end do
close(1)
call system('gnuplot -p logkill.p')
!**********************************************************************
end program logkill
