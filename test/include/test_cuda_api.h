#include<stdio.h>
#include<stdlib.h>
#include <driver_types.h>

// __global__ void compute_pixel_value(unsigned char* image, float* pixel_value, float* min_max, int x_size, int y_size);
void dump_cudaFuncAttributes(struct cudaFuncAttributes);
