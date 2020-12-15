onerror {quit -f}
vlib work
vlog -work work computer.vo
vlog -work work computer.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.computer_vlg_vec_tst
vcd file -direction computer.msim.vcd
vcd add -internal computer_vlg_vec_tst/*
vcd add -internal computer_vlg_vec_tst/i1/*
add wave /*
run -all
