<a name="top"> </a>

[This document uses GitHub-Flavored Markdown.  For better formatting, graphics,]:#
[and hyperlinks, please view this document in a web browser at                 ]:#
[https://github.com/sourceryinstitute/OpenCoarrays/blob/master/README.md       ]:#
<div align="center">

[![Sourcery Institute][sourcery-institute logo]][Sourcery, Inc.]

fidbits
=======
Fortran tidbits: random code snippets produced in conversations that seem worth
preserving for future reference:

</div>

C-Interoperability
------------------
The problem: A question arose how to pass a derived-type variable with allocatable components to C. 

The solution: The proposed solution involves defining a sister derived type

Background:
Although derived types with allocatable components are not themselves interoperable, Note 18.10 in 
the Fortran 2015 standard indicates that the value of a component of type `c_ptr` "can be the C 
address of such an entity."

[Hyperlinks]:#
[C-Interoperability]: #c-interoperability
[sourcery-institute logo]: http://www.sourceryinstitute.org/uploads/4/9/9/6/49967347/sourcery-logo-rgb-hi-rez-1.png
