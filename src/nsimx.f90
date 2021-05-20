module nsimx
    !====================================================================!
    !                         The NSimX Engine                           !
    !                         ----------------                           !
    !            The core module of NSimX N-body simulator               !
    ! Contains:                                                          !
    ! --------                                                           !
    !    - Subroutine : Acceleration                                     !
    !                   Computes acceleration based on Newtonian physics !
    !    - Subroutine : Savedata                                         !
    !                   Outputs "snapshots" of positions                 !
    !                                                                    !
    !====================================================================!

    implicit none

    ! Set public as default
    public


contains

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


subroutine savedata(pos_in,n)
    !====================================================================!
    !                   Returns a snapshot of positions                  !
    !                   -------------------------------                  !
    ! Inputs:                                                            !
    ! ------                                                             !
    !   - n : Snapshot number                                            !
    !   - pos_in: N x 3 array of positions at n                          !
    ! Output:                                                            !
    ! ------                                                             !
    !   - A text file containing a snapshot of positions at n            !
    !                                                                    !
    !====================================================================!

    implicit none
    integer, intent(in) :: n
    real, allocatable, intent(in) :: pos_in(:,:)
    integer :: a
    character(len=100) :: file_name
    character(len=100) :: file_id

    ! Write the integer n into a string
    write(file_id, '(i0.3)') n

    ! Construct the filename
    file_name = 'snapshot' // trim(adjustl(file_id)) // '.txt'

    ! Open the file the filename
    open(file = trim(file_name), unit = n)
    do a = 1, ubound(pos_in, 1)
        write(n,*) pos_in(a,:)
    end do

end subroutine savedata

end module nsimx
