vlib work

vlog damage.v
vlog drawWhite.v

vsim damage

log {/*}
add wave {/*}

force clock 1 0, 0 500 -repeat 1000 -cancel 100000

#initial states
force {in} 101
force {reset} 0
force {enable_DMG_calc} 0
force {enable_DMG_reg} 0
force {enable_HP_calc} 0
force {enable_draw_decrease} 0
force {enable_decrement_control} 0
run 1ns

#initial states
force {in} 000
force {reset} 1
force {enable_DMG_calc} 0
force {enable_DMG_reg} 1
force {enable_HP_calc} 0
force {enable_draw_decrease} 0
force {enable_decrement_control} 0
run 1ns

#load DMG
force {in} 001
force {reset} 1
force {enable_DMG_calc} 0
force {enable_DMG_reg} 1 
force {enable_HP_calc} 0 
force {enable_draw_decrease} 0
force {enable_decrement_control} 0
run 1ns

#load DMG into the DMG calculator
force {in} 000
force {reset} 1
force {enable_DMG_calc} 1
force {enable_DMG_reg} 0 
force {enable_HP_calc} 0 
force {enable_draw_decrease} 0
force {enable_decrement_control} 0
run 1ns

#load HP 
force {in} 000
force {reset} 1
force {enable_DMG_calc} 0
force {enable_DMG_reg} 0
force {enable_HP_calc} 1 
force {enable_draw_decrease} 0
force {enable_decrement_control} 0
run 1ns

##############################LOOP 1###########################################################

#print white############################
force {in} 000
force {reset} 1
force {enable_DMG_calc} 0
force {enable_DMG_reg} 0
force {enable_HP_calc} 0
force {enable_draw_decrease} 1
force {enable_decrement_control} 0
run 1ns

#decrement###############################
force {in} 000
force {reset} 1
force {enable_DMG_calc} 0
force {enable_DMG_reg} 0
force {enable_HP_calc} 0
force {enable_draw_decrease} 0
force {enable_decrement_control} 1
run 1ns

##############################LOOP 2###########################################################

#print white#############################
force {in} 000
force {reset} 1
force {enable_DMG_calc} 0
force {enable_DMG_reg} 0
force {enable_HP_calc} 0
force {enable_draw_decrease} 1
force {enable_decrement_control} 0
run 1ns

#decrement#################################
force {in} 000
force {reset} 1
force {enable_DMG_calc} 0
force {enable_DMG_reg} 0
force {enable_HP_calc} 0
force {enable_draw_decrease} 0
force {enable_decrement_control} 1
run 1ns

##############################LOOP 3###########################################################

#print white################################
force {in} 000
force {reset} 1
force {enable_DMG_calc} 0
force {enable_DMG_reg} 0
force {enable_HP_calc} 0
force {enable_draw_decrease} 1
force {enable_decrement_control} 0
run 1ns

#decrement#################################
force {in} 000
force {reset} 1
force {enable_DMG_calc} 0
force {enable_DMG_reg} 0
force {enable_HP_calc} 0
force {enable_draw_decrease} 0
force {enable_decrement_control} 1
run 1ns

##############################LOOP 4###########################################################

#print white################################
force {in} 000
force {reset} 1
force {enable_DMG_calc} 0
force {enable_DMG_reg} 0
force {enable_HP_calc} 0
force {enable_draw_decrease} 1
force {enable_decrement_control} 0
run 1ns

#decrement#################################
force {in} 000
force {reset} 1
force {enable_DMG_calc} 0
force {enable_DMG_reg} 0
force {enable_HP_calc} 0
force {enable_draw_decrease} 0
force {enable_decrement_control} 1
run 1ns

#reset back to initial states
force {in} 000
force {reset} 1
force {enable_DMG_calc} 0
force {enable_DMG_reg} 0
force {enable_HP_calc} 0 
force {enable_draw_decrease} 0
force {enable_decrement_control} 0
run 1ns

#reset back to initial states
force {in} 000
force {reset} 1
force {enable_DMG_calc} 0
force {enable_DMG_reg} 0
force {enable_HP_calc} 0 
force {enable_draw_decrease} 0
force {enable_decrement_control} 0
run 1ns

#reset back to initial states
force {in} 000
force {reset} 1
force {enable_DMG_calc} 0
force {enable_DMG_reg} 0
force {enable_HP_calc} 0 
force {enable_draw_decrease} 0
force {enable_decrement_control} 0
run 1ns
