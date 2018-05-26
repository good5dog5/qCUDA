#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <driver_types.h>
#include <criterion/criterion.h>


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
__constant__ float cangle[360];

__global__ void test_kernel(float* darray)
{
    int index;

    //calculate each thread global index
    index = blockIdx.x * blockDim.x + threadIdx.x;

#pragma unroll 10
    for(int loop=0;loop<360;loop++)
        darray[index]= darray [index] + cangle [loop] ;
    return;

}


int main(int argc,char** argv)
{
    int size=3200;
    float* darray;
    float hangle[360];

    //allocate device memory
    cudaMalloc ((void**)&darray,sizeof(float)*size);

    //initialize allocated memory
    cudaMemset (darray,0,sizeof(float)*size);

    //initialize angle array on host
    for(int loop=0;loop<360;loop++)
        hangle[loop] = acos( -1.0f )* loop/ 180.0f;

    //copy host angle data to constant memory
    cudaMemcpyToSymbol    (  cangle,  hangle,   sizeof(float)*360  );

    /* test_kernel  <<<  size/64  ,64  >>>  (darray); */

    struct cudaFuncAttributes attr;
    cudaFuncGetAttributes(&attr, test_kernel);
    dump_cudaFuncAttributes(attr);

    //free device memory
    cudaFree(darray);
    return 0;
}


