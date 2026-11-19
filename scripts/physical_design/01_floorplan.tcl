# ------------------------------------------------------------
# SHA-256 ASIC Physical Design
# Author: SHA-256 PD Project
# Stage: 01_floorplan
# Purpose: Create and save initial floorplan
# Technology: GPDK045
# ------------------------------------------------------------

set RUN $::env(FP_DIR)

puts "FLOORPLAN_STAGE_START"

# Set the intended technology process node
set_db design_process_node 45

puts "PROCESS_NODE_CONFIGURED"
puts "PROCESS_NODE=[get_db design_process_node]"

# Initial floorplan
# Aspect ratio: 1.0
# Target utilization: 60 percent
# Core-to-die margins: 15 um on each side

create_floorplan \
    -site CoreSite \
    -core_density_size {1.0 0.60 15 15 15 15}

puts "FLOORPLAN_CREATED"

# Validate floorplan geometry and density
check_floorplan -report_density \
    > "$RUN/floorplan_check.rpt"

puts "FLOORPLAN_CHECK_COMPLETED"

# Preserve active MMMC evidence
report_analysis_views -type active \
    > "$RUN/active_views.rpt"

# Save floorplan database
write_db "$RUN/01_floorplan"

if {![file isdirectory "$RUN/01_floorplan"]} {
    error "FLOORPLAN_DATABASE_NOT_CREATED"
}

puts "FLOORPLAN_DATABASE_WRITTEN"
