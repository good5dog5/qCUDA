#include <stdio.h>

int main(){

  int value = 5201314;
  int *ptr1 = &value;
  int **ptr2 = &ptr1;
  /* cudaHostRegister(ptr2, sizeof(int *), 0); */
  printf("ptr1's address is %p\n", (void*) ptr1);
  cudaHostAlloc(ptr2, sizeof(int *), 0);
  return 0;
}
