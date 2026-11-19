# SHA-256 / GPDK045 / Cadence Innovus 25.12
# Reconstructed routing replay template; NOT the original executed routing script.
# Command options checked against Innovus help on 2026-11-19.
# End-to-end execution from the original CTS DB: NOT verified.
# Required environment: PD_INPUT_DB, PD_REPLAY_DIR.
# Run only in a fresh Innovus session, never on the final baseline in-place.

proc sha256_required_env {name} {
    if {![info exists ::env($name)] || [string trim $::env($name)] eq ""} {
        error "Missing required environment variable: $name"
    }
    return $::env($name)
}

set INPUT_DB [file normalize [sha256_required_env PD_INPUT_DB]]
set WORK_DIR [file normalize [sha256_required_env PD_REPLAY_DIR]]
set OUT_DB [file join $WORK_DIR 05_route_initial]
set RPT [file join $WORK_DIR reports routing]
if {![file isdirectory $INPUT_DB]} { error "Input checkpoint not found: $INPUT_DB" }
if {$INPUT_DB eq $OUT_DB} { error "Input and output checkpoints must differ" }
file mkdir $RPT

read_db $INPUT_DB
if {[get_db current_design .name] ne "sha256"} { error "Unexpected design" }

# Reconstructed global + detailed routing. Original routing switches unknown.
route_design -global_detail
check_drc -out_file [file join $RPT drc_after_route.rpt]
check_connectivity -type all -out_file [file join $RPT connectivity_after_route.rpt]

write_db $OUT_DB
if {![file isdirectory $OUT_DB]} { error "Routing checkpoint not written: $OUT_DB" }
puts "ROUTING_REPLAY_COMPLETED: $OUT_DB"
