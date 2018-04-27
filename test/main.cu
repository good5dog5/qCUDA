#include <stdio.h>
#include <stdlib.h>
/* #include <criterion/criterion.h> */
#include <driver_types.h>
/* #include <cuda_runtime.h> */
#include "include/test_cuda_api.h"

/* void setup(void) { */
/*     puts("Runs before the test"); */
/* } */
/*  */
/* void teardown(void) { */
/*     puts("Runs after the test"); */
/* } */

__global__ void compute_pixel_value(unsigned char* image, float* pixel_value, float* min_max, int x_size, int y_size)
{
    int idx = blockIdx.x*blockDim.x+threadIdx.x;
    int idy = blockIdx.y*blockDim.y+threadIdx.y;
    //To compute laplacian of a pixel, it need 8 neighbors -> need to check range.
    if( (idx>0 && idx<x_size-1) && (idy > 0 && idy < y_size-1) )
    {
        int index = idx + idy*x_size; // current pixel for this thread
        int i,j; 
        int weight[3][3] = {{ 1, 1, 1 }, { 1, -8, 1 }, { 1, 1, 1 }};
        for (j = - 1; j < 2; j++) 
        {
            for (i = -1; i < 2; i++) 
            {
                int index_t = (idy+j)*x_size + idx + i; 
                pixel_value[index] += weight[j + 1][i + 1] * image[index_t];
            }
        }
        if (pixel_value[index] < min_max[0]) min_max[0] = pixel_value[index]; // min = min_max[0]
        if (pixel_value[index] > min_max[1]) min_max[1] = pixel_value[index];
    }
}

/* Test(simple, test, .init = setup, .fini = teardown) { */
int main(void)
{

    struct cudaFuncAttributes attr;
    /* const char* fname = "compute_pixel_value"; */
    /* int nDevices; */
    /* cudaGetDeviceCount(&nDevices); */
    /* for (int i = 0; i < nDevices; i++) { */
    /*     cudaDeviceProp prop; */
    /*     cudaGetDeviceProperties(&prop, i); */
    /*     printf("Device Number: %d\n", i); */
    /*     printf("  Device name: %s\n", prop.name); */
    /*     printf("  Memory Clock Rate (KHz): %d\n", */
    /*             prop.memoryClockRate); */
    /*     printf("  Memory Bus Width (bits): %d\n", */
    /*             prop.memoryBusWidth); */
    /*     printf("  Peak Memory Bandwidth (GB/s): %f\n\n", */
    /*             2.0*prop.memoryClockRate*(prop.memoryBusWidth/8)/1.0e6); */
    /* } */

    memset(&attr, 0, sizeof(struct cudaFuncAttributes));
    cudaFuncGetAttributes(&attr, (void*)compute_pixel_value);
    /* dump_cudaFuncAttributes(attr); */

    printf("binaryVersion: %d\n", attr.binaryVersion);
    printf("cacheModeCA: %d\n", attr.cacheModeCA);
    printf("constSizeBytes: %lu\n", attr.constSizeBytes);
    return 0;

    /* cr_assert(attr.binaryVersion >= 32760); */
    /* cr_assert(attr.cacheModeCA == 0); */
    /* cr_assert(attr.constSizeBytes == 0); */
}
