
## Memory Host to Device

1. Using pinned memory, the time to transfer from host to device.

    | 128MB  | 10ms
    | 256MB  | 21ms
    | 512MB  | 43ms
    | 1GB    | 86ms
    | 2GB    | 173ms

The bandwidth we can calculate to be around 11 GB/s which is matched by our device specs.

2. Using virtual memory, the time to transfer for varying sizes of memory is as follows.
The bandwith we calculate is around 3 GB/s. However we have all the advantages of using
virtual memory, otherwise we would be limited by our RAM.

    64MB  | 20ms
    128MB | 40ms
    256MB | 81ms
    512MB | 166ms
    1GB   | 328ms
    2GB   | 659ms

