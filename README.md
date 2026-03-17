# Parameterizable Synchronous FIFO (Verilog)

## Overview

This project is a simple implementation of a **synchronous FIFO (First-In First-Out)** using Verilog.
The main goal was to understand how data is stored and retrieved in order, and how hardware handles buffering using pointers and memory.

I also focused on verifying the design properly using simulation in Xilinx Vivado, instead of just writing the code.

---

## Features

* Parameterizable **data width** and **depth**
* Separate **write** and **read** enable signals
* **Full** and **Empty** flag generation
* Circular buffer implementation using pointers
* Occupancy tracking using a counter
* Simulation and waveform verification in Vivado

---

## Design Explanation

The FIFO uses a memory array to store data. Two pointers are used:

* `wr_ptr` → points to the next location to write
* `rd_ptr` → points to the next location to read

A counter (`count`) is used to track how many elements are present in the FIFO.

* When writing:

  * Data is stored at `wr_ptr`
  * Pointer increments
  * Count increases

* When reading:

  * Data is taken from `rd_ptr`
  * Pointer increments
  * Count decreases

The FIFO behaves like a **circular buffer**, so when the pointer reaches the end, it wraps back to zero.

---

## Full and Empty Conditions

* **Empty** → when `count == 0`
* **Full** → when `count == DEPTH`

These conditions help prevent invalid operations like:

* Writing when FIFO is full
* Reading when FIFO is empty

---

## Simulation

The design was tested using a Verilog testbench in Vivado.

The testbench includes:

* Clock generation
* Reset sequence
* Write operations
* Read operations
* Filling the FIFO completely
* Emptying the FIFO

---

## Waveform Analysis

During simulation, I observed:

* Correct data order (FIFO behavior)
* Proper increment of `wr_ptr` and `rd_ptr`
* Correct update of `count`
* Full flag asserted at maximum capacity
* Empty flag asserted when all data is read

Internal signals like pointers and count were also monitored to understand the working clearly.

---

## Tools Used

* Verilog HDL
* Xilinx Vivado (for simulation and waveform analysis)

---

## What I Learned

* How FIFO works internally using memory and pointers
* Difference between write and read control logic
* Importance of simulation and waveform debugging
* How to verify edge cases like full and empty conditions

---

## Future Improvements

* Implement FIFO without counter (using pointer comparison)
* Add almost full / almost empty signals
* Convert to asynchronous FIFO (different read/write clocks)
* Add self-checking testbench

---

## Conclusion

This project helped me understand how data buffering works in hardware systems.
I focused not only on writing the design but also on verifying it properly through simulation, which gave me better clarity on how FIFO operates internally.
