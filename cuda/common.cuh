//
// Created by sandeep on 19/8/20.
//
#include "cuda.h"
#include <chrono>
#include<iostream>
#include "assert.h"

using namespace std;

#ifndef GPU_PROPERTIES_COMMON_H
#define GPU_PROPERTIES_COMMON_H

void check_error(cudaError_t e){
    assert(e == cudaSuccess);

}

#endif //GPU_PROPERTIES_COMMON_H
