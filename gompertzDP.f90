program gompertz
    use, intrinsic :: iso_fortran_env, only: qp=>real128
    implicit none
    !valores iniciales
    real(qp), parameter :: x0 = 0.05_qp
    real(qp), parameter :: k = 0.1_qp
    real(qp), parameter :: x_max = 120.0_qp

    real(qp), parameter :: t0 = 0.0_qp
    real(qp), parameter :: t_max = 100.0_qp
    !parametros iniciales
    real(qp), parameter :: tinny = 0.e-30_qp
    integer , parameter :: max_steps = 10000
    integer , parameter :: N_equ = 1    ! Numero de ecuaciones
    integer  :: step = 0
    real(qp) :: dt = 0.05_qp
    real(qp) :: dt_next = 0._qp
    real(qp) :: t, x1
    real(qp) :: r(N_equ), tmp(N_equ)
!**********************************************************************
    t = t0                                          ! valores iniciales
    r = [ x0 ]
        open(1,file='gompertz.dat')           ! llenando archivo
!**********************************************************************
    do                                    ! resolviendo
      write(1,*) t, r(1)
      print*,    t, r(1)

      if( t .ge. t_max .or. step .ge. max_steps ) exit

      step=step+1
      if ((t + dt) > t_max) dt = t_max-t
      call adaptativo(r,t,dt,dt_next,tmp)
      t=t+dt
      r=r+tmp
      dt=min(dt_next,0.25_qp)

      x1 = r(1)
    end do
    close(1)
    print*,'terminadon en ',step,'pasos.'
    call system('gnuplot -c gompertz.gplot')
!**********************************************************************
contains
!**********************************************************************
    pure function f(r, t) ! Aqui se colocan las ecuaciones a resol
        real(qp), intent(in) :: r(N_equ) ! Valores
        real(qp), intent(in) :: t        ! Tiempo
        real(qp)             :: f(N_equ)
        real(qp)             :: u

        u = r(1)

        f(1) = k*u*log(x_max/u)

    end function f
