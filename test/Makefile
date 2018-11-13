EXEC ?= @echo "[@]"
INCLUDES  := -I../../../common/inc

HOST_COMPILER ?= g++
NVCC          := $(CUDA_HOME)/bin/nvcc -ccbin $(HOST_COMPILER)
NVCCFLAGS     := -m64  --cudart=shared -arch=compute_30 -code=sm_30

all: cudaGetDeviceCount cudaHostAlloc malloc cudaHostRegister


cudaGetDeviceCount: test_cudaGetDeviceCount.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o $@

cudaHostAlloc: test_cudaHostAlloc.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o $@

malloc: malloc.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o $@

cudaHostRegister: test_cudaHostRegister.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o $@
