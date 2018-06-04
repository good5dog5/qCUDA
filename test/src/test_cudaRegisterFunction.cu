#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <cuda_runtime.h>
#include <driver_types.h>

#define N 100

__global__ void saxpy(int n, float a, float *x, float *y)
{
  int i = blockIdx.x*blockDim.x + threadIdx.x;
  if (i < n) y[i] = a*x[i] + y[i];
}
void dump(float * result)
{
    printf("Result is\n");
    for(int i=0; i<N; i++)
        printf("%f ", result[i]);
    printf("\n");
}

void valid(float *result)
{
    for(int i=0; i<N; i++)
        if (result[i] != 20.0) {
            printf("Failed\n");
            return;
        }
    printf("cudaRegisterFunction PASSED\n");
}
int main(void)
{
    float *x, *y;
    float *x_gpu, *y_gpu;

    x = (float*)malloc(N * sizeof(float));
    y = (float*)malloc(N * sizeof(float));

    cudaMalloc(&x_gpu, N * sizeof(float));
    cudaMalloc(&y_gpu, N * sizeof(float));

    for(int i=0; i<N; i++) {
        x[i] = 5.0;
        y[i] = 10.0;
    }

    cudaMemcpy(x_gpu, x, N * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(y_gpu, y, N * sizeof(float), cudaMemcpyHostToDevice);


    saxpy<<<1024,256>>>(N, 2.0, x_gpu, y_gpu);

    cudaMemcpy(x, x_gpu, N * sizeof(float), cudaMemcpyDeviceToHost);
    cudaMemcpy(y, y_gpu, N * sizeof(float), cudaMemcpyDeviceToHost);
    /* dump(y); */
    valid(y);

    free(x);
    free(y);
    cudaFree(x_gpu);
    cudaFree(y_gpu);


}
