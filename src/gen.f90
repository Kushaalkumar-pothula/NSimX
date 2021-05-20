program gen
    use nsimx
    implicit none
    !---Declarations---------------------------------------------------------------
    real, allocatable :: ones(:)
    real, allocatable :: mass(:)
    real, allocatable :: pos(:,:)
    real, allocatable :: vel(:,:)
    real, allocatable :: acc(:,:)

    integer :: count, nF

    real :: s, t, tEnd, dt

    integer :: N, seed, Nt, i

    N = 100     ! 100 particles
    t = 0   ! Current tme of simulation
    tEnd = 10.0    ! Time at which simulation ends
    dt = 0.1    ! Timestep
    s = 0.1     ! Softening


    count = 0
    nF = 10
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
    
    !------------------------------------------------------------------------------
    
    data_out: do while (count <= nF)
        !---Main simulation loop-------------------------------------------------------
        simulation: do i = 1, Nt
        
            vel = vel + ((acc*(dt/2.0)))  ! 1/2 Kick

            pos = pos + (vel*dt)    ! Drift
            
            call acceleration(pos,mass,s, acc)  
            
            vel = vel + (acc*(dt/2.0))  ! 1/2 Kick

            t = t + dt  ! Update time
            
        end do simulation
        !------------------------------------------------------------------------------
        count = count + 1
        call savedata(pos, count)
    end do data_out




end program gen