!**********************************************************************
    subroutine dopri(r, t, dt, errores, ytemp)  ! dormand prince
    real(qp), intent(in)  :: r(N_equ) ! Valores
    real(qp), intent(in)  :: t    ! Paso
    real(qp), intent(in)  :: dt   ! Tamano de paso
    real(qp), intent(out) :: errores(N_equ),ytemp(N_equ)
    real(qp) :: k1(N_equ),k2(N_equ),k3(N_equ),k4(N_equ)
    real(qp) :: k5(N_equ),k6(N_equ),k7(N_equ)
    ! parametros de tiempo
    real(qp),parameter :: a2 =  1.0_qp / 5.0_qp
    real(qp),parameter :: a3 =  3.0_qp / 10.0_qp
    real(qp),parameter :: a4 =  4.0_qp / 5.0_qp
    real(qp),parameter :: a5 =  8.0_qp / 9.0_qp
    ! parametros de paso intermedio
    real(qp),parameter :: b21 = 1.0_qp / 5.0_qp
    real(qp),parameter :: b31 = 3.0_qp / 40.0_qp
    real(qp),parameter :: b32 = 9.0_qp / 40.0_qp
    real(qp),parameter :: b41 = 44.0_qp / 45.0_qp
    real(qp),parameter :: b42 = -56.0_qp / 15.0_qp
    real(qp),parameter :: b43 = 32.0_qp / 9.0_qp
    real(qp),parameter :: b51 = 19372.0_qp / 6561.0_qp
    real(qp),parameter :: b52 = -25360.0_qp / 2187.0_qp
    real(qp),parameter :: b53 = 64448.0_qp / 6561.0_qp
    real(qp),parameter :: b54 = -212.0_qp / 729.0_qp
    real(qp),parameter :: b61 = 9017.0_qp / 3168.0_qp
    real(qp),parameter :: b62 = -355.0_qp / 33.0_qp
    real(qp),parameter :: b63 = 46732.0_qp / 5247.0_qp
    real(qp),parameter :: b64 = 49.0_qp / 176.0_qp
    real(qp),parameter :: b65 = -5103.0_qp / 18656.0_qp
    real(qp),parameter :: b71 = 35.0_qp / 384.0_qp
    real(qp),parameter :: b73 = 500.0_qp / 1113.0_qp
    real(qp),parameter :: b74 = 125.0_qp / 192.0_qp
    real(qp),parameter :: b75 = -2187.0_qp / 6784.0_qp
    real(qp),parameter :: b76 = 11.0_qp / 84.0_qp
    ! parametros rk5
    real(qp),parameter :: d1  = 5179.0_qp / 57600.0_qp
    real(qp),parameter :: d3  = 7571.0_qp / 16695.0_qp
    real(qp),parameter :: d4  = 393.0_qp / 640.0_qp
    real(qp),parameter :: d5  = -92097.0_qp / 339200.0_qp
    real(qp),parameter :: d6  = 187.0_qp / 2100.0_qp
    real(qp),parameter :: d7  = 1.0_qp / 40.0_qp
    ! parametros error
    real(qp),parameter :: e1  = 71.0_qp/57600.0_qp     !c1 - d1
    real(qp),parameter :: e3  =-71.0_qp/16695.0_qp     !c3 - d3
    real(qp),parameter :: e4  = 71.0_qp/1920.0_qp      !c4 - d4
    real(qp),parameter :: e5  =-17253.0_qp/339200.0_qp !c5 - d5
    real(qp),parameter :: e6  = 22.0_qp/525.0_qp       !c6 - d6
    real(qp),parameter :: e7  =-1.0_qp/40.0_qp         !   - d7

     k1 = dt*f(r                                        ,t)
     k2 = dt*f(r + ( b21*k1                            ),t + a2*dt)
     k3 = dt*f(r + ( b31*k1 + b32*k2                   ),t + a3*dt)
     k4 = dt*f(r + ( b41*k1 + b42*k2 + b43*k3          ),t + a4*dt)
     k5 = dt*f(r + ( b51*k1 + b52*k2 + b53*k3 + b54*k4 ),t + a5*dt)
     k6 = dt*f(r + ( b61*k1 + b62*k2 + b63*k3 + b64*k4 + b65*k5 ),t+dt)
     k7 = dt*f(r + ( b71*k1 + b73*k3 + b74*k4 + b75*k5 + b76*k6 ),t+dt)

     ytemp = ( d1*k1 + d3*k3 + d4*k4 + d5*k5 + d6*k6 +d7*k7) !rk5
     errores = dt*abs( e1*k1 + e3*k3 + e4*k4 + e5*k5 + e6*k6 + e7*k7 ) ! rk5-rk4

    end subroutine dopri
!**********************************************************************
    subroutine adaptativo(r,t,dt,dt_next,tmp)
    real(qp), intent(in) :: r(N_equ) ! Valores
    real(qp), intent(in) :: t    ! Paso
    real(qp), intent(inout) :: dt   ! Tamano de paso
    real(qp), intent(out) :: dt_next
    real(qp), intent(out) :: tmp(N_equ)
    real(qp), parameter :: safety = 0.9_qp
    real(qp), parameter :: e_con = 1.89e-4_qp
    real(qp), parameter :: eps = 1.e-9_qp
    real(qp), parameter :: PGROW = -0.2_qp
    real(qp), parameter :: PSHRNK = -0.25_qp
    real(qp) :: errores(N_equ), ytemp(N_equ), yscal(N_equ)
    real(qp) :: dt_temp, t_new, e_max

        do
            call dopri(r,t,dt,errores,ytemp)
            yscal = r+dt*f(r, t)+tinny
            e_max  = maxval(abs(errores/yscal))/eps
            if ( e_max .gt. 1._qp ) then
                dt_temp=safety*dt*(e_max**PSHRNK)
                dt=sign(max(abs(dt_temp),0.1_qp*abs(dt)),dt)
                t_new=t+dt
                if (t_new .eq. t) then
                    PRINT*,'Paso demasiado pequeño en t=', t
                    !dt=0.001_qp
                    stop
                endif
            else
                tmp=ytemp
                exit
            endif
        enddo

        if (e_max .gt. e_con) then
            dt_next=safety*dt*(e_max**PGROW)
        else
            dt_next=2.0_qp*dt
        endif

    end subroutine adaptativo
!**********************************************************************
end program gompertz
