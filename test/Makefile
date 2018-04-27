INCLUDE_PATH  := -I $(CUDA_HOME)/samples/common/inc/ \
		 	 -I include/ \
			 -I /usr/local/cuda/include/ \
			 -I ./


CC            := g++ -std=c++11
NVCC          := $(CUDA_HOME)/bin/nvcc  -ccbin $(CC) -m64 -arch=sm_30  
NVCCFLAGS     := -cudart=shared
LDFLAGS       := 


EXECUTABLEs=test_cudaGetDeviceCount\
			test_cudaFuncGetAttributes

SRCs=$(addsuffix .cu, $(EXECUTABLEs))
OBJs=$(addsuffix  .o, $(EXECUTABLEs))
# OBJs += main.o

.PHONY: clean

all: $(EXECUTABLEs)

test_cudaGetDeviceCount: test_cudaGetDeviceCount.cu
	$(NVCC)  $(NVCCFLAGS) -o $@ $<

test_cudaFuncGetAttributes: test_cudaFuncGetAttributes.cu
	$(NVCC)  $(NVCCFLAGS) -lcriterion -o $@ $<

clean:
	@rm  -f $(OBJs) $(EXECUTABLEs)


run: cudaFuncGetAttributes
	@./cudaFuncGetAttributes

# %.o: %.cu 
# 	$(NVCC)  $(NVCCFLAGS) $(INCLUDE_PATH)   -o $@ -c $<

# %.o: %.c 
# 	$(CC) -c -o $@ $(INCLUDE_PATH) $(LDFLAGS)   $<
# test_cudaGetDeviceCount: test_cudaGetDeviceCount.cu
# 	$(NVCC) $(INCLUDE_PATH) $(NVCCFLAGS)  $< -o $@
#
# test_cudaHostAlloc: test_cudaHostAlloc.cu
# 	$(NVCC) $(INCLUDE_PATH) $(NVCCFLAGS)  $< -o $@
#
# test_cudaHostRegister: test_cudaHostRegister.cu
# 	$(NVCC) $(INCLUDE_PATH) $(NVCCFLAGS)   $< -o $@
#
# test_cudaFuncGetAttributes: test_cudaFuncGetAttributes.cu
# 	$(NVCC) $(INCLUDE_PATH) $(NVCCFLAGS)   $< -o $@


# EXECUTABLEs=test_cudaGetDeviceCount\
# 			test_cudaHostAlloc\
# 			test_cudaHostRegister\
# 			test_cudaFuncGetAttributes
#
# SRCS := $(wildcard *.cu)
# EXECUTABLEs := $(basename  $(SRCS))
# OBJs := $(addsuffix  .o, $(EXECUTABLEs))
