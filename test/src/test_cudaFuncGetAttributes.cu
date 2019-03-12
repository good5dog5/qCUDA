#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <driver_types.h>
#include <criterion/criterion.h>

__constant__ float pool[100];

__global__ void saxpy(int n, float a, float *x, float *y)
{
  int i = blockIdx.x*blockDim.x + threadIdx.x;
  if (i < n) y[i] = a*x[i] + y[i]+pool[i/100];
}

void dump_cudaFuncAttributes(struct cudaFuncAttributes attr)
{
    printf("binaryVersion: %d\n", attr.binaryVersion);
    printf("cacheModeCA: %d\n", attr.cacheModeCA);
    printf("constSizeBytes: %lu\n", attr.constSizeBytes);
    printf("localSizeBytes: %lu\n", attr.localSizeBytes);
    printf("maxThreadPerBlock: %d\n", attr.maxThreadsPerBlock);
    printf("numRegs: %d\n", attr.numRegs);
    printf("sharedSizeBytes: %lu\n", attr.sharedSizeBytes);
}
int main(void)
{


    struct cudaFuncAttributes attr;

    // for constSizeBytest (cuda const memory)
    float host[100];
    cudaMemset (host,0,sizeof(float)*100);
    /* cudaMemcpyToSymbol(pool,  host,   sizeof(float)*100  ); */

    cudaFuncGetAttributes(&attr, saxpy);
    dump_cudaFuncAttributes(attr);
    /* assert(attr.binaryVersion == 21); */
    /* assert(attr.cacheModeCA == 0); */
    /* assert(attr.constSizeBytes == 400); */

}
