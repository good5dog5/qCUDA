#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <driver_types.h>
#include <criterion/criterion.h>

__global__
void saxpy(int n, float a, float *x, float *y)
{
  int i = blockIdx.x*blockDim.x + threadIdx.x;
  if (i < n) y[i] = a*x[i] + y[i];
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
void setup(void) {
    puts("Runs before the test");

}

void teardown(void) {
    puts("Runs after the test");
}

/* Test(FuncGetAttribute, first) { */
/*     struct cudaFuncAttributes attr; */
/*     cudaFuncGetAttributes(&attr, saxpy); */
/*     cr_assert(attr.binaryVersion >= 32760); */
/*     cr_assert(attr.cacheModeCA >= 0); */
/*     cr_assert(attr.constSizeBytes >= 0); */
/*      */
/* } */
int main(void)
{

    struct cudaFuncAttributes attr;
    cudaFuncGetAttributes(&attr, saxpy);
    dump_cudaFuncAttributes(attr);
    assert(attr.binaryVersion >= 32760);
    assert(attr.cacheModeCA >= 0);
    assert(attr.constSizeBytes >= 0);

}
