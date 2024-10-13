from scipy.optimize import fsolve
import math
import numpy as np
from scipy.optimize import curve_fit #serve per il fit
from scipy.misc import derivative  #serve per la derivata
import time
import serial
from pynverse import inversefunc
import socket
import constant
HOST = '127.0.0.1'                 # Symbolic name meaning all available interfaces
PORT = 50007

## FUNCTIONS


def funzione(x, a, b, c, d):
    return a*np.exp(b*x) + c*np.exp(d*x)


def f(x, p1, p2, p3, p4):
    return p1 * np.exp(p2 * x) + p3 * np.exp(p4 * x)


def func(u, init, fin):
    return [der_in - u[0] * u[1] * math.exp(2.2 * u[1]) - u[2] * u[3] * math.exp(2.2 * u[3]),
            init - u[0] * math.exp(u[1] * 2.2) - u[2] * math.exp(u[3] * 2.2),
            fin - u[0] * math.exp(u[1] * 15.0) - u[2] * math.exp(u[3] * 15.0),
            der_end - u[0] * u[1] * math.exp(15.0 * u[1]) - u[3] * u[2] * math.exp(15.0 * u[3])]


def calibration():
    conn.sendall((str(-1) + '\n').encode())  # dico a processing che sto facendo la prima calibrazione

    # sample the initial and final values to calibrate
    while not arduino.inWaiting():
        pass
    init = float(arduino.readline())
    print("valore iniziale: ", init)
    time.sleep(0.05)
    while not arduino.inWaiting():
        pass
    fin = float(arduino.readline())
    print("valore finale: ", fin)
    time.sleep(0.05)

    # trovo curva con fsolve
    root = fsolve(func, popt, args=(init, fin))
    calibration_curve = lambda x: root[0] * np.exp(root[1] * x) + root[2] * np.exp(root[3] * x)
    return calibration_curve


def measurement(calibration):
    dist = read
    print("Read voltage: ", dist)
    distance = inversefunc(calibration, y_values=dist)
    if distance > constant.MAX_V:
        distance = np.array(constant.MAX_V)
    #print(type(distance))
    print("distance: ", distance)
    conn.sendall((str(distance) + '\n').encode())
    arduino.write(distance)
    time.sleep(1)

##

## ACTIVATING THE COMUNICATIONS WITH ARDUINO AND PROCESS

arduino = serial.Serial(port='COM8', baudrate = 115200, timeout = .1)
#arduino.close()
time.sleep(2)

s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((HOST, PORT))
s.listen(1)
conn, addr = s.accept()

##

## INITIALIZATIONS

state = constant.CAL

## Measurements for calibration curve

x = np.array(
            [2.2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10, 10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14,
             14.5, 15]
        )
y = np.array(
            [4.73, 4.3, 3.47, 2.98, 2.48, 2.15, 1.86, 1.59, 1.38, 1.18, 1.02, 0.9, 0.79, 0.73, 0.63, 0.54, 0.47, 0.43, 0.38,
             0.34, 0.31, 0.26, 0.22, 0.19, 0.16, 0.14, 0.12]
        )
##


# Here you give the initial parameters for a,b,c which Python then iterates over
# to find the best fit
popt, pcov = curve_fit(funzione, x, y, p0=(2.329, -0.1699, 7.491, -0.2868))
# popt contains your three best fit parameters

p1 = popt[0]  # a
p2 = popt[1]  # b
p3 = popt[2]  # c
p4 = popt[3]  # d
print("a, b, c, d: ", p1,p2,p3,p4)
global der_in, der_end
der_in = derivative(f, x[0], args=(p1, p2, p3, p4))
der_end = derivative(f, x[-1], args=(p1, p2, p3, p4))

##

while True:

    """ CALIBRATION """
    # if i want to calibrate i need to send the value 11.0
    if state == constant.CAL:
        new_calibration = calibration()
        state = constant.MIS

    # see which value arrives from arduino through the serial port
    while not arduino.inWaiting():
        pass
    global read
    read = float(arduino.readline())

    # if the read value is 11.0 = I pushed the button
    if read == constant.CAL:
        state = constant.CAL
        conn.sendall((str(-1)+'\n').encode())
    else:

        """ SAMPLING """
        measurement(new_calibration)