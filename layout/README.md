# SHA-256 ASIC Physical Design Gallery

Technology: GPDK045 45 nm.

EDA tool: Cadence Innovus 25.12.

These screenshots document the physical implementation of the SHA-256 ASIC.

## 01 - Power Rings and Stripes

![Power Rings and Stripes](01_power%20rings%20and%20stripes.jpg)

Power-grid geometry showing power rings and stripes.

## 02 - Special Power Routing

![Special Power Routing](02_special%20routing.jpg)

Special-routing view illustrating power connectivity.

## 03 - Standard-Cell Placement

![Standard-Cell Placement](03_standard-cell_placement.jpg)

Standard-cell placement with an Innovus analysis overlay.

## 04 - Clock Distribution

![Clock Distribution](04_clock%20tree.jpg)

Clock-distribution routing visualization.

## 05 - Clock Tree Debugger

![Clock Tree Debugger](05_clock%20tree%20debugger.jpg)

Clock-tree topology displayed in the Innovus Clock Tree Debugger.

## 06 - Post-CTS Layout

![Post-CTS Layout](06_cts.jpg)

Physical implementation view at the CTS stage.

## 07 - Final Routed Layout

![Final Routed Layout](07_final%20laypout%20(after%20global%20and%20detailed%20routing).jpg)

Full-chip layout after global and detailed signal routing.

## 08 - Detailed Routing Zoom

![Detailed Routing Zoom](08_detailed_routing_zoom.png)

Close-up of multi-layer routing across standard-cell regions.

## Engineering Notes

The screenshots were captured during physical implementation, before the separate vectorless power-report extraction.

Screenshots provide visual implementation evidence, not independent DRC/LVS signoff.

See [EDA Reports](../reports/README.md) for the numerical implementation and power results.
