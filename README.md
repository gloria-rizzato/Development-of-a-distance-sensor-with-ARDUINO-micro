# Development-of-a-distance-sensor-with-ARDUINO-micro

- **HOUSE STRUCTURE of the sensor**:
  
![housestructure](https://github.com/user-attachments/assets/21674087-e035-481f-aa2c-f8b7d6b7b128)

The structure is capable of varying the distance between the sensor (photodiode) and the input (LED): on one end of a wooden panel the Arduino with the sensor was fixed, feeding the microcontroller through a cable attached to the computer, while the LED was positioned over a cart able to move on the rails present onto the wooden structure. Orange arrow: measured distance.

- **CALIBRATION STATE**:

![calibration curve](https://github.com/user-attachments/assets/9d3bcd92-2fd9-4f53-aa07-b2387310b448)

The calibration state was introduced since the sensor was sentitive to different environmental light conditions. This state is performed every time the sensor is turned on or if the red button is pushed by the user (changes in condition of light). Once the calibration starts, the cart moves and the 2 values (initial_value and final_value) are sampled. Now the calibration curve is computed. 

- **MEASUREMENT STATE**:

![conditioningcircuit](https://github.com/user-attachments/assets/c823741e-40b9-4cd2-ba43-a5c842e7e2fe)

During the measurement state the cart can be manually moved on the rails and the output obtained by the device corresponds to the estimation of the distance measured.
The front-end of the sensor is divided into three different stages: the first one consists of a differential stage which subtracts an offset to the output signal of the sensor with the aim to limit saturation at small distances. For the second stage, an amplifier used as a buffer uncouples the previous and following stages. Finally, the third one consists in an amplification aimed at increasing the sensitivity of the sensor.

- **HARDWARE**:
  
![hardware](https://github.com/user-attachments/assets/1d91bff3-1675-4f22-b519-22c8f680dda1)

- **FIRMWARE**:

![firmware](https://github.com/user-attachments/assets/6b83ded3-2465-496c-b896-37738909b4b5)

- **SOFTWARE**:
The software developed for the project has two main components coded respectively in Python and using the Processing3 environment. The Python code is responsible for handling communication with Arduino and the Processing component, as well as perform necessary calculations unavailable on the microcontroller. The Processing-based software has been built to interact with the user and present a simple interface for the Distance Sensor.

A GUI was also implemented where the user can visualize the 'startig up' and the 'calibration in progess' states. During the measurement phase, the measured distance is displayed.

![startcal](https://github.com/user-attachments/assets/74a3ddc2-c1b3-41c2-9a7e-6d1297fa44dd)

![measure](https://github.com/user-attachments/assets/6a9a37e7-6f90-4e59-9cb6-62544487b640)

---
Contributors: Gloria Rizzato, Giulia Peteani, Francesca Ronchetti, Chiara Quartana, Marco SOave, Martina Greselin, Fosco Cancelliere
