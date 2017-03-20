import numpy as np
import tensorflow as tf

def adapate_data(data):
    output = []
    for i in data:
        i.insert(0, 1)
        output.append(i)
    return output

x_data = [[0,0],[1,5],[2,1]]
x_data = adapate_data(x_data)
y_data = [1,6,8]

x_ph = tf.placeholder(tf.float32)
y_ph = tf.placeholder(tf.float32)

w = tf.Variable([0 for i in range(len(x_data[0]))], dtype=tf.float32)
s = tf.reduce_sum(tf.square(w*x_ph - y_ph))

optimazer = tf.train.GradientDescentOptimizer(0.03)
train = optimazer.minimize(s)


#c = tf.multiply(w,b)
#c = tf.reduce_sum(w*b)


session = tf.Session()

init = tf.global_variables_initializer()
session.run(init)

for i in range(1000):
    session.run(train, {x_ph: x_data, y_ph: y_data})
    r,e = session.run([w, s], {x_ph: x_data, y_ph: y_data})
    print(r, e)

session.close()