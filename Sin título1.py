# -*- coding: utf-8 -*-
"""
Created on Tue Feb  4 12:35:43 2020

@author: Publico
"""

import numpy as np
import scipy.optimize
import matplotlib.pylab as plt

data = np.loadtxt('VacioC1.txt',delimiter=';')
data2 = np.loadtxt('VacioC2copy.txt',delimiter=';')
data3 = np.loadtxt('Vacioconnitrogeno.txt',delimiter=';')
#data4 = np.loadtxt('VacioC1.txt',delimiter=';',skiprows=0)

T1 = data[:,3]
T2 = data2[:,3]
T3 = data3[:,3]

tiempo1 = data[:,1]
tiempo2 = data2[:,1]
tiempo3 = data3[:,1]

Presion1 = data[:,2]
Presion2 = data2[:,2]
Presion3 = data3[:,2]

plt.plot(tiempo1,T1,'r.')
plt.plot(tiempo1,Presion1,'b.')
plt.show()