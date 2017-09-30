/**
 *   \file str_array.h
 *   \brief A global array of char strings containing species names and an
 *   accessor function
 *
 *  An global, constant array of species names and a function to return them
 *  by index.
 *
 */

#ifndef __STR_ARRAY_H__
#define __STR_ARRAY_H__

/**
 * Global array of species names
 */
extern char const * const SPECIES[7];

/**
 *  \brief Return char string corresponding to index idx
 *
 *  Return char string for species corresponding to index idx
 *
 *  \param[in] idx Index of species string to return
 *  \return return type
 */
char const * SpeciesName(size_t const idx);
#endif
