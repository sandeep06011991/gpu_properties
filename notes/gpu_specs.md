## GPU Specification

The following experiments are done on Nvidia
GeForce GTX 1080Ti with the following specifications.

(extracted using nvidia-smi -q)
[Reference document: https://developer.download.nvidia.com/compute/DCGM/docs/nvidia-smi-367.38.pdf]

1. Cuda 10.2
2. 11.1 GB on device memory.
3. PCIe link generation 3 and lane width 16x for data transfer between host and device,
 and a theoretical bandwidth of 16GB/sec. As per the specification page of Nvidia,
 GPU has a bandwidth of 11 GB/s.
6. Have a clock speed of 265MHz and Memory 5508 MHz. To get this in perspective, cpu have a clock speed 10 times
    higher clockspeed and has 10 times slower spped. However the memory clock speed is in the same range of DRAM clockspeed.
7. 3584 Cude Cores and 28 SMs with warp size of 32.


https://docs.nvidia.com/gameworks/content/developertools/desktop/analysis/report/cudaexperiments/kernellevel/achievedoccupancy.htm