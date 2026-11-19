# SHA-256 / GPDK045 / Cadence Innovus 25.12
# Reconstructed CTS replay template; NOT the original executed CTS script.
# Command options checked against Innovus help on 2026-11-19.
# End-to-end execution from the original post-placement DB: NOT verified.
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
set OUT_DB [file join $WORK_DIR 04_cts]
set RPT [file join $WORK_DIR reports cts]
if {![file isdirectory $INPUT_DB]} { error "Input checkpoint not found: $INPUT_DB" }
if {$INPUT_DB eq $OUT_DB} { error "Input and output checkpoints must differ" }
file mkdir $RPT

read_db $INPUT_DB
if {[get_db current_design .name] ne "sha256"} { error "Unexpected design" }

# Preflight only; this command does not alter the design.
ccopt_design -check_cts_config

# Reconstructed execution. Original CTS switches were not recovered.
ccopt_design -report_dir $RPT
report_clock_trees -summary -views VIEW_SETUP -out_file [file join $RPT clock_tree_summary.rpt]
report_analysis_views -type active > [file join $RPT active_views.rpt]

write_db $OUT_DB
if {![file isdirectory $OUT_DB]} { error "CTS checkpoint not written: $OUT_DB" }
puts "CTS_REPLAY_COMPLETED: $OUT_DB"
