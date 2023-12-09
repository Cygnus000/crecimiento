program explin
!Resolucion de la ecuacion diferencial X'(t)=k_e*N para t<tau y X'(t)=k_l para t>=tau con runge kutta de orden 2
!X'(t)=k_e*X(t)/(1+((k_e/k_l)*X(t))**gamma)**(1/gamma) (Modelo de Simeoni)
implicit none

real(kind=8) t0,tmax,dt,x0,k0,k1,tau
real(kind=8), allocatable, dimension (:) :: t,x
integer i,j,N

!**********************************************************************
t0   = 0.0d0
tmax = 100.0d0
N    = 10000
x0   = 2.0912d0
k0 = 0.31d0
k1 = 67.8d0
tau = 15.0d0
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
    if((dt*i).lt.tau) then
        if (j.eq.1) then
          x(i) = x(i-1) + k0 * x(i-1) * dt
        else
          x(i) = 0.5d0 * (x(i-1) + k0 * x(i-1) * dt + x(i))
        end if
    else
        if (j.eq.1) then
            x(i) = x(i-1) + k1 * dt
        else
            x(i) = 0.5d0 * (x(i-1) + k1 * dt + x(i))
        end if
    endif
  end do
end do
!**********************************************************************
open(1,file='explin.dat') !llenando archivo
do i=0,N,1
  write(1,*) t(i),x(i)
end do
close(1) 
call system('gnuplot -p explin.p')
!**********************************************************************
end program explin
