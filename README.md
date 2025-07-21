
# Booth Multiplier (Verilog Implementation)

This project presents a Verilog implementation of the **Booth's Multiplication Algorithm**, which is an efficient algorithm for multiplying binary integers in 2's complement representation. The design uses a modular approach and simulates a 16-bit × 16-bit signed multiplication resulting in a 32-bit product.

---

## 📘 Booth's Algorithm Overview

Booth’s algorithm reduces the number of arithmetic operations in a multiplication process by encoding the multiplier based on pairs of bits (Q0 and Q-1). The key idea is:

- `00` or `11`: No arithmetic operation, just shift.
- `01`: Add multiplicand to accumulator.
- `10`: Subtract multiplicand from accumulator.

Each cycle involves checking the last bit of Q and the Q[-1] flip-flop (qm1), performing a conditional operation, and then an arithmetic right shift.

---

## 🧠 Top Module: `BOOTH`

### 📥 Inputs:
- `ldA`, `ldQ`, `ldM`: Load enable signals for Accumulator (A), Multiplier (Q), and Multiplicand (M).
- `clrA`, `clrQ`, `clrff`: Clear signals for A, Q, and Q[-1].
- `sftA`, `sftQ`: Shift enable for A and Q.
- `addsub`: Controls the ALU operation (1 for subtract, 0 for add).
- `decr`, `ldcnt`: Control signals for the 5-bit cycle counter.
- `clk`: Clock signal.
- `data_in [15:0]`: Input data to load into Q or M.

### 📤 Outputs:
- `qm1`: Flip-flop holding Q[-1].
- `eqz`: Counter terminal count output (high when count = 0).
- `product [31:0]`: Final 32-bit product from concatenation of A and Q.

---

## 🧩 Submodules Used

| Module    | Description |
|-----------|-------------|
| `shiftreg` | 16-bit shift register with load, clear, and shift functionalities. Used for A and Q. |
| `PIPO`     | 16-bit Parallel-In Parallel-Out register for storing the multiplicand (M). |
| `dff`      | D flip-flop used to store Q[-1] (qm1) for Booth logic. |
| `ALU`      | Performs `A + M` or `A - M` operation based on the `addsub` control signal. |
| `counter`  | 5-bit down counter used to control the number of iterations (up to 16 for 16-bit multiplication). |

---

## 🔄 How Execution Works

1. **Initialization:**
   - Load the multiplier (`Q`) and multiplicand (`M`) using `data_in`.
   - Clear registers `A`, `Q`, and `qm1` (Q[-1]).

2. **Each Cycle:**
   - Based on `Q[0]` and `qm1`, decide to add/subtract using the ALU.
   - Store result back into accumulator `A`.
   - Perform arithmetic right shift on `{A, Q, qm1}`.
   - Decrement the cycle counter.

3. **Final Output:**
   - Once the counter reaches zero (`eqz` high), output the product as `{A, Q}`.

---
📈 Future Improvements
Add signed/unsigned mode switch.

Support for larger bit-widths (32x32 multiplication).

Integrate FSM to fully automate Booth steps.

