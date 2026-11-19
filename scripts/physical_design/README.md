# SHA-256 CTS to Post-Route — Reconstructed Scripts

**Status: RECONSTRUCTED / NOT INDEPENDENTLY REPLAY-VALIDATED.** These files are a portfolio-friendly recovery of the missing CTS-to-post-route Tcl flow, **not** original executed scripts. Syntax and named options were checked against the provided `help` output from Cadence Innovus 25.12-s079_1 (2026-11-19); project-specific prerequisites and full execution have not been verified. Do not claim they reproduced the archived timing, area, clock-tree or verification results.

## Files

- `05_cts.tcl`: load an archived post-placement checkpoint, check CTS prerequisites, run `ccopt_design`, report the clock tree, save a **new** CTS checkpoint.
- `06_routing.tcl`: load an archived CTS checkpoint, run global/detail routing, check DRC/connectivity, save a **new** routed checkpoint.
- `07_postroute_sta.tcl`: load a routed checkpoint, re-extract RC, generate setup/hold/recovery/removal reports for `VIEW_SETUP` and `VIEW_HOLD`.
- `08_postroute_verification.tcl`: run internal Innovus DRC, connectivity and antenna checks, writing reports only.

## Environment

Each script requires **two environment variables**: `PD_INPUT_DB` (directory path to a **previously saved** Innovus `write_db` checkpoint) and `PD_REPLAY_DIR` (separate writable output root, outside the original verified checkpoints). Each loads its input with `read_db`. Use **one new Innovus session per script**. Do not source these scripts into an active session holding the verified baseline.

Example in **tcsh** on a server that has legally available Cadence/GPDK045 libraries:

```tcsh
cd ~/sha256_gpdk045
setenv PD_REPLAY_DIR "$HOME/sha256_pd_replay"
setenv PD_INPUT_DB "$HOME/sha256_gpdk045/runs/innovus/pause_20261118_180542/03_place_sta_pause"
innovus -stylus
```

Within a **fresh Innovus Tcl Console**:

```tcl
source ~/sha256_asic_github/scripts/physical_design/05_cts.tcl
```

**Do not execute this sample merely to publish the scripts.** CTS/routing execution will modify the in-memory design and may require substantial EDA resources. If later replaying routing, start a new session and set `PD_INPUT_DB` to the **new** `${PD_REPLAY_DIR}/04_cts` output; do not silently mix reconstructed and original checkpoints. For post-route analysis, use either the replayed `${PD_REPLAY_DIR}/05_route_initial` or the archived `06_postroute_verified` / `07_before_drv_optimization`, with the proper library/QRC environment.

## Evidence and limitations

The original project saved `04_cts`, `05_route_initial`, `06_postroute_verified` and `07_before_drv_optimization` checkpoints. Those validate the existence of stage snapshots but **not** the exact historic `ccopt_design` or `route_design` options. The legacy post-route baseline had 84 max-fanout violations (`set_max_fanout 32`); internal DRC/connectivity/antenna results do not close those. No independent signoff DRC/LVS/STA or GDSII was produced. `route_opt_design -opt -drv` was attempted separately and did not eliminate those 84 violations; it is intentionally not run automatically by these scripts.

All original checked-in synthesis and floorplan Tcl scripts remain separate. Do not distribute PDK/LEF/Liberty/QRC data, database checkpoints, proprietary files, or private host paths with this package.
