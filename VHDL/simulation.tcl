#!/usr/bin/tclsh
quit -sim

# Clear the transcript window
.main clear

set DIR_ROOT "."

exec vlib work

set vhdls [list \
	"$DIR_ROOT/KBD.vhd" \
	"$DIR_ROOT/KBD_tb.vhd" \
	]
	
foreach src $vhdls {
	if [expr {[string first # $src] eq 0}] {puts $src} else {
		vcom -2008 -work work $src
	}
}

vsim -voptargs=+acc work.KBD_tb
do wave.do
run 16 us

 
