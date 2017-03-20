import tensorflow as tf

def adapate_data(data):
    output = []
    for i in data:
        i.insert(0, 1)
        output.append(i)
    return output

def linear_regression(x, y, learn_rate=0.03, convergence=1e-4):
    # extend a value like x_0 = 1
    x = adapate_data(x)
    # weight count
    weight_count = len(x[0])
    w = tf.Variable([.0 for i in range(weight_count)], dtype = tf.float32)

    # store continuous value
    x_holder = tf.placeholder(tf.float32)
    y_holder = tf.placeholder(tf.float32)

    # get sum in accordance with axis 1
    y_sum = tf.reduce_sum(w * x_holder, 1)
    loss = tf.reduce_sum(tf.square(y_sum - y_holder))

    # choose gradient descent mathod to minimize ths cost
    optimizer = tf.train.GradientDescentOptimizer(learn_rate)
    train = optimizer.minimize(loss)

    # init all global variables
    init = tf.global_variables_initializer()

    # create a seesion
    session = tf.Session()
    session.run(init)

    weight = None
    min_loss = 0
    interation = 0
    while True:
        session.run(train, {x_holder: x, y_holder: y})
        min_loss = session.run(loss, {x_holder: x, y_holder: y})
        interation += 1
        print("epoch: ", interation, ", loss: ", min_loss)
        if (min_loss <= convergence):
            weight = session.run(w, {x_holder: x, y_holder: y})
            break

    session.close()
    return weight, min_loss

if __name__ == '__main__':
    # suppose its equation as y = 1 + 2*x_1 + x_2
    x = [[0,0],[1,5],[2,1]]
    y = [1,8,6]
    learn_rate = 0.03
    convergence = 1e-5
    
    print(linear_regression(x, y, learn_rate=learn_rate, convergence=convergence))