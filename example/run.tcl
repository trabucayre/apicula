# gw_sh run.tcl
exec yosys -p "synth_gowin -top top -vout example_syn.v" example.v
#add_file -cst littlebee/cpu/src/cpu.cst
#add_file -sdc littlebee/cpu/src/cpu.sdc
add_file -vm example_syn.v
#add_file -cfg littlebee/cpu/impl/pnr/device.cfg
set_option -device GW1NR-9-QFN88-6
set_option -pn GW1NR-LV9QN88C6/I5
run_pnr
# -opt littlebee/cpu/impl/pnr/pnr.cfg
exec python ../gowin_unpack.py /home/pepijn/bin/gowin/IDE/share/device/GW1NR-9/GW1NR-9.fse impl/pnr/example_syn.fs
exec yosys -p "proc; show -format png -prefix original" example.v
exec yosys -p "read_verilog -lib +/gowin/cells_sim.v; show -format png -prefix post_syn" example_syn.v
exec yosys -p "read_verilog -lib +/gowin/cells_sim.v; show -format png -prefix post_pnr" unpack.v
