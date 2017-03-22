import tensorflow as tf

def adapate_data(data):
    output = []
    for i in data:
        i.insert(0, 1)
        output.append(i)
    return output

def logistic_regression(x, y, learn_rate=0.01, convergence=1e-4):
    x = adapate_data(x)
    weight_count = len(x)
    
    weight = tf.Variable([0. for i in range(weight_count)], dtype=tf.float32)
    
    x_placeholder = tf.placeholder(tf.float32)    
    y_placeholder = tf.placeholder(tf.float32)

    linear = tf.reduce_sum(weight * x_placeholder, 1)
    sigmoid = tf.nn.softmax(linear)
    
    cost = -(1 / weight_count) * (y_placeholder * (tf.log(sigmoid) + (1 - y_placeholder) * (tf.log(1 - sigmoid))))
    
    optimizer = tf.train.GradientDescentOptimizer(learn_rate)
    train = optimizer.minimize(cost)
    
    init = tf.global_variables_initializer()
    
    with tf.Session() as session:
        session.run(init)
        