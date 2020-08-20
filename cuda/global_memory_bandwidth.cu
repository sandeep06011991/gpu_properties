
#include "common.cuh"




void pinnedTransfer(size_t N){
    int * local_a;
    check_error(cudaHostAlloc(&local_a,sizeof(int) * N, cudaHostAllocDefault));
    int * a;
    check_error(cudaMalloc(&a, N * sizeof(int)));
    auto start_time = std::chrono::high_resolution_clock::now();
    check_error(cudaMemcpy(a,local_a,N *  sizeof(int),cudaMemcpyHostToDevice));
    cudaDeviceSynchronize();
    auto end_time = std::chrono::high_resolution_clock::now();
    std::cout << (end_time - start_time)/std::chrono::milliseconds(1) <<"ms \n";
    cudaFree(a);
    cudaFreeHost(local_a);
}

void transfer(size_t N){
    int * local_a =(int *)malloc(sizeof(int) * N);
    int * a;
    check_error(cudaMalloc(&a, N * sizeof(int)));
    auto start_time = std::chrono::high_resolution_clock::now();
    check_error(cudaMemcpy(a,local_a,N *  sizeof(int),cudaMemcpyHostToDevice));
    cudaDeviceSynchronize();
    auto end_time = std::chrono::high_resolution_clock::now();
    std::cout << (end_time - start_time)/std::chrono::milliseconds(1) <<"ms \n";
    cudaFree(a);
    free(local_a);
}

int main(){
    for(int i=15;i<30;i++){
//      bytes
        size_t bytes = (1<<i) * sizeof(int);
//        cout << bytes << " " << (bytes/(1<<10)) << " ";
        if(bytes <1024){
            cout << bytes <<"bytes ";
        }
        if((bytes >= 1024) && (bytes < 1024*1024)){
            cout << (bytes / (1<<10))<<"KB ";
        }
        if((bytes < (1<<30)) && (bytes>=(1<<20))){
            cout << bytes / (1<<20)<<"MB ";
        }
        if(bytes >= (1<<30)){
            cout << bytes / (1<<30) << "GB ";
        }
        cout <<" | ";
        transfer(1<<i);
//        pinnedTransfer(1<<i);
    }
}