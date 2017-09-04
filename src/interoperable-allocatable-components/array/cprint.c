#include "cprint.h"
#include <stdio.h>

int print_all(foo_for_c ** foo_struct_p, int num_objects){

   foo_for_c * foo_struct = *foo_struct_p;

   for ( int j = 0; j < num_objects ; j++ ){
     printf("object %d:\n",j);
     for ( int i = 0; i < *(foo_struct[j].array_size) ; i++ ){
        printf("array[%d]= %d\n",i,foo_struct[j].array[i]);
     }
   }

  return 0;
}
