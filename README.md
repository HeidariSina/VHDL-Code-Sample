# VHDL Code Sample

[![License](https://img.shields.io/github/license/HeidariSina/VHDL-Code-Sample)](LICENSE)
[![Issues](https://img.shields.io/github/issues/HeidariSina/VHDL-Code-Sample)](https://github.com/HeidariSina/VHDL-Code-Sample/issues)
[![Forks](https://img.shields.io/github/forks/HeidariSina/VHDL-Code-Sample)](https://github.com/HeidariSina/VHDL-Code-Sample/network/members)
[![Stars](https://img.shields.io/github/stars/HeidariSina/VHDL-Code-Sample)](https://github.com/HeidariSina/VHDL-Code-Sample/stargazers)

## Overview

This repository contains a collection of VHDL code samples showcasing various digital logic designs. It includes more advanced algorithms and components, such as a **CORDIC function** for efficient trigonometric calculations, a **basic CPU design**, and a **square root calculation** module.

These VHDL code examples are intended to provide practical insights into digital design, making it useful for both educational and practical FPGA/ASIC projects.

## Contents

- **Basic Logic Gates**: Implementations of AND, OR, NOT, XOR gates using VHDL.
- **Multiplexers**: Examples of 2-to-1, 4-to-1, and 8-to-1 multiplexer designs.
- **Flip-Flops**: D-Flip-Flop, SR-Flip-Flop, JK-Flip-Flop, and T-Flip-Flop implementations.
- **Counters**: Simple up/down counters and ring counters.
- **CORDIC Function**: Efficient algorithm for trigonometric, hyperbolic, and square root calculations.
- **Basic CPU**: A simple VHDL-based CPU design capable of executing basic instructions.
- **Square Root Calculation**: Module to compute square roots using iterative methods in VHDL.
- **Finite State Machines (FSM)**: Mealy and Moore machines with example designs.

## Key Features

- **CORDIC Algorithm**: This module is an efficient algorithm for computing trigonometric functions such as sine, cosine, and hyperbolic functions, as well as calculating square roots. It is hardware-friendly and commonly used in FPGA designs for real-time signal processing.
  
- **Basic CPU Design**: A simple processor design including an ALU (Arithmetic Logic Unit), register file, and control logic to execute basic operations. The CPU is suitable for small projects or educational purposes in digital design courses.

- **Square Root Module**: The square root function is implemented using an iterative approach. This is a critical algorithm for hardware applications where floating-point operations are expensive or unavailable.

## Prerequisites

To work with the VHDL code samples in this repository, you will need:

- A VHDL simulator such as ModelSim, GHDL, or Xilinx Vivado.
- FPGA development tools if you plan to synthesize and test the designs on hardware (e.g., Xilinx Vivado or Quartus).
- Familiarity with VHDL syntax and concepts, such as entities, architectures, signals, and processes.

## Setup

To start using the VHDL code samples:

1. Download or clone this repository.
2. Open the relevant VHDL files in a VHDL editor or simulation tool like ModelSim, GHDL, or any other VHDL-supporting tool.
3. Compile and simulate the VHDL code to verify the functionality of the designs.
4. Test and experiment with the provided test benches to simulate various components (like the CORDIC algorithm, CPU, and square root module).

## Usage

### CORDIC Function
The **CORDIC (COordinate Rotation DIgital Computer)** algorithm can be used for various mathematical operations, such as calculating sine, cosine, and square roots. The VHDL implementation of CORDIC in this repository can be synthesized for FPGA or ASIC platforms. Example use cases include real-time signal processing and vector rotations.

### Basic CPU
The **basic CPU** module simulates a simple processor capable of executing basic instructions. It includes:
- An **ALU** (Arithmetic Logic Unit) for basic arithmetic operations.
- A **register file** to store temporary data.
- **Control logic** for instruction execution.

This CPU can be a starting point for building more complex processors or understanding the fundamental design of microprocessors.

### Square Root Module
The **square root** module provides an iterative method for computing square roots, suitable for hardware where floating-point operations are costly or unavailable. The design can be simulated or synthesized for FPGA applications requiring precise square root calculations.

## Contributing

Contributions are always welcome! To contribute to this repository:

1. Fork the repository.
2. Make your changes (e.g., add new VHDL modules, optimize existing designs).
3. Submit a pull request explaining your changes and improvements.

Please ensure the following before submitting:
- Your code is well-documented with comments explaining key sections.
- You've tested your modifications using VHDL simulators.

## Issues

If you encounter any bugs or issues with the code or have feature requests, please [open an issue](https://github.com/HeidariSina/VHDL-Code-Sample/issues).

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Acknowledgements

Special thanks to everyone who has contributed to the development and maintenance of this project.

---

_If you find this repository helpful, please give it a star!_
