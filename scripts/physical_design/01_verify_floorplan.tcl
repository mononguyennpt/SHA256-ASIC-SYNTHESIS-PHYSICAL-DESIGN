# ------------------------------------------------------------
# SHA-256 ASIC Physical Design
# Author: SHA-256 PD Project
# Stage: 01_floorplan
# Purpose: Validate geometry and rows after DB restore
# ------------------------------------------------------------

set RUN $::env(VERIFY_DIR)

puts "FLOORPLAN_VALIDATION_START"

# Verify restored design identity

set DESIGN_NAME [get_db current_design .name]

puts "DESIGN_NAME=$DESIGN_NAME"

if {$DESIGN_NAME ne "sha256"} {
    error "UNEXPECTED_DESIGN_NAME"
}

# Verify technology configuration

set PROCESS_NODE [get_db design_process_node]

puts "PROCESS_NODE=$PROCESS_NODE"

# Read physical boundaries

set DIE_BOX [get_db current_design .bbox]

set CORE_BOX [get_db current_design .core_bbox]

puts "DIE_BOX=$DIE_BOX"
puts "CORE_BOX=$CORE_BOX"

if {$DIE_BOX eq "" || $CORE_BOX eq ""} {
    error "FLOORPLAN_GEOMETRY_MISSING"
}

# Verify placement rows

set ROWS [get_db rows]

set ROW_COUNT [llength $ROWS]

puts "PLACEMENT_ROW_COUNT=$ROW_COUNT"

if {$ROW_COUNT == 0} {
    error "NO_PLACEMENT_ROWS"
}

# Verify top-level ports

set PORTS [get_db ports]

set PORT_COUNT [llength $PORTS]

puts "PRIMARY_IO_PORT_COUNT=$PORT_COUNT"

if {$PORT_COUNT != 77} {
    error "UNEXPECTED_IO_PORT_COUNT"
}

# Recheck floorplan

check_floorplan -report_density \
    > "$RUN/floorplan_restored_check.rpt"

puts "FLOORPLAN_CHECK_COMPLETED"

puts "FLOORPLAN_VALIDATION_COMPLETED"
