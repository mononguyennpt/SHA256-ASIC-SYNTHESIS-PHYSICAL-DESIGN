# ------------------------------------------------------------
# SHA-256 ASIC Physical Design
# Author: SHA-256 PD Project
# Stage: 02_io_planning
# Purpose: Inspect IO pin placement and supported commands
# ------------------------------------------------------------

set RUN $::env(IO_DIR)

puts "IO_INSPECTION_START"

set PORTS [get_db ports]

set PORT_COUNT [llength $PORTS]

puts "TOTAL_IO_PORTS=$PORT_COUNT"

if {$PORT_COUNT != 77} {
    error "UNEXPECTED_IO_PORT_COUNT"
}

set STATUS_COUNTS [dict create]
set SIDE_COUNTS [dict create]

set OUT [open "$RUN/port_inventory.tsv" w]

puts $OUT "PORT\tDIRECTION\tSTATUS\tSIDE\tLOCATION\tLAYER"

foreach PORT $PORTS {

    set NAME [get_db $PORT .name]
    set DIRECTION [get_db $PORT .direction]
    set STATUS [get_db $PORT .place_status]
    set SIDE [get_db $PORT .side]
    set LOCATION [get_db $PORT .location]
    set LAYER [get_db $PORT .layer]

    dict incr STATUS_COUNTS $STATUS
    dict incr SIDE_COUNTS $SIDE

    puts $OUT [join [list \
        $NAME \
        $DIRECTION \
        $STATUS \
        $SIDE \
        $LOCATION \
        $LAYER \
    ] "\t"]
}

close $OUT

puts "PIN_STATUS_COUNTS=$STATUS_COUNTS"
puts "PIN_SIDE_COUNTS=$SIDE_COUNTS"

# Check availability of IO planning commands

puts "EDIT_PIN_COMMAND_AVAILABLE=[expr {[llength [info commands edit_pin]] > 0}]"

puts "ASSIGN_IO_PINS_COMMAND_AVAILABLE=[expr {[llength [info commands assign_io_pins]] > 0}]"

puts "CHECK_PIN_ASSIGNMENT_AVAILABLE=[expr {[llength [info commands check_pin_assignment]] > 0}]"

puts "IO_INSPECTION_COMPLETED"
