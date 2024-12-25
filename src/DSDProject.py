import serial
import random
import time

#FSM Rules
#Sending 4 means display Matrix A values
#Sending 8 means display Matrix B values
#Sending 16 as input means that the FPGA should start receiving length of Matrix A and its values
#Sending 32 as input means that the FPGA should start receiving length of Matrix B and its values
#Sending 64 means activate the MAC.
#Sending 128 means send the results back.

arr1 = [10]
arr2 = [10]
for i in range(100):
	arr1.append(random.randint(1,9))
	arr2.append(random.randint(1,9))


for i in range(10):
	print(arr1[i*10:(i+1)*10])

print("\n")
for i in range(10):
	print(arr2[i*10:(i+1)*10])

ser = serial.Serial('COM3', 9600)
ser.write([16])
ser.write(arr1)
ser.write([32])
ser.write(arr2)

ser.write([64]) #Calculating MAC results
ser.write([128])
#ser.write([16, 3, 1, 2, 3, 4, 5, 6, 7, 8, 9])
#ser.write([32, 3, 1, 2, 3, 4, 5, 6, 7, 8, 9])
#ser.write([64])
#ser.write([128])

a = []
while True:
	line = ser.read()
	for item in line:
		a.append(item)

	if (len(a) > 9):
		print(a)
		a = []

#for item in line:
	#print(int(item))
	#value = ser.readLine()
	#valueInString = str(value, 'UTF-8')
	#print(valueInString)