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

## Post-Route Power Estimation (Innovus)

| Component | Estimated Power |
|---|---:|
| Internal power | 4.64353929 mW |
| Switching power | 1.29895643 mW |
| Leakage power | 0.00123119 mW |
| **Total power** | **5.94372690 mW** |
| Clock-network power (included in total) | ~0.479 mW |

### Power Analysis Conditions

- Technology: GPDK045 (45 nm)
- Tool: Cadence Innovus 25.12
- Supply voltage: 1.08 V
- Clock period: 6.000 ns
- Analysis view: VIEW_SETUP (slow library)
- Method: Static vectorless power estimation
- Sequential element activity: 0.2 transitions/cycle
- Primary input activity: 0.2 transitions/cycle
- SAIF/VCD activity files: Not provided

The power report was generated from a restored copy of the
selected post-route baseline.

This is a model-based estimate, not measured workload power
or independent power signoff.

The clock-network power is included in total power and
must not be added to the total again.

See [Power Report](../reports/physical_design/power/power_summary.rpt).

## Limitations

- Maximum fanout constraint of 32 is not fully satisfied.
- Full independent signoff DRC, LVS, and STA were not performed.
- A complete GDSII deliverable was not generated.
- Results correspond to the verified pre-DRV-optimization baseline.
- This project is not claimed to be tapeout-ready.

## Attribution

The original SHA-256 RTL belongs to Joachim Strombergson / Secworks.
The personal contribution focuses on logic synthesis and ASIC physical implementation.
