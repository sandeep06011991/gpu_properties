
# from model import AlexNetModel


import numpy as np
import matplotlib.pyplot as plt
import numpy as np
from preprocessor import BatchPreprocessor

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
    for i in a.keys():
        print(i)
    print(len(a["labels"]))
    print((a["data"]).shape)

if __name__=="__main__":
    print("hello world")
    from finetune import main
    import tensorflow as tf
    tf.app.run()
    # bp  = BatchPreprocessor("../cifar-10-batches-py/",10, output_size=[227, 227],
    #                         horizontal_flip=False, shuffle=False,
    #              mean_color=[132.2766, 139.6506, 146.9702], multi_scale=None)
    # bp.next_batch(128)
    pass