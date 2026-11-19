set PROJ $::env(PROJ)

create_library_set -name LIB_SLOW -timing [list $::env(SLOW_LIB)]
create_library_set -name LIB_FAST -timing [list $::env(FAST_LIB)]

create_timing_condition -name TC_SLOW -library_sets {LIB_SLOW}
create_timing_condition -name TC_FAST -library_sets {LIB_FAST}

create_rc_corner -name RC_GPDK045 -qrc_tech $::env(QRC_TECH)

create_delay_corner -name DC_SLOW -timing_condition TC_SLOW -rc_corner RC_GPDK045
create_delay_corner -name DC_FAST -timing_condition TC_FAST -rc_corner RC_GPDK045

create_constraint_mode -name FUNC -sdc_files [list "$PROJ/runs/genus/outputs/constraints.sdc"]

create_analysis_view -name VIEW_SETUP -constraint_mode FUNC -delay_corner DC_SLOW
create_analysis_view -name VIEW_HOLD -constraint_mode FUNC -delay_corner DC_FAST

set_analysis_view -setup {VIEW_SETUP} -hold {VIEW_HOLD}
