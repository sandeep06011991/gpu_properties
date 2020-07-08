
# from model import AlexNetModel


import numpy as np
import matplotlib.pyplot as plt
import numpy as np

# Access CIFAR10 data
def unpickle(file):
    import pickle
    with open(file, 'rb') as fo:
        dict = pickle.load(fo, encoding='latin1')
    return dict

# datadict = unpickle(cifar_data_batch_1_file)
def view_image(datadict):
    X = datadict["data"]
    Y = datadict["labels"]
    X = X.reshape(10000, 3, 32, 32).transpose(0,2,3,1).astype("uint8")
    Y = np.array(Y)
    fig, axes1 = plt.subplots(5,5,figsize=(3,3))
    for j in range(5):
        for k in range(5):
            i = np.random.choice(range(len(X)))
            axes1[j][k].set_axis_off()
            axes1[j][k].imshow(X[i:i+1][0])
    plt.show()

def train():
    a = unpickle("../cifar-10-batches-py/data_batch_1")


if __name__== "__main__":
    print("hello world")
    train()
    pass