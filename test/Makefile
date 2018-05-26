EXEC ?= @echo "[@]"
INCLUDES  := -I$(CUDA_HOME)/samples/common/inc

ARCH= -gencode arch=compute_62,code=sm_62 

HOST_COMPILER ?= g++
NVCC          := $(CUDA_HOME)/bin/nvcc -ccbin $(HOST_COMPILER)
NVCCFLAGS     := -m64  --cudart=shared $(ARCH)

.PHONY: clean

EXE = cudaGetDeviceCount \
	cudaHostAlloc \
	cudaHostRegister \
	vectorAdd \
	matrixMul 
	
all: $(EXE)


cudaGetDeviceCount: src/test_cudaGetDeviceCount.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o $@

cudaHostAlloc: src/test_cudaHostAlloc.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o $@

malloc: src/malloc.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o $@

cudaHostRegister: src/test_cudaHostRegister.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o $@

vectorAdd: src/vectorAdd.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o $@

matrixMul: src/matrixMul.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o $@

clean:
	@rm -f  $(EXE)

