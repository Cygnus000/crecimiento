program expGeneralizado
    use, intrinsic :: iso_fortran_env, only: qp=>real128
    implicit none

    real(qp), parameter :: x0 = 0.05q0
    real(qp), parameter :: k = 0.1q0
    real(qp), parameter :: gama = 2.0q0/3.0q0

    real(qp), parameter :: t0 = 0.0q0
    real(qp), parameter :: tmax = 100.0q0
    integer          , parameter :: N    = 10000
    real(qp), parameter :: dt = (tmax - t0) / dble(N)
    integer          , parameter :: N_equ = 1    ! Numero de ecuaciones

    integer           :: i
    real(qp) :: r(N_equ)
    real(qp) :: t(N), x(N)
!**********************************************************************
    t = [ ( dt * i, i = 1, N ) ]             ! llenando vector temporal
!**********************************************************************
    r = [ x0 ]                                 ! valores iniciales
!**********************************************************************
    do i = 1, N                                           ! resolviendo
        x(i) = r(1)

        r = r + rk4( r, t(i), dt )
!**********************************************************************
        open(1,file='expGeneralizado.dat')           ! llenando archivo
          write(1,*) t(i), x(i)
          print*,    t(i), x(i)
    end do
    close(1) 
    call system('gnuplot -c expGeneralizado.p')
!**********************************************************************
contains
!**********************************************************************
    pure function f(r, t)   ! Aqui se colocan las ecuaciones a resolver
        real(qp), intent(in) :: r(N_equ) ! Valores
        real(qp), intent(in) :: t    ! Paso
        real(qp)             :: f(N_equ)
        real(qp)             :: u

        u = r(1)

        f(1) = k*u**gama
    end function f
!**********************************************************************
    pure function rk4(r, t, dt)                         ! Runge-Kutta 4
        real(qp), intent(in) :: r(N_equ) ! Valores
        real(qp), intent(in) :: t    ! Paso
        real(qp), intent(in) :: dt   ! Tamano de paso
        real(qp)             :: rk4(N_equ)
        real(qp)             :: k1(N_equ), k2(N_equ)
        real(qp)             :: k3(N_equ), k4(N_equ)   

        k1 = dt * f( r,            t                )
        k2 = dt * f( r + 0.5q0 * k1, t + 0.5q0 * dt )
        k3 = dt * f( r + 0.5q0 * k2, t + 0.5q0 * dt )
        k4 = dt * f( r + k3        , t + dt         )

        rk4 = ( k1 + ( 2.0q0 * k2 ) + ( 2.0q0 * k3 ) + k4 ) / 6.0q0
    end function rk4
!**********************************************************************
end program expGeneralizado
