
#include "common.cuh"



__global__ void timetakingfunction(int *a){
    int s = 0;
    for(int i=0;i<1000;i++){
        s=s*19;
    }
    a[threadIdx.x] = s;
}

/* Code framework to test different kinds of kernel launches
 * with varying grid sizes threads and blocks. */
int main(){
    int *a;
    check_error(cudaMalloc(&a, 10000000 * sizeof(int)));
    for(int i=1;i<10;i=i+10){
        auto start_time = std::chrono::high_resolution_clock::now();
        timetakingfunction<<<100,128>>>(a);
        check_error( cudaPeekAtLastError() );
        cudaDeviceSynchronize();
        auto end_time = std::chrono::high_resolution_clock::now();
        cout << "Thread " << i <<  ":" << (end_time - start_time)/std::chrono::microseconds(1) <<"ms \n";
    }

}