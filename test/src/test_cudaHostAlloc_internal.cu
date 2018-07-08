#include <stdio.h>
#define DSIZE (4*1024*1024)

int main(){

  int *data;
  cudaFree(0);
  system("cat /proc/meminfo > out1.txt");
  printf("*$*before alloc\n");
  cudaHostAlloc(&data, DSIZE, cudaHostAllocDefault);
  printf("*$*after alloc\n");
  system("cat /proc/meminfo > out2.txt");
  cudaFreeHost(data);
  system("cat /proc/meminfo > out3.txt");
  printf("OK");
  return 0;
}
