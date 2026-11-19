set PROJ $::env(PROJ)
set TOP sha256

set_db / .max_cpus_per_server 4

read_libs $::env(SLOW_LIB)
read_physical -lef $::env(CELL_LEF)

set RTL_FILES [glob -nocomplain "$PROJ/inputs/rtl/*.v"]

if {[llength $RTL_FILES] == 0} {
    error "No RTL files found"
}

read_hdl $RTL_FILES
elaborate $TOP

check_design -unresolved

read_sdc "$PROJ/config/constraints.sdc"

report_timing -lint -verbose > "$PROJ/runs/genus/timing_lint.rpt"

puts "PRE_SYNTHESIS_CHECK_COMPLETED"
exit
