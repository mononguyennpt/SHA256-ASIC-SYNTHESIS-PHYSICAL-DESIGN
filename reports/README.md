# SHA-256 ASIC — EDA report index

This directory contains **20 sanitized Cadence reports**: 5 Genus synthesis reports and 15 Innovus implementation reports. Values and analysis conditions are retained from the tool outputs; server-specific paths/host metadata have been redacted. See the [project README](../README.md) for the PPA summary and scope.

## Genus synthesis (5)

- [`area.rpt`](synthesis/area.rpt)
- [`gates.rpt`](synthesis/gates.rpt)
- [`pre_synth_lint.rpt`](synthesis/pre_synth_lint.rpt)
- [`timing.rpt`](synthesis/timing.rpt)
- [`timing_lint.rpt`](synthesis/timing_lint.rpt)

## Innovus area (1)

- [`sha256_final_area.rpt`](physical_design/area/sha256_final_area.rpt)

## Clock tree synthesis and clock timing (6)

- [`post_cts_clock_summary.rpt`](physical_design/cts/post_cts_clock_summary.rpt)
- [`final_clock_tree_summary.rpt`](physical_design/cts/final_clock_tree_summary.rpt)
- [`clock_timing_summary.rpt`](physical_design/cts/clock_timing_summary.rpt)
- [`clock_skew.rpt`](physical_design/cts/clock_skew.rpt)
- [`clock_skew_hold.rpt`](physical_design/cts/clock_skew_hold.rpt)
- [`clock_latency.rpt`](physical_design/cts/clock_latency.rpt)

## Post-route timing and constraints (4)

- [`check_timing_setup.rpt`](physical_design/timing/check_timing_setup.rpt)
- [`check_timing_hold.rpt`](physical_design/timing/check_timing_hold.rpt)
- [`constraint_setup.rpt`](physical_design/timing/constraint_setup.rpt)
- [`constraint_hold.rpt`](physical_design/timing/constraint_hold.rpt)

## DRV and verification records (3)

- [`sha256_pre_drv_optimization.rpt`](physical_design/verification/sha256_pre_drv_optimization.rpt)
- [`final_data_drv.rpt`](physical_design/verification/final_data_drv.rpt)
- [`post_optimization_drv.rpt`](physical_design/verification/post_optimization_drv.rpt)

## Post-route vectorless power estimation (1)

- [`power_summary.rpt`](physical_design/power/power_summary.rpt)

## Interpretation and limitations

- `power_summary.rpt`: **5.94372690 mW** total estimated power at **1.08 V**, 6 ns, `VIEW_SETUP`/slow library; **static vectorless** activity (0.2 transitions/cycle for sequential elements and primary inputs), **no SAIF/VCD**. This is not a measured workload result or signoff power analysis.
- `post_optimization_drv.rpt` is a **separate experimental DRV-optimization result**, not the baseline chosen for final reporting. The baseline retains **84 max-fanout violations** against the limit of 32.
- Post-CTS versus final CTS reports describe different milestones; the presence of tool-generated check reports does **not** mean independent signoff DRC/LVS/STA was completed.
- Genus area and Innovus instance area have different reporting bases and must not be treated as directly interchangeable.
