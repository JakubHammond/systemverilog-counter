# SystemVerilog Counter

A beginner digital design project: a configurable-width counter with synchronous reset and enable, plus a self-checking testbench for Icarus Verilog.

## Behavior

On each rising clock edge:

- If `rst` is high, reset `count` to zero.
- Otherwise, if `en` is high, increment `count`.
- Otherwise, hold the current value.

The default `WIDTH` is 4 bits, so the counter wraps from 15 to 0. `WIDTH` must be at least 1. Reset is synchronous and active-high, and takes priority over enable. Apply reset before relying on the count value.

## Files

```text
rtl/counter.sv       Counter design
tb/counter_tb.sv     Self-checking testbench
```

## Run with Icarus Verilog

With Icarus Verilog installed, run from the repository root:

```bash
mkdir -p build
iverilog -g2012 -s counter_tb -o build/counter_sim rtl/counter.sv tb/counter_tb.sv
vvp build/counter_sim
```

A successful run prints:

```text
PASS: reset, counting, wraparound, hold, reset priority, and recovery
```

The simulation also creates `counter.vcd`, which can be opened in a VCD waveform viewer. Generated files are ignored by Git.

## What the Testbench Checks

The testbench uses the default 4-bit configuration and checks reset, every count from 1 through 15, wraparound, holding while disabled, reset priority over enable, and counting after reset is released.

Inputs change on falling clock edges. Checks run 1 ns after rising edges so the counter's nonblocking assignments have completed. Case inequality (`!==`) ensures unknown values also cause a failure.

## Learning Goals

- Describe registers with `always_ff` and nonblocking assignments.
- Understand synchronous reset, enable, and finite-width arithmetic.
- Generate a clock and drive inputs in a testbench.
- Check expected results automatically with tasks and `$fatal`.
