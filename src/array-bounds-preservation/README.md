fidbits
=======

The [source code] in this directory produces a Markdown-formatted
[table] documenting some scenarios in which Fortran array bounds
are and are not preserved.  Fortran features for which
bounds-preservation is reported as false are scenarios in which
the resulting array has all dimensions with a lower bounds of 1
independent of the how the array is formed.  This code and table
address scenarios of interest in writing one application ([Morfeus]).
If you would like to add other table entries, please feel free to
submit a pull request with updated code.

[Hyperlinks]:#
[Morfeus]: https://www.sourceryinstitute.org/sourceryinstitute/MORFEUS-Source
[source code]: ./bounds.f90
[table]: ./bounds.md
