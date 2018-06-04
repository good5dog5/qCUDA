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
	matrixMul \
	cdpSimpleQuicksort \
	clock 

EXES := $(addprefix exe/, $(EXE))
	
all: $(EXE)


cudaGetDeviceCount: src/test_cudaGetDeviceCount.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

cudaHostAlloc: src/test_cudaHostAlloc.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

malloc: src/malloc.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

cudaHostRegister: src/test_cudaHostRegister.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

vectorAdd: src/vectorAdd.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

matrixMul: src/matrixMul.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

cudaRegisterFunction: src/test_cudaRegisterFunction.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

cdpSimpleQuicksort: src/cdpSimpleQuicksort.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) -dc $(GENCODE_FLAGS) -o cdpSimpleQuicksort.o -c $<
	$(NVCC) $(NVCCFLAGS) $(GENCODE_FLAGS) -o exe/$@ cdpSimpleQuicksort.o

clock: src/clock.cu
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) -dc $(GENCODE_FLAGS) -o clock.o -c $<
	$(NVCC) $(NVCCFLAGS) $(GENCODE_FLAGS) -o exe/$@ clock.o

clean:
	@rm -f  $(EXES) 

