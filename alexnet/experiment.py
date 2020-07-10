'''
1. Load pretrained weights for ALEXNET on cifar.
2. Experiment1.
    Measure inference.
        Mesure latency with variable batch size
        variable batch size.
        Preprocessing
        Inference
        max throughput
'''
from model import AlexNetModel
from preprocessor import BatchPreprocessor
import tensorflow as tf
import time
"""
For a single model. 
BatchSize | PreprocessingTimePerBatch | ComputeTimePerBatch | TotalTimePerBatch 
"""
def experiment1(sess,x,y):
    MAX_BATCH_SIZE = 1000
    batch_size=128
    bp  = BatchPreprocessor("../cifar-10-batches-py/",10, output_size=[227, 227],
                            horizontal_flip=False, shuffle=False,
                 mean_color=[132.2766, 139.6506, 146.9702], multi_scale=None)
    # x = tf.placeholder(tf.float32, [None, 227, 227, 3])
    # y = tf.placeholder(tf.float32, [None, 10])


    fp = open("exp1",'a')
    fp.write("BatchSize | PreprocessingTimePerBatch | \
             ComputeTimePerBatch | TotalTimePerBatch\n ")
    while(batch_size<MAX_BATCH_SIZE):
        a = time.time()
        batch_tx,batch_ty = bp.next_batch(batch_size)
        b = time.time()
        preprocessing_time = b-a
        a = time.time()
        sess.run(y,feed_dict = {x: batch_tx})
        b = time.time()
        compute_time = b-a
        fp.write("{} | {} | {} | {} \n".format(batch_size,preprocessing_time,
                                               compute_time, preprocessing_time+compute_time))
        batch_size = batch_size *2
        # if batch_size > len(bp.labels):
        #     break
        # if bp.pointer + batch_size > len(bp.labels):
        #     bp.reset_pointer()
    fp.close()


"""
For a single model multi-model inference 
BatchSize | PreprocessingTimePerBatch | ComputeTimePerBatch | TotalTimePerBatch 
"""
def multi_model_setup():
    model_10 = AlexNetModel(num_classes=10, dropout_keep_prob=0.5)
    x = tf.placeholder(tf.float32, [None, 227, 227, 3])
    y = model_10.inference(x)
    model_100 = AlexNetModel(num_classes=100, dropout_keep_prob=0.5)
    sess = tf.Session()
    sess.run(tf.global_variables_initializer())
    saver = tf.train.import_meta_graph("../training/alexnet_20200709_040258/checkpoint/model_epoch1.ckpt.meta")
    saver.restore(sess, "../training/alexnet_20200709_040258/checkpoint/model_epoch1.ckpt")
    bp  = BatchPreprocessor("../cifar-10-batches-py/",10, output_size=[227, 227],
                            horizontal_flip=False, shuffle=False,
                            mean_color=[132.2766, 139.6506, 146.9702], multi_scale=None)

    # experiment1(sess,x,y)
    pass

def model_setup():
    model_10 = AlexNetModel(num_classes=10, dropout_keep_prob=0.5)
    x = tf.placeholder(tf.float32, [None, 227, 227, 3])
    y = model_10.inference(x)
    sess = tf.Session()
    sess.run(tf.global_variables_initializer())
    saver = tf.train.import_meta_graph("../training/alexnet_20200709_040258/checkpoint/model_epoch1.ckpt.meta")
    saver.restore(sess, "../training/alexnet_20200709_040258/checkpoint/model_epoch1.ckpt")
    experiment1(sess,x,y)

if __name__ == "__main__":
    # model_setup()
    multi_model_setup()