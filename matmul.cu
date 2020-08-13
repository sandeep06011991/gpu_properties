#include<iostream>
#include "cuda.h"
#include "assert.h"

#define N (1<<15)

void local_execute(int *c, int *local_a, int *local_b){
    for(int i=0;i<size;i++){
        int s =0;
        for(int j=0;j<size;j++){
            c[i] = local_a[i] + local_b[i];
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
//void check_error(cudaError_t e){
//    assert(e == cudaSuccess);
//
//}
//
//__global__ void add(int *a,int *b,int *c){
//    int x = blockIdx.x;
//    c[x] = a[x] + b[x];
//}
//
//void gpu_execute(int *local_a, int* local_b, int *local_c){
//    int *a,*b,*c;
//    check_error(cudaMalloc(&a, size *sizeof(int)));
//    check_error(cudaMalloc(&b, size *sizeof(int)));
//    check_error(cudaMalloc(&c, size *sizeof(int)));
//    check_error(cudaMemcpy(a,local_a,size * sizeof(int),cudaMemcpyHostToDevice));
//    check_error(cudaMemcpy(b,local_b,size * sizeof(int),cudaMemcpyHostToDevice));
//    add<<<size,1>>>(a,b,c);
//    check_error(cudaMemcpy(local_c,c,size * sizeof(int),cudaMemcpyDeviceToHost));
//    cudaDeviceSynchronize();
//    cudaFree(a);
//    cudaFree(b);
//    cudaFree(c);
//
//}

int main(){

    int * local_a = (int *)malloc(sizeof(int) * N * N);
    int * local_b = (int *)malloc(sizeof(int) * N * N);
    int * c = (int *)malloc(sizeof(int) * N * N);

    for(int i=0;i<N;i++){
        local_a[i]= 1;
        local_b[i]= 1;
    }

    local_execute(c,local_a,local_b);
//    gpu_execute(local_a,local_b,c);
//    std::cout << "Max Error" << verify(c) <<"\n";
}
