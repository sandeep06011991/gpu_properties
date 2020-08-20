## Parallelism

From the specs we have around 3000 cores and 28 SM. Each SM has 128 cores and
concurrently execute 4 warps.

Kernels are launched with a parallel threads, organized as a 2D grid of threads per block
and blocks.
Threads and blocks are themselves organized as grids from 1D to 3D.
A set 32 continuous threads belonging to a block constitute a warp.
A warp is executed using SIMT on the multiple cores.
All the warps belonging to the same block execute on the same SM.
Each SM has multiple warps belonging to multiple blocks concurrently executing.


1. Launcing too few thread blocks leads to low SM utilization.
The kernel was launched with 1 thread per block.

    ThreadBlocks | sm_effeciency
    1            | .91 %
    1000         | 27 %

2. Launcing too few threads per block leads to low warp utiliztion.

    Threads per Block | Warp_Execution_Effeciency
    1      | 3.12 %
    128    | 100 %

For more details on achieved occupancy
https://docs.nvidia.com/gameworks/content/developertools/desktop/analysis/report/cudaexperiments/kernellevel/achievedoccupancy.htm
The above experiments are examples of bad occupancy.
Other limitations include warps/SM, blocks/SM and Shared Memory/SM