set PROJ $::env(PROJ)
set TOP sha256

set OUT "$PROJ/runs/genus/outputs"
set RPT "$PROJ/runs/genus/reports"

file mkdir $OUT
file mkdir $RPT

set_db / .max_cpus_per_server 4

set_db / .syn_generic_effort high
set_db / .syn_map_effort high
set_db / .syn_opt_effort high

set_db / .remove_assigns true

read_libs $::env(SLOW_LIB)
read_physical -lef $::env(CELL_LEF)

set RTL_FILES [lsort [glob "$PROJ/inputs/rtl/*.v"]]

read_hdl $RTL_FILES
elaborate $TOP

check_design -unresolved

read_sdc "$PROJ/config/constraints.sdc"

report_timing -lint -verbose > "$RPT/pre_synth_lint.rpt"

syn_generic
syn_map
syn_opt

remove_assigns_without_optimization

report_timing > "$RPT/timing.rpt"
report_area > "$RPT/area.rpt"
report_gates > "$RPT/gates.rpt"
report_timing -lint -verbose > "$RPT/timing_lint.rpt"

write_hdl > "$OUT/netlist.v"
write_sdc > "$OUT/constraints.sdc"

puts "SYNTHESIS_COMPLETED"
exit
