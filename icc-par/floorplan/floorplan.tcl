#floorplan

derive_pg_connection -power_net VDD -power_pin VDD -create_port top
derive_pg_connection -ground_net VSS -ground_pin VSS -create_port top

set_preferred_routing_direction   -layers {M1 M3 M5 M7 M9} -direction horizontal
set_preferred_routing_direction   -layers {M2 M4 M6 M8 MRDL} -direction vertical

create_floorplan \
        -core_utilization 0.6 \
        -flip_first_row \
        -start_first_row \
  	-left_io2core 5 \
  	-bottom_io2core 5 \
  	-right_io2core 5 \
  	-top_io2core 5 \

cut_row -all
add_row \
  -within [get_attr [get_core_area] bbox] \
  -direction horizontal \
  -flip_first_row \
  -tile_name unit

# preroute standard cell rails
insert_stdcell_filler   \
        -cell_without_metal "SHFILL128_RVT SHFILL64_RVT SHFILL3_RVT SHFILL2_RVT SHFILL1_RVT" \
        -connect_to_power {VDD} \
        -connect_to_ground {VSS}

preroute_standard_cells \
  -connect horizontal     \
  -port_filter_mode off   \
  -cell_master_filter_mode off    \
  -cell_instance_filter_mode off  \
  -voltage_area_filter_mode off

remove_stdcell_filler -stdcell

#POWER GRID
synthesize_fp_rings \
  -nets {VDD VSS} \
  -core \
  -layers {M5 M4} \
  -width {1.25 1.25} \
  -space {0.5 0.5} \
  -offset {1 1}

set_power_plan_strategy core \
  -nets {VDD VSS} \
  -core \
  -template saed_32nm.tpl:m45_mesh(0.5,1.0) \
  -extension {stop: outermost_ring}

compile_power_plan


