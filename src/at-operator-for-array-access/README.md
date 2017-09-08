An "at" operator for array access
=================================

It can be useful to have a concise notation for accessing a multidmensional
array by mapping each component of an indicial vector to an index of the
accessed array sequentially. For example, in cloud microphysics, aerosol
particles may serve as nucleation sites for droplet formation and it might
be useful to gather statistics on the relative humidity conditioned on the 
presence of an aerosol particle for purposes of predicting cloud formation.  
For a given particle, we might define an 3D, integer vector `nearest_neighbor`
in which we have stored the indicial values for to the grid cell nearest the
particle.  Then a humidity can be calculated conditioned upon particle 
presence by averaging humidities at locations of the following form:
```fortran
conditional_humidity = relative_humidity( nearest_neighbor(1),nearest_neighbor(2),nearest_neighbor(3) )
```

In Mathematica, a much more compact notation exists for such a purpose:
```Mathematica
conditional_humidity  = relative_humidity  @@ nearest_neighbor 
```
It might be useful to define a derived type whose structure constructor may
be used to wrap the `relative_humidity` object above for the sole purpose of
providing an operator notation similar to the Mathematica style.  For example,
if the derived type is named `field`, then the corresponding Fortran notation
migt becomes something like the following:
```fortran
conditional_humidity  = field(relative_humidity)  .at. nearest_neighbor 
```
which gets us reasonably close to the Mathematica notation at the cost of
having to write a user-defined operator. 

The [at-operator.f90](./at-operator) example in this directory demonstrates
one of the most lightweight scenarios: the case in which the instrinsic 
structure constructor can be used, which might be acceptable if this type
exists only for this purpose.  If the type definition becomes more complicated,
then it might be useful to make its components private to provide greater 
flexibility for modifying the type in the future without impacting client code.
If the components are private, then there is additional coding cost in that
a user-defined structure constructor must be supplied.
