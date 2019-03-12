#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <driver_types.h>
#include <criterion/criterion.h>

__constant__ float constPool[100];
__global__ void saxpy(int n, float a, float *x, float *y)
{
  static a[10] = {0};
  int i = blockIdx.x*blockDim.x + threadIdx.x;
  if (i < n) y[i] = a*x[i] + y[i] + constPool[i/100];
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

    int size=200;
    float darray[200];

    memset(darray, 0, sizeof(float)*200);
    cudaMemcpyToSymbol(constPool,  darray,   sizeof(float)*100);

    cudaFuncGetAttributes(&attr, saxpy);
    dump_cudaFuncAttributes(attr);

    /* assert(attr.binaryVersion >= 32760); */
    /* assert(attr.cacheModeCA >= 0); */
    /* assert(attr.constSizeBytes >= 0); */

}
