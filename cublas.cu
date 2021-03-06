
# include <cuda_runtime.h>
# include "cublas_v2.h"
#include <iostream>
#define M (1<<11)
#define N (1<<11)
#define IDX2F(i,j,ld) ((((j)-1)*(ld))+((i)-1))
using namespace std;

int main(){

	cudaError_t cudaStat;
	cublasStatus_t stat;    
	cublasHandle_t handle;
	cudaEvent_t start, stop;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);
	int i, j;
	float* devPtrA;
	float* devPtrC;
	float* a = 0;    
	float * res;
	a = (float *)malloc (M * N * sizeof (*a));
	res = (float *)malloc(M * N * sizeof(*a));
	if (!a) {
		printf ("host memory allocation failed");
		return EXIT_FAILURE;   
       	}
	for (j = 1; j <= N; j++) {
		for (i = 1; i <= M; i++) {
	    		a[IDX2F(i,j,M)] = (float)(3);
		}
    	}   
       	cudaStat = cudaMalloc ((void**)&devPtrA, M*N*sizeof(*a));
	cudaStat = cudaMalloc((void **)&devPtrC, M*N*sizeof(float));
	if (cudaStat != cudaSuccess) {
		printf ("device memory allocation failed");
		return EXIT_FAILURE;   
       	}   
       	stat = cublasCreate(&handle);
	if (stat != CUBLAS_STATUS_SUCCESS) {
		printf ("CUBLAS initialization failed\n");
		return EXIT_FAILURE;   
       	}    
	cudaEventRecord(start);
	stat = cublasSetMatrix (M, N, sizeof(*a), a, M, devPtrA, M);
	if (stat != CUBLAS_STATUS_SUCCESS) {
		printf ("data download failed");
		cudaFree (devPtrA);
		cublasDestroy(handle);
		return EXIT_FAILURE;
    	}
        
	const float alpha = 1.0f;
	const float beta = 0.0f;
	stat =  cublasSgemm(handle,
		CUBLAS_OP_N, CUBLAS_OP_N, 
		M , N, N,
		&alpha, 
		devPtrA, M,
		devPtrA, N,
		&beta,
		devPtrC, M);

	if (stat != CUBLAS_STATUS_SUCCESS){
		printf("mat mul fialed\n");
	}

	stat = cublasGetMatrix( M, N, sizeof(float), devPtrC, M, res, M);

	cudaEventRecord(stop);
	cudaEventSynchronize(stop);
	float milliseconds = 0;
	cudaEventElapsedTime(&milliseconds, start, stop);

//	Same Matrix too 23ms .
	cout << "Total time" << milliseconds <<"ms \n";
//	for(int j=1;j <=N; j++){
//		for(int i=1;i<=M;i++){
//			cout << res[IDX2F(i,j,M)] <<" ";
//		}
//		cout <<"\n";
//	}

}
