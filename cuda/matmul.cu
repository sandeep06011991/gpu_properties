#include<iostream>
#include "cuda.h"
#include "assert.h"
#include <chrono>

#define N (1<<11)

void local_execute(int *c, int *local_a, int *local_b){
    for(int i=0;i<N;i++){
        for(int j=0;j<N;j++){
            int s =0;
            for(int k=0;k<N;k++){
                c[i*N+j] = s  + local_a[i*N + k]*local_b[j + k*N];
            }
        }
    }
}
//
//int verify(int *c){
//    int error = 0;
//    for(int i=0;i<size;i++){
//        error = error + abs(4-c[i]);
//    }
//    return error;
//}
//
void check_error(cudaError_t e){
    assert(e == cudaSuccess);

}
//
__global__ void matmul_gpu(int *a,int *b,int *c){
    int i = blockIdx.x;
    for(int j=0;j<N;j++){
        int s =0;
        for(int k=0;k<N;k++){
            c[i*N+j] = s  + a[i*N + k]*b[j + k*N];
        }
    }
}
//
void gpu_execute(int *local_a, int* local_b, int *local_c){
    int *a,*b,*c;
    check_error(cudaMalloc(&a, N * N * sizeof(int)));
    check_error(cudaMalloc(&b, N * N * sizeof(int)));
    check_error(cudaMalloc(&c, N * N * sizeof(int)));
    check_error(cudaMemcpy(a,local_a,N * N * sizeof(int),cudaMemcpyHostToDevice));
    check_error(cudaMemcpy(b,local_b,N * N * sizeof(int),cudaMemcpyHostToDevice));
    matmul_gpu<<<N,1>>>(a,b,c);
    check_error(cudaMemcpy(local_c,c,N * N * sizeof(int),cudaMemcpyDeviceToHost));
    cudaDeviceSynchronize();
    cudaFree(a);
    cudaFree(b);
    cudaFree(c);

}
/*
 * Current Speed UP:
 * GPU Run time 3904ms
 * Local run time 80398ms
*/
int main(){

    int * local_a = (int *)malloc(sizeof(int) * N * N);
    int * local_b = (int *)malloc(sizeof(int) * N * N);
    int * c = (int *)malloc(sizeof(int) * N * N);

    for(int i=0;i<N;i++){
        local_a[i]= 1;
        local_b[i]= 1;
    }
    std::cout << "Matrix Size" << ((N * N * 4)/(1<<20))  <<"MB\n";
    auto start_time = std::chrono::high_resolution_clock::now();
    gpu_execute(c,local_a,local_b);
    auto end_time = std::chrono::high_resolution_clock::now();
    std::cout << "GPU Run time " << (end_time - start_time)/std::chrono::milliseconds(1) <<"ms \n";
    start_time = std::chrono::high_resolution_clock::now();
    local_execute(c,local_a,local_b);
    end_time = std::chrono::high_resolution_clock::now();
    std::cout << "Local run time " << (end_time - start_time)/std::chrono::milliseconds(1) <<"ms \n";
    free(local_a);
    free(local_b);
    free(c);
    //    gpu_execute(local_a,local_b,c);
//    std::cout << "Max Error" << verify(c) <<"\n";
}
