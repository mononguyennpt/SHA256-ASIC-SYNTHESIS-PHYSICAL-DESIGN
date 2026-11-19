# SHA-256 / GPDK045 / Cadence Innovus 25.12
# Reconstructed post-route in-tool DRC / connectivity / antenna checks.
# Options checked against Innovus help on 2026-11-19.
# This script has NOT been independently replay-validated.
# Required environment: PD_INPUT_DB, PD_REPLAY_DIR.
# Does not claim independent signoff DRC/LVS/STA or GDS completion.

proc sha256_required_env {name} {
    if {![info exists ::env($name)] || [string trim $::env($name)] eq ""} {
        error "Missing required environment variable: $name"
    }
    return $::env($name)
}

set INPUT_DB [file normalize [sha256_required_env PD_INPUT_DB]]
set WORK_DIR [file normalize [sha256_required_env PD_REPLAY_DIR]]
set RPT [file join $WORK_DIR reports postroute_verification]
if {![file isdirectory $INPUT_DB]} { error "Input checkpoint not found: $INPUT_DB" }
file mkdir $RPT

read_db $INPUT_DB
if {[get_db current_design .name] ne "sha256"} { error "Unexpected design" }

check_drc -out_file [file join $RPT innovus_drc.rpt]
check_connectivity -type all -out_file [file join $RPT connectivity.rpt]
check_antenna -out_file [file join $RPT antenna.rpt]

# Design-rule fanout is a separate constraint: the original verified
# baseline had 84 max-fanout violations (limit: 32). These three checks
# do NOT demonstrate that max-fanout is clean.
# No write_db: avoid modifying or replacing the original checkpoint.
puts "POSTROUTE_VERIFICATION_REPORTS_WRITTEN: $RPT"
