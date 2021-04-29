onerror {resume}
quietly WaveActivateNextPane {} 0
radix -hexadecimal -showbase

add wave -noupdate -divider Inputs_keyboard
add wave -noupdate -label key_to_press -color "coral" -radix binary  /KBD_tb/key_to_press
add wave -noupdate -label column -color "salmon" -radix binary /KBD_tb/column

add wave -noupdate -divider Outputs_keyboard
add wave -noupdate -label row -color "blue" -radix binary /KBD_tb/row

add wave -noupdate -divider State_keyboard
add wave -noupdate -label s_mode -color "pink" /KBD_tb/s_mode
add wave -noupdate -label key_pressed -color "yellow" /KBD_tb/key_pressed