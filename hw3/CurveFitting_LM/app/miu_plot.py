import matplotlib.pyplot as plt
import numpy as np

lambdas = np.loadtxt("out_lambda.txt")
print(lambdas)

plt.figure()
plt.plot(lambdas,'r')
plt.title(r'$\mu$')
plt.show()