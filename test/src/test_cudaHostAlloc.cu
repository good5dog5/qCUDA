#include <stdio.h>
#include <cuda_runtime.h>                                                                                                         

// includes                                                                                                                       
#include <helper_functions.h>  // helper for shared functions common to CUDA Samples                                              
#include <helper_cuda.h>       // helper functions for CUDA error checking and initialization                                     

#include <cuda.h>    

int main()
{
    unsigned long long * p = NULL;
    unsigned long long cb = 5368;
    /* cudaError_t rval; */
    /* rval = cudaHostAlloc( &p, cb, cudaHostAllocPortable | cudaHostAllocMapped ); */
    /* cudaError_t rval = cudaHostAlloc( &p, cb, cudaHostAllocWriteCombined); */
    /* printf( "cudaHostAlloc( ..., %llu, ... ) returns %d\n", cb, rval ); */
    printf("cudaHostAllocPortable is %d cudaHostAllocMapped is %d\n", cudaHostAllocPortable, cudaHostAllocMapped);
    checkCudaErrors(cudaHostAlloc(&p, cb, cudaHostAllocPortable | cudaHostAllocMapped));

    /* cb = 309811; */
    /* rval = cudaHostAlloc( &p, cb, cudaHostAllocPortable | cudaHostAllocMapped ); */
    /* printf( "cudaHostAlloc( ..., %llu, ... ) returns %d\n", cb, rval ); */
    /* checkCudaErrors(cudaHostAlloc( &p, cb, cudaHostAllocPortable | cudaHostAllocMapped )); */
}
