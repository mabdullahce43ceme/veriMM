import serial
import time

def send_matrix(ser, matrix):
    """Send a 3x3 matrix via serial."""
    for row in matrix:
        for element in row:
            ser.write(bytes([element]))
            time.sleep(0.001)  # Small delay for reliable transmission

def receive_matrix(ser):
    """Receive a 3x3 matrix via serial."""
    matrix = []
    for i in range(3):  # 3 rows
        row = []
        for j in range(3):  # 3 columns
            data = ser.read(1)  # Read 1 byte
            row.append(int.from_bytes(data, byteorder='big'))
        matrix.append(row)
    return matrix

# Define the matrices
A = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]
B = [
    [9, 8, 7],
    [6, 5, 4],
    [3, 2, 1]
]

# Serial port configuration
serial_port = "/dev/cu.usbmodem14201"  # Change to your serial port

try:
    # Open the serial port
    with serial.Serial(serial_port, 9600, bytesize=8, parity='N', stopbits=1) as ser:
        print("Serial port opened:", ser.name)

        # Send matrix A
        print("Sending matrix A...")
        send_matrix(ser, A)

        # Send matrix B
        print("Sending matrix B...")
        send_matrix(ser, B)

        # Receive matrix C
        print("Waiting for matrix C...")
        C = receive_matrix(ser)

        # Print the received matrix
        print("Matrix C (Result):")
        for row in C:
            print(row)

except serial.SerialException as e:
    print("Error:", e)
