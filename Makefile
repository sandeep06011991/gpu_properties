
global_memory_htd:
	nvcc -I cuda/ cuda/global_memory_bandwidth.cu  && ./a.out

matmul:
	nvcc -I cuda/ cuda/matmul.cu  && ./a.out

parallelism:
	nvcc -I cuda/ cuda/parallel.cu && ./a.out