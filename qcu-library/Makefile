
CUDA_INC=/usr/local/cuda/include
CUDA_LIB=/usr/local/cuda-8.0/lib64

LIB=libcudart
CUDA_VER=8.0

.PHONY: install clean remove

all: lib

libcudart_dl:
	gcc -c -Wall -Werror -fpic -I$(CUDA_INC) $(LIB).c
	gcc -shared -o libcudart.so $(LIB).o -lcuda -ldl

libcudart:
	gcc -c -Wall -Werror -fpic -I$(CUDA_INC) $(LIB).c
	gcc -shared -o libcudart.so $(LIB).o

lib: $(LIB)

install: libcudart
	sudo cp libcudart.so /usr/local/lib/                                                                                          
	sudo ln -sf libcudart.so /usr/local/lib/libcudart.so.8.0
	sudo rm -f /etc/ld.so.conf.d/cuda-8-0.conf                                                                                    
	sudo ldconfig 

clean:
	rm -f *.so *.o 

remove:
	sudo rm -f /usr/local/lib/libcudart.so /usr/local/lib/libcudart.so.$(CUDA_VER)
	sudo su -c "echo "/usr/local/cuda/lib64" > /etc/ld.so.conf.d/cuda-8-0.conf"
	sudo ldconfig

#/usr/local/cuda/bin/nvcc --cudart=shared $(USR).c
