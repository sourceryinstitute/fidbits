// author: Izaak "Zaak" Beekman
// date: 2017-09-29
// display: true
// graph: true
//
// Golbal constant array of chemical species names and accessor function,
// `SpeciesName`

/**
 *   \file str_array.c
 *   \brief A C file defining a global array of strings and an accessor method
 *
 *  Define a global array of strings and an accessor method, for testing
 *  Fortran string interoperability
 *
 */

#include <string.h>
#include <stddef.h>

#include "str_array.h"

/**
 * A global immutable array of strings representing a set of chemical species
 */
char const * const SPECIES[7] = {
// A global immutable array of strings representing a set of chemical species
  "N",
  "N2",
  "NO",
  "NO2",
  "O",
  "O2",
  "O3"
};

/**
 *  \brief Return char string corresponding to index idx
 *
 *  Return char string for species corresponding to index idx
 *
 *  \param[in] idx Index of species string to return
 *  \return return type
 */
char const * SpeciesName(size_t const idx)
// Accessor function to return species name at index `idx`
{
    return SPECIES[idx];
}
