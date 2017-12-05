package require cmdline

variable ::argv0 $::quartus(args)
set options { \
{ "project.arg" "" "Project name" } \
}
set usage "You need to specify options and values"
array set optshash [::cmdline::getoptions ::argv $options $usage]
set proj $optshash(project)

load_package flow

project_new $proj -revision $proj -overwrite

set_global_assignment -name FAMILY "Arria II GX"
set_global_assignment -name DEVICE EP2AGX45CU17C4

set_global_assignment -name TOP_LEVEL_ENTITY base_decoder

set_global_assignment -name SDC_FILE       ./clk.sdc
set_global_assignment -name USER_LIBRARIES .
set_global_assignment -name SEARCH_PATH    .

execute_module -tool map
set name_ids [get_names -filter * -node_type pin]
foreach_in_collection name_id $name_ids {
    set pin_name [get_name_info -info full_path $name_id]
    if {![string match "clk" $pin_name]} {
        set_instance_assignment -to $pin_name -name VIRTUAL_PIN ON
    }
}
export_assignments

execute_module -tool map
execute_module -tool fit
execute_module -tool sta -args {--do_report_timing}

project_close
