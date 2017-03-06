import numpy as np
import tensorflow as tf
import copy

def adapate_data(data):
    output = []
    for i in data:
        i.insert(0, 1)
        output.append(i)
    return output

def linear_regression(x, y, learn_rate=0.03, convergence=1e-4):
    # give a any value as a outset
    x = adapate_data(x)

    size = len(x[0])
    X = []
    for i in range(len(y)):
        X.append(tf.Variable([x[i]], dtype=tf.float32))

    Y = tf.Variable([y], dtype=tf.float32)

    w = tf.Variable([[.0 for i in range(size)]], dtype = tf.float32)
    w = tf.transpose(w)

    # store continuous value
    x_holder = tf.placeholder(tf.float32)
    y_holder = tf.placeholder(tf.float32)

    loop = len(y)
    sum = tf.Variable(0, tf.float32)
    for i in range(loop):
        linear = tf.matmul(w, X[i])
        print(linear, Y[i])
        sum += tf.square(linear - Y[i])

    loss = tf.reduce_sum(0.5*sum)

    optimizer = tf.train.GradientDescentOptimizer(learn_rate)
    train = optimizer.minimize(loss)

    # init all global variables
    init = tf.global_variables_initializer()

    # create a seesion
    session = tf.Session()
    session.run(init)

    result_w = None
    min_loss = 0
    while True:
        session.run(train, {x_holder: x, y_holder: y})
        result_w, min_loss = session.run([w, loss], {x_holder: x, y_holder: y})
        # min_loss = session.run(loss, {x_holder: x, y_holder: y})
        # print(min_loss)
        if (min_loss <= convergence):
            break

    session.close()
    return result_w, min_loss

if __name__ == '__main__':
    a = [[1,1],[2,3]]
    b = [3,7]
    print(linear_regression(a,b,0.01))