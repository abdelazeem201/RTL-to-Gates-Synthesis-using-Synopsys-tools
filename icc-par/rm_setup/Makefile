##ICC RM Makefile
##See README.* file for RM details


ICC_EXEC = icc_shell -64bit
LOG     = log
REPORT_DIR = reports
OUTPUT_DIR = results
PNA_OUTPUT_DIR = pna_output

####Source Options
OPTIONS =



##Optional: Specify design library if you want backup step and clean step to use it
##CAUTION: if added, the clean step will delete it
DESIGN_LIB =


##########################################################################################################################
# Flat floorplanning script execution section
# Execute "make dp" to run ICC Design Planning RM based on your common_setup.tcl, icc_setup.tcl
##########################################################################################################################


init_design_icc:
	mkdir -p $(REPORT_DIR) $(OUTPUT_DIR) $(LOG)
	$(ICC_EXEC) $(OPTIONS) -f rm_icc_scripts/init_design_icc.tcl | tee -i $(LOG)/init_design_icc.log
	date > init_design_icc

flat_dp: init_design_icc
	mkdir -p $(REPORT_DIR) $(OUTPUT_DIR) $(LOG)
	$(ICC_EXEC) $(OPTIONS) -f rm_icc_dp_scripts/flat_dp.tcl | tee -i $(LOG)/flat_dp.log
	date > flat_dp

dp: flat_dp
	date > dp


################################################################################################################
# ICC RM : netlist2gds script exection section
# Execute "make ic" to run IC Compiler based on your common_setup.tcl & icc_setup.tcl files
# If make dp has been run before, please pick one of the 8 created floorplans and fill that one in the
# variable ICC_FLOORPLAN_CEL in the icc_setup.tcl file
################################################################################################################


place_opt_icc: init_design_icc
	mkdir -p $(REPORT_DIR) $(OUTPUT_DIR) $(LOG)
	$(ICC_EXEC) $(OPTIONS) -f rm_icc_scripts/place_opt_icc.tcl |tee -i $(LOG)/place_opt_icc.log
	date > place_opt_icc

clock_opt_cts_icc: place_opt_icc
	mkdir -p $(REPORT_DIR) $(OUTPUT_DIR) $(LOG)
	$(ICC_EXEC) $(OPTIONS) -f rm_icc_scripts/clock_opt_cts_icc.tcl |tee -i $(LOG)/clock_opt_cts_icc.log
	date > clock_opt_cts_icc

clock_opt_psyn_icc: clock_opt_cts_icc
	mkdir -p $(REPORT_DIR) $(OUTPUT_DIR) $(LOG)
	$(ICC_EXEC) $(OPTIONS) -f rm_icc_scripts/clock_opt_psyn_icc.tcl |tee -i $(LOG)/clock_opt_psyn_icc.log
	date > clock_opt_psyn_icc

clock_opt_route_icc: clock_opt_psyn_icc
	mkdir -p $(REPORT_DIR) $(OUTPUT_DIR) $(LOG)
	$(ICC_EXEC) $(OPTIONS) -f rm_icc_scripts/clock_opt_route_icc.tcl |tee -i $(LOG)/clock_opt_route_icc.log
	date > clock_opt_route_icc

route_icc: clock_opt_route_icc
	mkdir -p $(REPORT_DIR) $(OUTPUT_DIR) $(LOG)
	$(ICC_EXEC) $(OPTIONS) -f rm_icc_scripts/route_icc.tcl |tee -i $(LOG)/route_icc.log
	date > route_icc

route_opt_icc: route_icc
	mkdir -p $(REPORT_DIR) $(OUTPUT_DIR) $(LOG)
	$(ICC_EXEC) $(OPTIONS) -f rm_icc_scripts/route_opt_icc.tcl |tee -i $(LOG)/route_opt_icc.log
	date > route_opt_icc

chip_finish_icc: route_opt_icc
	mkdir -p $(REPORT_DIR) $(OUTPUT_DIR) $(LOG)
	$(ICC_EXEC) $(OPTIONS) -f rm_icc_scripts/chip_finish_icc.tcl |tee -i $(LOG)/chip_finish_icc.log
	date > chip_finish_icc

signoff_opt_icc: chip_finish_icc
	mkdir -p $(REPORT_DIR) $(OUTPUT_DIR) $(LOG)
	$(ICC_EXEC) $(OPTIONS) -f rm_icc_scripts/signoff_opt_icc.tcl |tee -i $(LOG)/signoff_opt_icc.log
	date > signoff_opt_icc

metal_fill_icc: signoff_opt_icc
	mkdir -p $(REPORT_DIR) $(OUTPUT_DIR) $(LOG)
	$(ICC_EXEC) $(OPTIONS) -f rm_icc_scripts/metal_fill_icc.tcl |tee -i $(LOG)/metal_fill_icc.log
	date > metal_fill_icc

outputs_icc: metal_fill_icc
	mkdir -p $(REPORT_DIR) $(OUTPUT_DIR) $(LOG)
	$(ICC_EXEC) $(OPTIONS) -f rm_icc_scripts/outputs_icc.tcl |tee -i $(LOG)/outputs_icc.log
	date > outputs_icc

ic: outputs_icc
	date > ic

################################################################################################################
# ICC RM : Eco flow
################################################################################################################
eco_icc:
	mkdir -p $(REPORT_DIR) $(OUTPUT_DIR) $(LOG)
	$(ICC_EXEC) $(OPTIONS) -f rm_icc_scripts/eco_icc.tcl |tee -i $(LOG)/eco_icc.log
	date > eco_icc

eco: eco_icc
	date > eco


################################################################################################################
# ICC RM : Focal_opt flow
################################################################################################################
focal_opt_icc:
	mkdir -p $(REPORT_DIR) $(OUTPUT_DIR) $(LOG)
	$(ICC_EXEC) $(OPTIONS) -f rm_icc_scripts/focal_opt_icc.tcl |tee -i $(LOG)/focal_opt_icc.log
	date > focal_opt_icc

focal_opt: focal_opt_icc
	date > focal_opt


#############################################################################################################################
# Utilities Section
#
#############################################################################################################################


##Backup
BACKUP  = BACKUP.`date "+%m_%d_%H_%M"`
backup:
	rm -rf $(BACKUP)
	mkdir -p $(BACKUP)
	cp -rf rm_icc_scripts rm_icc_zrt_scripts rm_icc_dp_scripts rm_setup/common_setup.tcl rm_setup/icc_setup.tcl $(DESIGN_LIB) $(REPORT_DIR) $(OUTPUT_DIR) $(LOG) $(PNA_OUTPUT_DIR) $(BACKUP)


##Clean

clean_all:
	rm  -f init_design_icc flat_dp dp init_design_icc_dp place_opt_icc clock_opt_cts_icc clock_opt_psyn_icc clock_opt_route_icc route_icc route_opt_icc chip_finish_icc ic
	rm -rf $(DESIGN_LIB) $(LOG) $(OUTPUT_DIR)/*sbpf* $(OUTPUT_DIR)/*.def $(OUTPUT_DIR)/*pg*  $(REPORT_DIR)/place* $(REPORT_DIR)/clock* $(REPORT_DIR)/route* $(REPORT_DIR)/sign* $(REPORT_DIR)/chip*  *_map\.* \
               net.acts *.attr .zr* Milkyway.cmd.*_*_*_* Milkyway.log.*_*_*_* \.vers* port_mapping.* pna_output
	##ICC_RM-Info: "make clean" does not remove the design library unless you have specified it with the DESIGN_LIB variable in Makefile"

clean: clean_all
