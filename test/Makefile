EXEC ?= @echo "[@]"
INCLUDES  := -I$(CUDA_HOME)/samples/common/inc

ARCH= -gencode arch=compute_62,code=sm_62 

HOST_COMPILER ?= g++
NVCC          := $(CUDA_HOME)/bin/nvcc -ccbin $(HOST_COMPILER)
NVCCFLAGS     := -m64   --cudart=shared $(ARCH)

.PHONY: clean

EXE = cudaGetDeviceCount \
	cudaHostAlloc \
	cudaHostAlloc_adv \
	cudaHostAlloc_internal \
	cudaPointerTest \
	cudaHostRegister \
	cudaRegisterFunction \
	vectorAdd \
	bandwidthTest \
	matrixMul \
	cdpSimpleQuicksort \
	cudaZeroCopy \
	clock 


EXES := $(addprefix exe/, $(EXE))
	
all: $(EXE)

exe:
	mkdir -p $@

cudaGetDeviceCount: src/test_cudaGetDeviceCount.cu exe
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

cudaHostAlloc: src/test_cudaHostAlloc.cu exe
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

cudaHostAlloc_adv: src/test_cudaHostAlloc_adv.cu exe
	$(NVCC) $(INCLUDES)  $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

cudaHostAlloc_internal: src/test_cudaHostAlloc_internal.cu exe
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

cudaPointerTest: src/test_cudaPointerTest.cu exe
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

malloc: src/malloc.cu exe
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

cudaHostRegister: src/test_cudaHostRegister.cu exe
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

vectorAdd: src/vectorAdd.cu exe
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

bandwidthTest: src/bandwidthTest.cu exe
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

matrixMul: src/matrixMul.cu exe
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

cudaZeroCopy: src/test_cudaZeroCopy.cu exe
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

cudaRegisterFunction: src/test_cudaRegisterFunction.cu exe
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) $(GENCODE_FLAGS)  $< -o exe/$@

cdpSimpleQuicksort: src/cdpSimpleQuicksort.cu exe
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) -dc $(GENCODE_FLAGS) -o cdpSimpleQuicksort.o -c $<
	$(NVCC) $(NVCCFLAGS) $(GENCODE_FLAGS) -o exe/$@ cdpSimpleQuicksort.o

clock: src/clock.cu exe
	$(NVCC) $(INCLUDES) $(NVCCFLAGS) -dc $(GENCODE_FLAGS) -o clock.o -c $<
	$(NVCC) $(NVCCFLAGS) $(GENCODE_FLAGS) -o exe/$@ clock.o

clean:
	@rm -f  $(EXES) 

