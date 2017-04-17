import numpy as np
import tensorflow as tf

def add_layer(inputs, input_size, output_size, activation_func=None):
    weights = tf.Variable(tf.random_normal([input_size, output_size]), dtype=tf.float32)
    biases = tf.Variable(tf.zeros([1, output_size]) + 0.1)
    linear = tf.matmul(inputs, weights) + biases
    if activation_func==None:
        return linear
    else:
        return activation_func(linear) # return tf.nn.relu(linear)

def neural_network(x_data, y_data, learn_rate, convergence=1e-4):
    #x_data = tf.Variable(x_data, dtype=tf.float32)
    #y_data = tf.Variable(y_data, dtype=tf.float32)

    # node to hold data
    x_placeholder = tf.placeholder(dtype=tf.float32, shape=[None,1])    
    y_placeholder = tf.placeholder(dtype=tf.float32, shape=[None,1])
    
    # hidden layer
    hidden_layer = add_layer(x_placeholder, 1, 10, activation_func=tf.nn.relu)
    # output layer
    output_layer = add_layer(hidden_layer, 10, 1)
    
    loss = tf.reduce_mean(tf.reduce_sum(tf.square(y_placeholder - output_layer), reduction_indices=[1]))
    
    train = tf.train.GradientDescentOptimizer(learn_rate).minimize(loss)
    
    # initialize all variables
    init = tf.global_variables_initializer()
    
    with tf.Session() as session:
        session.run(init)
    
        epoch = 0
        while(True):
            session.run(train, feed_dict={x_placeholder: x_data, y_placeholder:y_data})
            min_loss = session.run(loss, feed_dict={x_placeholder:x_data, y_placeholder:y_data})
            if (min_loss <= convergence):
                print(min_loss)
                break
            epoch += 1
            print("epoch: ", epoch, "loss: ", min_loss)

if __name__ == "__main__":
    x_data = np.linspace(-1, 1, 300)[:, np.newaxis]
    noise = np.random.normal(0.0, 0.05, x_data.shape)
    y_data = np.square(x_data) - 0.5 + noise
    
    precision = neural_network(x_data, y_data, 0.03)
    print(precision)