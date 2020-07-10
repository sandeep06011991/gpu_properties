
cifar10:
	wget https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz
	tar -zxvf cifar-10-python.tar.gz
	mv cifar-10-python/cifar-10-batches-py/ .
	rm cifar-10-python

cifar100:
	wget https://www.cs.toronto.edu/~kriz/cifar-100-python.tar.gz
	tar -zxvf cifar-100-python.tar.gz
	mv cifar-100-python/cifar-100-batches-py/ .
	rm cifar-100-python

