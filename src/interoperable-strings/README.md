## Cast an element from an array (ragged?) of C `char`s as a Fortran scalar `character`

An example of some code that can cast an element from a C array of
`char` strings as a Fortran `character` scalar of length \(>=
1\). This code was adapted from a posting by [@IanHarvey] at
<https://software.intel.com/en-us/forums/intel-visual-fortran-compiler-for-windows/topic/392505.>

The key insight is that a character dummy argument, `foo`, may be
declared with a `len=<lenght>` parameter such that `<length>` *
`size(foo)` = the `size()` of the `character(len=1)` actual
argument. To simply swap an array of `character(len=1)` into a scalar
pass the `size()` of the actual argument as an argument to the
subroutine, and then the `intent(in)` dummy argument will have the
`target` attribute and be a rank 1 array with extents `[1]`. The
`intent(out)` variable will be `character(len=:), pointer` and pointer
assignment is used to persist the dummy argument recasting/reshaping
once the scope of the procedure is left. See the functions in
`c_f_string.f90`.

[FORD] generated documentation can be viewed at
<https://sourceryinstitute.github.io/fidbits/src/interoperable-strings/doc/index.html>

Correct output looks like:

```
./example
SpeciesName_C(1): N
SpeciesName_C(1): N
SpeciesName_C(2): N2
SpeciesName_C(2): N2
SpeciesName_C(3): NO
SpeciesName_C(3): NO
SpeciesName_C(4): NO2
SpeciesName_C(4): NO2
SpeciesName_C(5): O
SpeciesName_C(5): O
SpeciesName_C(6): O2
SpeciesName_C(6): O2
SpeciesName_C(7): O3
SpeciesName_C(7): O3
```

[fidbits]: https://github.com/sourceryinstitute/fidbits
[@IanHarvey]: https://github.com/IanHarvey
[FORD]: https://github.com/cmacmackin/ford
