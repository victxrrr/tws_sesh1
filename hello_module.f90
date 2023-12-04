module FirstExercise
  implicit none

  save 

  integer :: i
  integer :: j

contains
  subroutine HelloWorld

    print *, 'wat is jouw nummer, makker ?'
    read *, i

    if (i < 0) then
      print *, 'negative nummer!!'
      elseif (i > 10) then
      print *, 'te groot nummer!!'
    else
      do j = 1, i
        print *, 'Hello, world!'
      enddo
    endif
  end subroutine
end module