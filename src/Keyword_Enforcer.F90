! This module facilitates enforcement of a policy whereby 
! optional arguments must be declared with keyword association.
! This is achieved by defining an abstract type, KeywordEnforcer,
! for which there cannot be a concrete subclass.   
! If one then has a dummy argument  declred as
!       class (KeywordEnforcer), optional, intent(in) :: unusable
! then all arguments after "unusable" must be passed with keyword association.
! This is because _no_ actual argument can ever match "unusable".


module KeywordEnforcerMod
   implicit none
   private

   public :: KeywordEnforcer

   type, abstract :: KeywordEnforcer
   contains
      procedure (nonimplementable), deferred, nopass, private :: nonimplementable
   end type KeywordEnforcer

   abstract interface
      subroutine nonimplementable()
      end subroutine nonimplementable
   end interface

end module KeywordEnforcerMod
