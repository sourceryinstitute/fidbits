#include "cprint.h"
#include <stdio.h>

int print_me(foo_for_c foo_struct){

   for ( int i = 0; i < *foo_struct.array_size-1 ; i++ ){
      printf("array[%d]= %d\n",i,foo_struct.array[i]);
   }

  return 0;
}
