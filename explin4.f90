program explin
    use, intrinsic :: iso_fortran_env, only: qp=>real128
    implicit none

    real(qp), parameter :: x0 = 2.0912_qp
    real(qp), parameter :: k00 = 0.31_qp
    real(qp), parameter :: k01 = 67.8_qp
    real(qp), parameter :: tau = 15.0_qp

    real(qp), parameter :: t0 = 0.0_qp
    real(qp), parameter :: tmax = 100.0_qp
    integer , parameter :: N    = 10000
    real(qp), parameter :: dt = (tmax - t0) / dble(N)
    integer , parameter :: N_equ = 1    ! Numero de ecuaciones

    integer  :: i
    real(qp) :: r(N_equ), t(N), x(N)
!**********************************************************************
    t = [ ( dt * i, i = 1, N ) ]             ! llenando vector temporal
!**********************************************************************
    r = [ x0 ]                                      ! valores iniciales
!**********************************************************************
    open(1,file='explin.dat')                    ! llenando archivo
    do i = 1, N                                           ! resolviendo
        x(i) = r(1)

        r = r + rk4( r, t(i), dt )
        write(1,*) t(i), x(i)
        print*,    t(i), x(i)
    end do
    close(1)
    call system('gnuplot -c explin.gplot')
!**********************************************************************
contains
!**********************************************************************
    pure function f(r, t)   ! Aqui se colocan las ecuaciones a resolver
        real(qp), intent(in) :: r(N_equ) ! Valores
        real(qp), intent(in) :: t    ! Paso
        real(qp)             :: f(N_equ)
        real(qp)             :: u

        u = r(1)

        if(t<tau) then
            f(1) = k00*u
        else
            f(1) = k01
        endif

    end function f
!**********************************************************************
    pure function rk4(r, t, dt)                         ! Runge-Kutta 4
        real(qp), intent(in) :: r(N_equ) ! Valores
        real(qp), intent(in) :: t    ! Paso
        real(qp), intent(in) :: dt   ! Tamano de paso
        real(qp)             :: rk4(N_equ)
        real(qp)             :: k1(N_equ), k2(N_equ)
        real(qp)             :: k3(N_equ), k4(N_equ)

        k1 = dt * f( r              , t               )
        k2 = dt * f( r + 0.5_qp * k1, t + 0.5_qp * dt )
        k3 = dt * f( r + 0.5_qp * k2, t + 0.5_qp * dt )
        k4 = dt * f( r + k3         , t + dt          )

        rk4 = ( k1 + ( 2._qp * k2 ) + ( 2._qp * k3 ) + k4 ) / 6._qp
    end function rk4
!**********************************************************************
end program explin
