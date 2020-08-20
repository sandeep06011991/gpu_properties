
#include "common.cuh"



__global__ void timetakingfunction(){
    int s = 0;
    for(int i=0;i<10000000;i++){
        s=s*19;
    }
}


int main(){
//    for(int i=1;i<100000;i=i*10){
//        auto start_time = std::chrono::high_resolution_clock::now();
//        timetakingfunction<<<i,1>>>();
//        cudaDeviceSynchronize();
//        auto end_time = std::chrono::high_resolution_clock::now();
//        cout << "Thread " << i <<  ":" << (end_time - start_time)/std::chrono::microseconds(1) <<"ms \n";
//    }
    for(int i=10;i<100000;i=i*10){
        auto start_time = std::chrono::high_resolution_clock::now();
        timetakingfunction<<<(i/32)+1,5000>>>();
        cudaDeviceSynchronize();
        auto end_time = std::chrono::high_resolution_clock::now();
        cout << "Thread " << i <<  ":" << (end_time - start_time)/std::chrono::microseconds(1) <<"ms \n";
    }
}