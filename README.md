# 5-Stage Pipeline Implementation

A project that demonstrates the design and simulation of a 5-stage pipelined processor using VHDL. The implementation is verified through Quartus for synthesis and ModelSim for simulation, showcasing the concepts of instruction-level parallelism in computer architecture.

## Features
- Implements a 5-stage pipelined processor architecture:
  - **Fetch**: Instruction retrieval from memory.
  - **Decode**: Instruction decoding and register read.
  - **Execute**: Arithmetic or logical operations execution.
  - **Memory Access**: Reading or writing data to memory.
  - **Write Back**: Writing results back to the register file.
- Handles data hazards and control hazards with techniques such as forwarding and pipeline stalling.
- Simulates the pipeline functionality using ModelSim.
- Synthesizes the design for FPGA implementation using Quartus.
- Provides a modular and scalable VHDL design for educational and research purposes.

## Main Technologies Used
- **VHDL**: For designing the pipeline architecture.
- **Quartus**: For synthesis and FPGA implementation.
- **ModelSim**: For simulating and verifying the design.
