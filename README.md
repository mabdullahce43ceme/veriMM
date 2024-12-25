# veriMM
a Verilog Matrix Multiplier implementation designed for Nexys3 FPGA. This includes designing the following main modules,
* **UART** __ which sends and receives data at a baud rate of 9600
* **MAC** __ which multiplies the operand with its value and accumulates the results
* **Memory** __ to store input and output values
* **Controller** __ to control all the top-level tasks

Other modules are also designed to support the operations as well. However, their function is visible only on lower levels of abstraction.

## Design
<img src="trivia/dfd.png" align="left" width="50%">
The above image shows a DFD of the system on Level Zero. The levels beneath have more modules hidden here. The arrowheads show the direction of the flow of data.

## Implementation
The implementation **“veriMM”** is designed for **8-bit unsigned integers**. It supports the multiplication of square matrices of sizes up to **15x15**. On the computer side, a Python3 program is made to perform communication properly.
The entire system is **decomposed into modules** which perform a single task and can easily be represented easily in the form of an **FSM**.
