# SHA-256 ASIC Synthesis and Physical Design (GPDK045 45 nm)

A personal **RTL-to-physical-implementation** project using an existing SHA-256 hardware core, **Cadence Genus** for logic synthesis, and **Cadence Innovus** for physical design on the **GPDK045 45 nm** educational process design kit.

> **Project scope:** I did **not** design the SHA-256 RTL. My work focused on synthesis, timing constraints, floorplanning, power planning, standard-cell placement, clock tree synthesis (CTS), detailed routing, and post-route analysis.

## RTL source and attribution

The SHA-256 RTL was obtained from the [Centre for Hardware Security Innovus tutorial](https://github.com/Centre-for-Hardware-Security/tutorial_innovus). The original SHA-256 core was developed by **Joachim Strömbergson / Secworks**: [secworks/sha256](https://github.com/secworks/sha256).

The four RTL modules retain their original copyright notices. The original RTL license is reproduced at [`licenses/SECWORKS_LICENSE`](licenses/SECWORKS_LICENSE). Credit for RTL design belongs to the original authors; the synthesis and physical implementation work documented here is my contribution.

## Implementation flow

| Stage | Work performed |
|---|---|
| RTL input | Reused the attributed SHA-256 Verilog RTL |
| Logic synthesis | Technology mapping and optimization using Cadence Genus |
| Timing constraints | 6.000 ns clock, input/output delays, clock uncertainty, and design-rule constraints |
| Floorplanning | Die/core dimensions and I/O placement |
| Power planning | VDD/VSS rings, stripes, and power connectivity |
| Placement | Standard-cell placement and legalization |
| CTS | Clock distribution network construction and analysis |
| Routing | Global and detailed signal routing |
| Post-route | Parasitic extraction, timing checks, internal DRC, connectivity, and antenna checks |
| Power estimation | Post-route vectorless power analysis using restored Innovus design |

Physical-design steps were executed largely **interactively in the Innovus GUI/Tcl console**. The repository includes the Genus flow, an executed floorplanning script, diagnostic scripts, and **reconstructed CTS-to-post-route Tcl scripts**. The reconstructed scripts document the implemented flow but have **not been independently replay-validated**; this is **not** a fully automated end-to-end flow.

## Tools and design setup

| Item | Configuration |
|---|---|
| Design | SHA-256 |
| Process kit | GPDK045 (45 nm) |
| Synthesis | Cadence Genus 25.12-s067_1 |
| Physical design | Cadence Innovus 25.12-s079_1 |
| Target clock period | 6.000 ns |
| Nominal target frequency | 166.67 MHz |
| Timing analysis | Setup view (slow library), hold view (fast library) |
| Hard macros | 0; storage implemented with standard cells |

## Results

All post-route results below describe the **baseline before the final experimental DRV-optimization attempt**, except where an experiment is explicitly identified.

### PPA snapshot

| Category | Metric | Result |
|---|---|---:|
| Performance | Target clock period / nominal frequency | 6.000 ns / 166.67 MHz |
| Performance | Post-route setup / hold slack | +0.043 ns / +0.038 ns |
| Area | Post-route instance area | 29,890.680 µm² |
| Area | Placement density | 55.42% |
| Power | **Estimated total power (vectorless)** | **5.943727 mW** |

**Reporting basis:** The timing and area figures refer to the selected pre-DRV-experiment post-route baseline. Power was estimated from a restored copy of that checkpoint using the `VIEW_SETUP` power view and default switching assumptions. These are tool-reported implementation results, **not independent signoff PPA**.

### Synthesis (Genus)

| Metric | Value |
|---|---:|
| Synthesized cell count | 8,103 |
| Cell area | 32,333.663 µm² |
| Estimated net area | 9,575.386 µm² |
| Genus reported total area | 41,909.049 µm² |
| Worst reported setup slack | **0 ps (MET)** |

The Genus timing report uses a **global interconnect model**. Its 0 ps setup slack is distinct from post-route Innovus timing. Genus *total area* includes its estimated net-area component and should not be compared directly with the post-route **instance area**.

### Post-route physical implementation (Innovus)

| Metric | Value |
|---|---:|
| Die size | 263.60 × 260.87 µm |
| Core size | 233.60 × 230.85 µm |
| Post-route instance count | 8,276 |
| Reported total instance area (including physical instances) | 29,890.680 µm² |
| Placement density | 55.42% |
| Clock buffers | 21 |
| Clock sinks | 1,806 |
| Clock-tree routed wire length | 6,847.965 µm |
| Reported clock skew | 5 ps |

### Post-route timing

| Check | Worst reported slack |
|---|---:|
| Setup | +0.043 ns |
| Hold | +0.038 ns |
| Recovery | +3.213 ns |
| Removal | +0.215 ns |

These are the results of the reported Innovus analysis views and conditions, **not an independent signoff STA result**.

### Post-route power estimation (Innovus)

| Component | Estimated power |
|---|---:|
| Internal power | 4.64353929 mW |
| Switching power | 1.29895643 mW |
| Leakage power | 0.00123119 mW |
| **Total power** | **5.94372690 mW** |
| Clock-network power (included in total) | ~0.479 mW (8.06%) |

**Analysis conditions:** Cadence Innovus 25.12; GPDK045; `VIEW_SETUP` (`slow.lib`); VDD = **1.08 V**; clock period = **6.000 ns**. The report uses **static, vectorless estimation**, with average activity of **0.2 transitions per clock cycle** for sequential elements and primary inputs. **No SAIF/VCD activity file** was supplied. Clock-network power is a breakdown of total power and must not be added to it a second time.

This is a **model-based estimate**, not measured workload power, not power-integrity/IR-drop signoff, and not signoff power analysis. See [`power_summary.rpt`](reports/physical_design/power/power_summary.rpt).

### Physical checks and design-rule constraints

| Check | Reported violations |
|---|---:|
| Innovus internal DRC | 0 |
| Connectivity | 0 |
| Antenna | 0 |
| Maximum transition | 0 |
| Maximum capacitance | 0 |
| **Maximum fanout** | **84 (open)** |

The `set_max_fanout 32` constraint was **not fully met**. Worst observed fanout was **75**. One post-route DRV-optimization attempt did not reduce the count of 84 violations. These results must not be described as full design-rule closure.

For a concise metrics-only document, see [`results/implementation_summary.md`](results/implementation_summary.md).

## EDA reports

The repository includes **20 sanitized reports** generated by Cadence Genus (5) and Innovus (15). The [complete, categorized report index](reports/README.md) links to all 20 files. Selected primary evidence:

| Evidence | Report |
|---|---|
| Genus synthesis area | [`area.rpt`](reports/synthesis/area.rpt) |
| Genus synthesis timing | [`timing.rpt`](reports/synthesis/timing.rpt) |
| Final Innovus instance area | [`sha256_final_area.rpt`](reports/physical_design/area/sha256_final_area.rpt) |
| Post-CTS clock tree | [`post_cts_clock_summary.rpt`](reports/physical_design/cts/post_cts_clock_summary.rpt) |
| Final clock tree | [`final_clock_tree_summary.rpt`](reports/physical_design/cts/final_clock_tree_summary.rpt) |
| Post-route timing checks | [`check_timing_setup.rpt`](reports/physical_design/timing/check_timing_setup.rpt) and [`check_timing_hold.rpt`](reports/physical_design/timing/check_timing_hold.rpt) |
| Vectorless power breakdown | [`power_summary.rpt`](reports/physical_design/power/power_summary.rpt) |
| Baseline DRV evidence | [`sha256_pre_drv_optimization.rpt`](reports/physical_design/verification/sha256_pre_drv_optimization.rpt) |

`post_optimization_drv.rpt` describes a **separate DRV-optimization experiment**, not the selected baseline. Timing-check and constraint reports should not be mistaken for independent signoff STA. Server-specific paths and host metadata were redacted in published report copies; original tool reports are retained in the working environment.

## Layout screenshots

### Final Routed Layout

![SHA-256 Final Routed Layout](layout/07_final%20laypout%20(after%20global%20and%20detailed%20routing).jpg)

**Figure:** SHA-256 ASIC after global and detailed routing in Cadence Innovus.

The selected post-route baseline contains 8,276 reported instances and a total instance area of 29,890.680 square micrometers.

### Physical Design Gallery

The complete gallery includes eight screenshots covering power planning, placement, CTS, clock-tree analysis, final routing, and a detailed routing close-up.

**[View all 8 Physical Design Screenshots](layout/README.md)**

The vectorless power estimate was generated separately from a restored Innovus checkpoint. These screenshots are not evidence of power-integrity or independent physical-signoff closure.

## Repository contents

```text
inputs/rtl/                      Third-party SHA-256 RTL (attributed)
config/constraints.sdc           Timing and design-rule constraints
config/mmmc.tcl                 Innovus setup/hold analysis views
scripts/run_genus.tcl           Genus synthesis
scripts/check_setup.tcl         Genus pre-synthesis checks
scripts/test_import.tcl         Innovus import and timing diagnostics
scripts/physical_design/         Floorplan and reconstructed implementation scripts
reports/README.md                Index linking all 20 sanitized EDA reports
reports/synthesis/               Genus synthesis reports (5)
reports/physical_design/         Innovus area, CTS, timing, DRV and power reports (15)
results/implementation_summary.md   Published engineering metrics
layout/                          Innovus layout screenshots
licenses/SECWORKS_LICENSE       Original RTL license
```

### Environment requirements

The scripts expect a configured Cadence/GPDK045 environment with these variables: `PROJ`, `SLOW_LIB`, `FAST_LIB`, `CELL_LEF`, and `QRC_TECH`. The PDK, standard-cell libraries, and commercial EDA tools **are not distributed** with this repository. The scripts are implementation records and may require environment-specific configuration to rerun.

## Known limitations

- **84 maximum-fanout violations** remain against a fanout limit of 32.
- No complete GDSII deliverable was generated because the necessary GDS cell views/layer map were not verified in the available technology files.
- Independent signoff DRC, LVS, and STA were not performed. Internal Innovus checks are **not** signoff verification.
- Power is a **vectorless estimate** using default switching activity; no workload-derived SAIF/VCD activity or power-integrity signoff is provided.
- The published Tcl files do not automate the entire physical-design flow; several stages were executed interactively, and reconstructed scripts have not been independently replay-validated.
- **This project is not tapeout-ready.**

## Acknowledgments

Thanks to **Joachim Strömbergson / Secworks** for the original SHA-256 RTL and the **Centre for Hardware Security** for the Innovus tutorial used to obtain it.
