! This file defines a macro that can be used to deactivate
! compiler warnings about unused dummy arguments.
!
! Unused local variables can (should) be handled by eliminating the variable.
! But for dummy arguments, eliminating the dummy argument may induce undesirable
! changes in the client code, or in the case of an inheritance hierarchy, it
! may be fundamental that come arguments are unused by some subclasses.
!
! The trick is to have a macro that "uses" the variable in a way that the optimizer
! will trivially eliminate.   The hard part is making that something that will work 
! with arguments of any kind, type, and rank.
!
! With the exception of assumed-size arrays, all dummy arguments have a SHAPE, which
! is what is used below.   Note that this not work with assumed-size arrays, but this
! case shouldbe vanishingly rare and treated by other means.  (Elimination, or reference to 
! first element, etc.)
!
!
! Usage:
!
!      subroutine foo(x, unused, b, c)
!        ... 
!        _UNUSED_DUMMY(unused)
!        ...


#ifdef _UNUSED_DUMMY
#  undef _UNUSED_DUMMY
#endif
#define _UNUSED_DUMMY(x) if (.false.) print*,shape(x)
