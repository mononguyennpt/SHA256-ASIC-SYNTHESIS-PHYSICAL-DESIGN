# SHA-256 / GPDK045 / Cadence Innovus 25.12
# Reconstructed post-route RC extraction and MMMC timing reporting.
# Commands reflect the flow's known VIEW_SETUP and VIEW_HOLD names.
# Command forms were observed in prior project reports and Innovus help.
# This script has NOT been independently replay-validated.
# Required environment: PD_INPUT_DB, PD_REPLAY_DIR.
# Run in a fresh Innovus session. Does not overwrite the input checkpoint.

proc sha256_required_env {name} {
    if {![info exists ::env($name)] || [string trim $::env($name)] eq ""} {
        error "Missing required environment variable: $name"
    }
    return $::env($name)
}

set INPUT_DB [file normalize [sha256_required_env PD_INPUT_DB]]
set WORK_DIR [file normalize [sha256_required_env PD_REPLAY_DIR]]
set RPT [file join $WORK_DIR reports postroute_sta]
if {![file isdirectory $INPUT_DB]} { error "Input checkpoint not found: $INPUT_DB" }
file mkdir $RPT

read_db $INPUT_DB
if {[get_db current_design .name] ne "sha256"} { error "Unexpected design" }

# This DB may not retain extracted RC; extract again before timing reports.
# Confirm RC corner/QRC access in your own licensed GPDK045 environment.
extract_rc
report_analysis_views -type active > [file join $RPT active_views.rpt]

set_db / .timing_analysis_check_type setup
check_timing -verbose -view VIEW_SETUP > [file join $RPT check_timing_setup.rpt]
report_timing -check_type setup -view VIEW_SETUP -max_paths 10 > [file join $RPT setup_paths.rpt]
report_timing -check_type recovery -view VIEW_SETUP -max_paths 10 > [file join $RPT recovery_paths.rpt]

set_db / .timing_analysis_check_type hold
check_timing -verbose -view VIEW_HOLD > [file join $RPT check_timing_hold.rpt]
report_timing -check_type hold -view VIEW_HOLD -max_paths 10 > [file join $RPT hold_paths.rpt]
report_timing -check_type removal -view VIEW_HOLD -max_paths 10 > [file join $RPT removal_paths.rpt]

set_db / .timing_analysis_check_type setup

# No write_db here: do not assume extracted RC survives an ordinary DB save.
puts "POSTROUTE_STA_REPORTS_WRITTEN: $RPT"
