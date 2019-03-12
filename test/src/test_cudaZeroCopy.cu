#include<stdio.h>
#include<cuda.h>


__global__ void kernel(float* output, float* input)
{

}


int main() {

    int size = 10;

    // Set flag to enable zero copy access
    cudaSetDeviceFlags(cudaDeviceMapHost);
 
    // Host Arrays
    float* h_in  = NULL;
    float* h_out = NULL;
    
    h_in  = (float *) malloc(size*sizeof(float));
    h_out = (float *) malloc(size*sizeof(float));

    // Device arrays
    float *d_out, *d_in;
    // Get device pointer from host memory. No allocation or memcpy
    cudaHostGetDevicePointer((void **)&d_in,  (void *) h_in , 0);
    cudaHostGetDevicePointer((void **)&d_out, (void *) h_out, 0);
 
    // Launch the GPU kernel
    kernel<<<1, 1>>>(d_out, d_in);
 
    // No need to copy d_out back
    // Continue processing on host using h_out
    return 0;
}
