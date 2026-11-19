# SHA-256 ASIC Implementation Results

## Project Information

- Design: SHA-256 hardware accelerator
- Technology: GPDK045, 45 nm
- Synthesis: Cadence Genus 25.12
- Physical Design: Cadence Innovus 25.12
- Clock period: 6.000 ns
- Target frequency: 166.67 MHz

## Logic Synthesis

| Metric | Value |
|---|---:|
| Synthesized cells | 8,103 |
| Cell area | 32,333.663 um2 |
| Estimated net area | 9,575.386 um2 |
| Genus reported total area | 41,909.049 um2 |

## Physical Implementation

| Metric | Value |
|---|---:|
| Post-route instances | 8,276 |
| Final instance area | 29,890.680 um2 |
| Placement density | 55.42% |
| Hard macros | 0 |
| Clock buffers | 21 |
| Clock sinks | 1,806 |
| Clock tree wire length | 6,847.965 um |
| Reported clock skew | 5 ps |

## Post-Route Timing

| Check | Slack |
|---|---:|
| Setup | +0.043 ns |
| Hold | +0.038 ns |
| Recovery | +3.213 ns |
| Removal | +0.215 ns |

## Physical Verification

| Check | Violations |
|---|---:|
| Innovus DRC | 0 |
| Connectivity | 0 |
| Antenna | 0 |
| Maximum transition | 0 |
| Maximum capacitance | 0 |
| Maximum fanout | 84 |

## Limitations

- Maximum fanout constraint of 32 is not fully satisfied.
- Full independent signoff DRC, LVS, and STA were not performed.
- A complete GDSII deliverable was not generated.
- Results correspond to the verified pre-DRV-optimization baseline.
- This project is not claimed to be tapeout-ready.

## Attribution

The original SHA-256 RTL belongs to Joachim Strombergson / Secworks.
The personal contribution focuses on logic synthesis and ASIC physical implementation.
