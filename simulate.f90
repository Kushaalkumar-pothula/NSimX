subroutine acceleration(pos, mass, soft, acc)
    !====================================================================!
    !              Calculates accelerations of N particles               !
    !             ------------------------------------------             !
    ! Inputs:                                                            !
    ! ------                                                             !
    !    - pos: N x 3 matrix of positions                                !
    !    - mass: N  1 matrix of masses                                   !
    !    - soft: softening                                               !
    !                                                                    !
    ! Outputs:                                                           !
    ! -------                                                            !
    !    -acc: N x 3 matrix of accelerations                             !
    !                                                                    !
    !====================================================================!
    implicit none
    
    !---Type Declarations-------------------------------------------------
    real, allocatable, intent(in) :: pos(:,:), mass(:)
    real, intent(in) :: soft
    real, allocatable, intent(out) :: acc(:,:)
    integer :: i,j
    real :: dx, dy, dz, inv_r3

    real :: G
    integer :: N
    !--------------------------------------------------------------------

    !---Initialization---------------------------------------------------
    G = 6.673e-11   ! Gravitational Constant
    N = size(pos,1) ! Numer of particles
    allocate(acc(N,3))
    acc(:,:) = 0
    !--------------------------------------------------------------------

    !---Main loop--------------------------------------------------------
    do i = 1,N
        do j = 1, N
            dx = pos(j,1) - pos(i,1)
            dy = pos(j,2) - pos(i,2)
            dz = pos(j,3) - pos(i,3)

            inv_r3 = (dx**2 + dy**2 + dz**2 + soft**2)**(-1.5)

            acc(i,1) = acc(i,1) +  G * (dx * inv_r3) * mass(j)
            acc(i,2) = acc(i,2) +  G * (dy * inv_r3) * mass(j)
            acc(i,3) = acc(i,3) +  G * (dz * inv_r3) * mass(j)
        end do
    end do
    !--------------------------------------------------------------------
    
end subroutine acceleration



program simulate

    implicit none
    
    !---Create interface to subroutine acceleration----------------------
    interface
        subroutine acceleration(pos, mass, soft, acc)
        implicit none
        real, allocatable,intent(in) :: pos(:,:)
        real, allocatable, intent(in) :: mass(:)
        real, intent(in) :: soft
        real, allocatable, intent(out) :: acc(:,:)
        end subroutine acceleration
    end interface
    !--------------------------------------------------------------------

    !---Declarations---------------------------------------------------------------
    real, allocatable :: ones(:)
    real, allocatable :: mass(:)
    real, allocatable :: pos(:,:)
    real, allocatable :: vel(:,:)
    real, allocatable :: pos_save(:,:,:)
    real, allocatable :: acc(:,:)

    real :: s, t, tEnd, dt

    integer :: N, seed, Nt, i, a, b, c

    N = 100     ! 100 particles
    t = 0   ! Current tme of simulation
    tEnd = 10.0    ! Time at which simulation ends
    dt = 0.01    ! Timestep
    s = 0.1     ! Softening
    !------------------------------------------------------------------------------



    !---Initial Conditions---------------------------------------------------------
    seed = 17
    call random_seed(size = seed)    ! Set random generator seed
    
    allocate(ones(N))
    ones(:) = 1
    
    allocate(mass(N))
    mass = (1000.0*ones)/N  ! Combined mass = 1000, i.e each body has a mass of 10
    
    ! Generate random positions
    allocate(pos(N,3))
    call random_number(pos)
    
    ! Generate random velocities
    allocate(vel(N,3))
    call random_number(vel)
    
    ! Calculate acceleration
    allocate(acc(N,3))
    call acceleration(pos, mass, s, acc)
    
    Nt = ceiling(tEnd/dt)   ! Time Step
    
    allocate(pos_save(N,3,Nt+1))
    pos_save(:,:,1) = pos
    !------------------------------------------------------------------------------
    
    
    !---Main simulation loop-------------------------------------------------------
    do i = 1, Nt
    
        vel = vel + ((acc*(dt/2.0)))  ! 1/2 Kick
        pos = pos + (vel*dt)    ! Drift
        
        call acceleration(pos,mass,s, acc)  
        
        vel = vel + (acc*(dt/2.0))  ! 1/2 Kick
        t = t + dt  ! Update time
        
        pos_save(:,:,i+1) = pos    ! Save positions
        
    end do
    !------------------------------------------------------------------------------

    !---Save Output----------------------------------------------------------------

    open(10, file="positions.txt", status="new", action="write")
    do a = 1, ubound(pos, 1)
        write(10,*) pos(a, :)
    end do

    open(12, file="acceleration.txt", status="new", action="write")
    do b = 1, ubound(acc, 1)
        write(12,*) acc(b, :)
    end do

    open(13, file="velocity.txt", status="new", action="write")
    do c = 1, ubound(vel, 1)
        write(13,*) vel(c, :)
    end do
    !------------------------------------------------------------------------------
    
    
end program simulate
