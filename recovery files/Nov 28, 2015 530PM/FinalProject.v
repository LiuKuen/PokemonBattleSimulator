module FinalProject(CLOCK_50, 
						  KEY, 
						  SW,
						  VGA_CLK,
						  VGA_HS,
						  VGA_VS, 
						  VGA_BLANK_N,
						  VGA_SYNC_N,
						  VGA_R, 
						  VGA_G,
						  VGA_B);
	
	input			CLOCK_50;				//	50 MHz
	input   [9:0]   SW;
	input   [3:0]   KEY;

	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.

	wire [2:0] colour_in;
	wire [8:0] x;
	wire [7:0] y;
	wire writeEn;
	
	wire reset_data;
	
	wire enable_draw_pikachu;
	wire enable_animate_sprite;
	wire enable_pika_qa;
	
	wire enable_draw_meowth_HP;
	wire enable_draw_pikachu_HP;
	wire enable_draw_team_rocket;
	wire enable_draw_trainer;
	wire enable_draw_menu;
	wire enable_draw_team;
	
	wire enable_HP_calc;
	wire enable_DMG_reg;
	wire enable_DMG_calc;
	wire enable_draw_decrease;
	wire enable_decrement_control;
	
	wire enable_draw_meowth;
	wire enable_animate_m_qa;
	wire enable_m_qa;
	
	wire enable_HP_calc_m;
	wire enable_DMG_calc_m;
	wire enable_draw_decrease_m;
	wire enable_decrement_control_m;
	
	wire done_draw_pikachu;
	wire done_animate_sprite;
	wire done_qa;
	
	wire done_meowth_HP;
	wire done_pikachu_HP;
	wire done_team_rocket;
	wire done_trainer;
	wire done_menu;
	wire done_team;
	
	wire done_damage_p;
	wire done_decrement;
	
	wire done_meowth;
	wire done_animate_m_qa;
	wire done_m_qa;
	
	wire done_damage_m;
	wire done_decrement_m;
	
	wire game_over;
	wire game_over_m;
	
	wire [3:0]pick_colour;
	wire [3:0]pick_x_state;
	wire [3:0]pick_y_state;
	
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour_in),
			.x(x),
			.y(y), 
			.plot(writeEn),
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "320x240";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "white.mif";
		
		controlpath control(.clock                             (CLOCK_50), 
								  .quick_attack							 (~KEY[1]),
								  .reset										 (resetn), 
								  .reset_all								 (reset_data),
								  .done_pikachu						    (done_draw_pikachu),
								  .done_animate_qa						 (done_animate_sprite),
								  .done_qa									 (done_qa),
								  .done_meowth_HP							 (done_meowth_HP),
								  .done_pikachu_HP						 (done_pikachu_HP),
								  .done_team_rocket						 (done_team_rocket),
								  .done_trainer							 (done_trainer),
								  .done_menu								 (done_menu),
								  .done_damage_p							 (done_damage_p),
								  .done_decrement_p						 (done_decrement_p),
								  .done_meowth								 (done_meowth),
								  .done_animate_m_qa						 (done_animate_m_qa),
								  .done_m_qa                         (done_m_qa),
								  .done_damage_m                     (done_damage_m ),
								  .done_decrement_m                  (done_decrement_m),
								  .done_team								 (done_team),
								  .game_over								 (game_over),
								  .game_over_m                       (game_over_m),
								  .enable_draw_pika						 (enable_draw_pikachu),
								  .enable_animate_p_qa					 (enable_animate_sprite),
								  .enable_p_qa								 (enable_pika_qa),
								  .enable_draw_meowth_HP				 (enable_draw_meowth_HP),
								  .enable_draw_pikachu_HP				 (enable_draw_pikachu_HP),
								  .enable_draw_team_rocket				 (enable_draw_team_rocket),
								  .enable_draw_trainer					 (enable_draw_trainer), 
								  .enable_draw_menu						 (enable_draw_menu), 
								  .enable_HP_calc							 (enable_HP_calc),
								  .enable_DMG_reg							 (enable_DMG_reg),
								  .enable_DMG_calc						 (enable_DMG_calc),
								  .enable_draw_decrease					 (enable_draw_decrease),
								  .enable_decrement_control			 (enable_decrement_control),
								  .enable_draw_meowth                (enable_draw_meowth),
								  .enable_animate_m_qa               (enable_animate_m_qa),
								  .enable_m_qa                       (enable_m_qa),
								  .enable_HP_calc_m                  (enable_HP_calc_m),
								  .enable_DMG_calc_m                 (enable_DMG_calc_m),
								  .enable_draw_decrease_m            (enable_draw_decrease_m),
								  .enable_decrement_control_m        (enable_decrement_control_m),
								  .enable_draw_team						 (enable_draw_team),
								  .choose_colour							 (pick_colour),
								  .choose_x_mode							 (pick_x_state),
								  .choose_y_mode							 (pick_y_state),
								  .plot										 (writeEn));
								  
		datapath data(.clock											(CLOCK_50),
						  .reset_all									(reset_data), 
						  .enable_draw_pika							(enable_draw_pikachu),
						  .enable_animate_p_qa						(enable_animate_sprite),
						  .enable_p_qa									(enable_pika_qa),
						  .enable_draw_meowth_HP					(enable_draw_meowth_HP),
						  .enable_draw_pikachu_HP					(enable_draw_pikachu_HP),
						  .enable_draw_team_rocket					(enable_draw_team_rocket),
						  .enable_draw_trainer						(enable_draw_trainer),
						  .enable_draw_menu							(enable_draw_menu), 
						  .enable_HP_calc								(enable_HP_calc),
						  .enable_DMG_reg								(enable_DMG_reg),
						  .enable_DMG_calc							(enable_DMG_calc),
						  .enable_draw_decrease						(enable_draw_decrease),
						  .enable_decrement_control				(enable_decrement_control),
						  .enable_draw_meowth                  (enable_draw_meowth),
						  .enable_animate_m_qa                 (enable_animate_m_qa),
						  .enable_m_qa                         (enable_m_qa),
						  .enable_HP_calc_m                    (enable_HP_calc_m),
						  .enable_DMG_calc_m                   (enable_DMG_calc_m ),
						  .enable_draw_decrease_m              (enable_draw_decrease_m),
						  .enable_decrement_control_m          (enable_decrement_control_m),
						  .enable_draw_team							(enable_draw_team),
						  .choose_colour								(pick_colour),
						  .choose_x_mode								(pick_x_state),
						  .choose_y_mode								(pick_y_state),
						  .done_pikachu								(done_draw_pikachu),
						  .done_animate_qa							(done_animate_sprite),
						  .done_qa										(done_qa),
						  .done_meowth_HP								(done_meowth_HP),
						  .done_pikachu_HP							(done_pikachu_HP),
						  .done_team_rocket							(done_team_rocket),
						  .done_trainer								(done_trainer),
						  .done_menu									(done_menu),
						  .done_damage_p								(done_damage_p),
						  .done_decrement_p							(done_decrement_p),
						  .done_meowth								   (done_meowth),
						  .done_animate_m_qa						   (done_animate_m_qa),
						  .done_m_qa                           (done_m_qa),
						  .done_damage_m                       (done_damage_m),
						  .done_decrement_m                    (done_decrement_m),
						  .done_team									(done_team),
						  .game_over									(game_over),
						  .game_over_m                         (game_over_m),
						  .out_x											(x),
						  .out_y											(y),
						  .out_colour									(colour_in));
endmodule

module controlpath(clock,
						 quick_attack, 
						 reset,
						 reset_all,
						 done_pikachu,
						 done_animate_qa,
						 done_qa, 
						 done_meowth_HP,
						 done_pikachu_HP,
						 done_team_rocket,
						 done_trainer,
						 done_menu,
						 done_damage_p,
						 done_decrement_p,
						 done_meowth,
						 done_animate_m_qa,
						 done_m_qa,
						 done_damage_m,
						 done_decrement_m,
						 done_team,
						 game_over,
						 game_over_m,
						 enable_draw_pika, 
						 enable_animate_p_qa, 
						 enable_p_qa,
						 enable_draw_meowth_HP,
						 enable_draw_pikachu_HP,
						 enable_draw_team_rocket,
						 enable_draw_trainer,
						 enable_draw_menu,
						 enable_HP_calc,
						 enable_DMG_reg,
						 enable_DMG_calc,
						 enable_draw_decrease,
						 enable_decrement_control,
						 enable_draw_meowth,
						 enable_animate_m_qa,
						 enable_m_qa,
						 enable_HP_calc_m,
						 enable_DMG_calc_m,
						 enable_draw_decrease_m,
						 enable_decrement_control_m,
						 enable_draw_team,
						 choose_colour,
						 choose_x_mode,
						 choose_y_mode, 
						 plot);
						 
	input clock;
	input reset; //user input signal to reset
	
	input done_pikachu;
	input done_animate_qa;
	input done_qa;
	input done_meowth_HP;
	input done_pikachu_HP;
	input done_team_rocket;
	input done_trainer;
	input done_menu;
	input done_damage_p;
	input done_decrement_p;
	input done_meowth;
	input done_animate_m_qa;
	input done_m_qa;
	input done_damage_m;
	input done_decrement_m;
	input done_team;
	
	input game_over;
	input game_over_m;
	
	input quick_attack;
	
	output reg enable_draw_pika;
	output reg enable_animate_p_qa;
	output reg enable_p_qa;
	output reg enable_draw_meowth_HP;
	output reg enable_draw_pikachu_HP;
	output reg enable_draw_team_rocket;
	output reg enable_draw_trainer;
	output reg enable_draw_menu;
	output reg enable_HP_calc;
	output reg enable_DMG_reg;
	output reg enable_DMG_calc;
	output reg enable_draw_decrease;
	output reg enable_decrement_control;
	output reg enable_draw_meowth;
	output reg enable_animate_m_qa;
	output reg enable_m_qa;
	output reg enable_HP_calc_m;
	output reg enable_DMG_calc_m;
	output reg enable_draw_decrease_m;
	output reg enable_decrement_control_m;
	output reg enable_draw_team;
	
	output reg [3:0]choose_colour;
	output reg [3:0]choose_x_mode;
	output reg [3:0]choose_y_mode;
	
	output reg reset_all; //tells datapath to reset all
	output reg plot;
	
	reg [5:0] presentstate;
	reg [5:0] nextstate;
	
	//game_over_m
	//done_damage_m, done_decrement_m
	//enable_HP_calc_m, enable_DMG_calc_m, enable_draw_decrease_m, enable_decrement_control_m;
	
	//p_qa = pikachu quick attack
	parameter [5:0] reset_state 				= 6'b000000,
						 draw_pikachu 				= 6'b000001, 
						 draw_hp_meowth 			= 6'b000010, 
						 draw_hp_pikachu 			= 6'b000011,
						 draw_team_rocket 		= 6'b000100,
						 draw_trainer 				= 6'b000101,
						 draw_menu 					= 6'b000110,
						 draw_meowth 				= 6'b000111,
						 draw_team					= 6'b001000,
						 
						 draw_pikachu_qa 			= 6'b001001,
						 idle_p_qa 					= 6'b001010,
						 erase_pikachu_qa 		= 6'b001011,
						 p_qa 						= 6'b001100,
						 
						 calculate_dmg 			= 6'b001101,
						 update_HP 					= 6'b001110,
						 erase_HP_meowth 			= 6'b001111,
						 decrement_HP_pos 		= 6'b010000,
						 
						 battle_idle				= 6'b010001,
						 
						 draw_meowth_qa 			= 6'b010010,
						 idle_m_qa 					= 6'b010011,
						 erase_meowth_qa 			= 6'b010100,
						 m_qa 						= 6'b010101,
						 
						 calculate_dmg_m 			= 6'b010110,
						 update_HP_m 				= 6'b010111,
						 erase_HP_pikachu 		= 6'b011000,
						 decrement_HP_pos_m     = 6'b011001,
						 
						 /*
						 draw_pikachu_tb			=,
						 draw_tb_1					=,
						 idle_tb_1					=,
						 draw_tb_2					=,
						 idle_tb_2					=,
						 draw_tb_3					=,
						 idle_tb_3					=,
						 erase_tb					=,
						 re_draw_pikachu_tb		=,*/
						 
						 idle 						= 6'b011010,
						 game_finished 			= 6'b011011; 
	
	always @(*)
	case(presentstate)
		reset_state:
			begin
				nextstate <= draw_pikachu;
			end
		//DRAW BATTLE SCENE #######################################
		draw_pikachu:
			begin
			//done_pikachu tells me that I am done printing pikachu
				if(done_pikachu == 1)
					nextstate <= draw_hp_meowth;
				else
					nextstate <= draw_pikachu;
			end
		draw_hp_meowth:
			begin
				if(done_meowth_HP == 1)
					nextstate <= draw_hp_pikachu;
				else
					nextstate <= draw_hp_meowth;
			end
		draw_hp_pikachu:
			begin
				if(done_pikachu_HP == 1) //done_pikachu_HP == 1
					nextstate <= draw_team_rocket;
				else
					nextstate <= draw_hp_pikachu;
			end
		draw_team_rocket:
			begin
				if(done_team_rocket == 1)
					nextstate <= draw_trainer;
				else
					nextstate <= draw_team_rocket;
			end
		draw_trainer:
			begin
				if(done_trainer == 1)
					nextstate = draw_menu;
				else
					nextstate = draw_trainer;
			end
		draw_menu:
			begin
				if(done_menu == 1)
					nextstate <= draw_meowth;
				else
					nextstate <= draw_menu;
			end
		draw_meowth:
			begin
				if(done_meowth == 1)
					nextstate <= draw_team;
				else
					nextstate <= draw_meowth;
			end
		draw_team:
			begin
				if(done_team == 1)
					nextstate <= idle;
				else
					nextstate <= draw_team;
			end
		//QUICK ATTACK LOOP#####################################
		draw_pikachu_qa:
			begin
				if(done_pikachu == 1)
					nextstate <= idle_p_qa;
				else
					nextstate <= draw_pikachu_qa;
			end
		idle_p_qa: 
			begin
				if(done_qa == 1)
					nextstate <= calculate_dmg;
				else if(done_animate_qa == 1)
					nextstate <= erase_pikachu_qa;
				else
					nextstate <= idle_p_qa;
			end
		erase_pikachu_qa:
			begin
				if(done_pikachu == 1)
					nextstate <= p_qa;
				else
					nextstate <= erase_pikachu_qa;
			end
		p_qa:
			begin
				nextstate <= draw_pikachu_qa;
			end
		//DAMAGE LOOP ###########################################
		calculate_dmg:
			begin
				nextstate <= update_HP;
			end
		update_HP:
			begin
				nextstate <= erase_HP_meowth;
			end
		erase_HP_meowth:
			begin
				if(done_damage_p == 1)
					nextstate <= decrement_HP_pos;
				else if(done_decrement_p == 1)
					nextstate <= battle_idle;
				else
					nextstate <= erase_HP_meowth;
			end
		decrement_HP_pos:
			begin
					nextstate <= erase_HP_meowth;
			end
		//BATTLE IDLE ############################################
		battle_idle:
			begin
				if(done_qa == 1)
					nextstate <= draw_meowth_qa;
				else
					nextstate <= battle_idle;
			end
		//MEOWTH ATTACK LOOP #####################################
		draw_meowth_qa:
			begin
				if(done_meowth == 1)
					nextstate <= idle_m_qa;
				else
					nextstate <= draw_meowth_qa;
			end
		idle_m_qa:
			begin
				if(game_over == 1)
					nextstate <= game_finished;
				else if(done_m_qa == 1)
					nextstate <= calculate_dmg_m;
				else if(done_animate_m_qa == 1)
					nextstate <= erase_meowth_qa;
				else 
					nextstate <= idle_m_qa;
			end
		erase_meowth_qa:
			begin
				if(done_meowth == 1)
					nextstate <= m_qa;
				else
					nextstate <= erase_meowth_qa;
			end
		m_qa:
			begin
				nextstate <= draw_meowth_qa;
			end
		//MEOWTH DAMAGE LOOP #####################################
		calculate_dmg_m:
			begin
				nextstate <= update_HP_m;
			end
		update_HP_m:
			begin
				nextstate <= erase_HP_pikachu;
			end
		erase_HP_pikachu:
			begin
				if(done_damage_m == 1)
					nextstate <= decrement_HP_pos_m;
				else if(done_decrement_m == 1)
					nextstate <= idle;
				else
					nextstate <= erase_HP_pikachu;
			end
		decrement_HP_pos_m:
			begin
				nextstate <= erase_HP_pikachu;
			end
		//IDLES ##################################################
		idle: // waits for something to happen
			begin
				if(game_over == 1 || game_over_m == 1)
					begin
						nextstate <= game_finished;
					end
				else if(quick_attack == 1)
					nextstate <= draw_pikachu_qa;
				else
					nextstate <= idle;
			end
		game_finished:
			begin
				nextstate <= game_finished;
			end
	endcase
	
	always @(posedge clock)
	begin
		if(reset == 0)
			presentstate <= reset_state;
		else
			presentstate <= nextstate;
	end
	
	always @(*)
	case(presentstate)
		reset_state:
			begin
				reset_all = 0;
				enable_draw_pika = 0;
	         enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00000;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 0;
			end
		//DRAWS THE BEGINNING####################################################
		draw_pikachu:
			begin
				reset_all = 1;
				enable_draw_pika = 1;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00000;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 1;
			end
		draw_hp_meowth:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 1;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00010;
				choose_x_mode = 5'b00001;
				choose_y_mode = 5'b00001;
				plot = 1;
			end
		draw_hp_pikachu:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 1;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00011;
				choose_x_mode = 5'b00010;
				choose_y_mode = 5'b00010;
				plot = 1;
			end
		draw_team_rocket:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 1;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00100;
				choose_x_mode = 5'b00011;
				choose_y_mode = 5'b00011;
				plot = 1;
			end
		draw_trainer:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 1;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00101;
				choose_x_mode = 5'b00100;
				choose_y_mode = 5'b00100;
				plot = 1;
			end
		draw_menu: 
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 1;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00110; 
				choose_x_mode = 5'b00110;
				choose_y_mode = 5'b00110;
				plot = 1;
			end
		draw_meowth:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 1;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00111; 
				choose_x_mode = 5'b00111;
				choose_y_mode = 5'b00111;
				plot = 1;
			end
		draw_team:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 1;
				choose_colour = 5'b01000; 
				choose_x_mode = 5'b01001;
				choose_y_mode = 5'b01001;
				plot = 1;
			end
		//QUICK ATTACK LOOP##################################################################
		draw_pikachu_qa:
			begin
				reset_all = 1;
				enable_draw_pika = 1;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00000;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 1;
			end
		idle_p_qa: 
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 1;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 1;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00000;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 0;
			end
		erase_pikachu_qa:
			begin
				reset_all = 1;
				enable_draw_pika = 1;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00001;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 1;
			end
		p_qa:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 1;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00000;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 0;
			end
		//DAMAGE LOOP ##########################################
		calculate_dmg:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 1;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00000;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 0;
			end
		update_HP:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 1;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00000;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 0;
			end
		erase_HP_meowth:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 1;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00001;
				choose_x_mode = 5'b00101;
				choose_y_mode = 5'b00101;
				plot = 1;
			end
		decrement_HP_pos:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 1;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00001;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 0; //change this back
			end
		//BATTLE_IDLE ###########################################
		battle_idle:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 1;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 1;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00000;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 0;
			end
		//MEOWTH ATTACK LOOP ##########################################
		draw_meowth_qa:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 1;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00111;
				choose_x_mode = 5'b00111;
				choose_y_mode = 5'b00111;
				plot = 1;
			end
		idle_m_qa: 
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 1;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 1;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00000;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 0;
			end
		erase_meowth_qa:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 1;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00001;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 1;
			end
		m_qa:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 1;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00000;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 0;
			end
		//MEOWTH DAMAGE LOOP ########################################
		calculate_dmg_m:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 1;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00000;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 0;
			end
		update_HP_m:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 1;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00000;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 0;
			end
		erase_HP_pikachu:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 1;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00001;
				choose_x_mode = 5'b01000;
				choose_y_mode = 5'b01000;
				plot = 1;
			end
		decrement_HP_pos_m:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 1;
				enable_draw_team = 0;
				choose_colour = 5'b00000;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 0;
			end
		//PLAYER IDLE ###############################################
		idle:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00000;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 0;
			end
		// GG NO RE
		game_finished:
			begin
				reset_all = 1;
				enable_draw_pika = 0;
				enable_animate_p_qa = 0;
				enable_p_qa = 0;
				enable_draw_meowth_HP = 0;
				enable_draw_pikachu_HP = 0;
				enable_draw_team_rocket = 0;
				enable_draw_trainer = 0;
				enable_draw_menu = 0;
				enable_HP_calc = 0;
				enable_DMG_reg = 0;
				enable_DMG_calc = 0;
				enable_draw_decrease = 0;
				enable_decrement_control = 0;
				enable_draw_meowth = 0;
				enable_animate_m_qa = 0;
				enable_m_qa = 0;
				enable_HP_calc_m = 0;
				enable_DMG_calc_m = 0;
				enable_draw_decrease_m = 0;
				enable_decrement_control_m = 0;
				enable_draw_team = 0;
				choose_colour = 5'b00000;
				choose_x_mode = 5'b00000;
				choose_y_mode = 5'b00000;
				plot = 0;
			end
	endcase
endmodule

//DATAPATH
module datapath(clock,
					 reset_all,
					 enable_draw_pika,
					 enable_animate_p_qa,
					 enable_p_qa,
					 enable_draw_meowth_HP,
					 enable_draw_pikachu_HP,
					 enable_draw_team_rocket,
					 enable_draw_trainer,
					 enable_draw_menu,
					 enable_HP_calc,
					 enable_DMG_reg,
					 enable_DMG_calc,
					 enable_draw_decrease,
					 enable_decrement_control,
					 enable_draw_meowth,
					 enable_animate_m_qa,
					 enable_m_qa,
					 enable_DMG_calc_m,
					 enable_HP_calc_m,
					 enable_draw_decrease_m,
					 enable_decrement_control_m,
					 enable_draw_team,
					 choose_colour,
					 choose_x_mode, 
					 choose_y_mode,
					 done_pikachu,
					 done_animate_qa,
					 done_qa,
					 done_meowth_HP,
					 done_pikachu_HP,
					 done_team_rocket,
					 done_trainer,
					 done_menu,
					 done_damage_p,
					 done_decrement_p,
					 done_meowth,
					 done_animate_m_qa,
					 done_m_qa,
					 done_damage_m,
					 done_decrement_m,
					 done_team,
					 game_over,
					 game_over_m,
					 out_x, 
					 out_y,
					 out_colour);
					 
	input clock;
	input reset_all;
	
	input enable_draw_pika;
	input enable_animate_p_qa;
	input enable_p_qa;
	
	input enable_draw_meowth_HP;
	
	input enable_draw_pikachu_HP;
	
	input enable_draw_team_rocket;
	
	input enable_draw_trainer;
	
	input enable_draw_menu;
	
	input enable_draw_team;
	
	input enable_HP_calc;
	input enable_DMG_reg;
	input enable_DMG_calc;
	input enable_draw_decrease;
	input enable_decrement_control;
	
	input enable_HP_calc_m;
	input enable_DMG_calc_m;
	input enable_draw_decrease_m;
	input enable_decrement_control_m;
	
	input enable_draw_meowth;
	input enable_animate_m_qa;
	input enable_m_qa;
	
	input [4:0]choose_colour;//change the size of this as we add more modules
	input [4:0]choose_x_mode;//change the size of this as we add more modules
	input [4:0]choose_y_mode;//change the size of this as we add more modules
	
	output done_pikachu;
	output done_animate_qa;
	output done_qa;
	output done_meowth_HP;
	output done_pikachu_HP;
	output done_team_rocket;
	output done_trainer;
	output done_menu;
	output done_damage_p;
	output done_decrement_p;
	output done_meowth;
	output done_animate_m_qa;
	output done_m_qa;
	output done_damage_m;
	output done_decrement_m;
	output done_team;
	
	output game_over;
	output game_over_m; // meowth wins
	
	output [8:0]out_x;
	output [7:0]out_y;
	output [2:0]out_colour;
	
	wire [8:0]draw_pika_x;
	wire [7:0]draw_pika_y;
	wire [2:0]draw_pika_colour;
	
	wire [8:0]draw_meowth_HP_x;
	wire [7:0]draw_meowth_HP_y;
	wire [2:0]draw_meowth_HP_colour;
	
	wire [8:0]draw_pikachu_HP_x;
	wire [7:0]draw_pikachu_HP_y;
	wire [2:0]draw_pikachu_HP_colour;
	
	wire [8:0]draw_team_rocket_x;
	wire [7:0]draw_team_rocket_y;
	wire [2:0]draw_team_rocket_colour;
	
	wire [8:0]draw_trainer_x;
	wire [7:0]draw_trainer_y;
	wire [2:0]draw_trainer_colour;
	
	wire [8:0]draw_menu_x;
	wire [7:0]draw_menu_y;
	wire [2:0]draw_menu_colour;
	
	wire [8:0]draw_meowth_x;
	wire [7:0]draw_meowth_y;
	wire [2:0]draw_meowth_colour;
	
	wire [8:0]draw_team_x;
	wire [7:0]draw_team_y;
	wire [2:0]draw_team_colour;
	
	wire p_qa_right;
	
	wire [2:0]move_input;
	assign move_input[0] = done_qa;
	assign move_input[1] = 0; // we'll change these later based on whether tb is on
	assign move_input[2] = 0; // we'll change these later based on whether vt is on
	wire [8:0]erase_HP_meowth_x;
	wire [7:0]erase_HP_meowth_y;
	
	wire [8:0]erase_HP_pikachu_x;
	wire [7:0]erase_HP_pikachu_y;
	
	//52x56
	quick_attack attack_one(.clock(clock), 
									.reset_all(reset_all), 
									.enable_animate(enable_animate_p_qa), 
									.enable_p_qa(enable_p_qa), 
									.enable_draw_pika(enable_draw_pika), //remember that this module will also draw pikachu from the very beggining
									.done_animate(done_animate_qa), 
									.done_pikachu(done_pikachu),
									.p_qa_x(draw_pika_x), 
									.p_qa_y(draw_pika_y), 
									.p_qa_colour(draw_pika_colour),
									.done_quick_attack(done_qa));
	
	meowth_attack enemy_attack(.clock(clock), 
									   .reset_all(reset_all),
									   .enable_animate(enable_animate_m_qa),
									   .enable_m_qa(enable_m_qa),
									   .enable_draw_meowth(enable_draw_meowth),
									   .done_animate(done_animate_m_qa),
									   .done_meowth(done_meowth),
									   .m_qa_x(draw_meowth_x), 
									   .m_qa_y(draw_meowth_y),
									   .m_qa_colour(draw_meowth_colour),
									   .done_quick_attack(done_m_qa));
							
	
	//draws the static pictures									  
	drawHP meowth_HP(.x_(9'b000000000),
						  .y_(8'b00000000),
						  .clock_all(clock), 
						  .enable_all(enable_draw_meowth_HP), 
						  .reset_all(reset_all), 
						  .done(done_meowth_HP),
						  .out_x(draw_meowth_HP_x), 
						  .out_y(draw_meowth_HP_y), 
					     .out_colour(draw_meowth_HP_colour));
						  
	drawHP pikachu_HP(.x_(9'b010110100), // 179 - 010110100
							.y_(8'b01110111), // 115 - 01110111
						   .clock_all(clock), 
						   .enable_all(enable_draw_pikachu_HP), 
						   .reset_all(reset_all), 
						   .done(done_pikachu_HP),
						   .out_x(draw_pikachu_HP_x), 
						   .out_y(draw_pikachu_HP_y), 
					      .out_colour(draw_pikachu_HP_colour));
	
	//70x71
	drawTeamRocket team_rocket(.x_(9'b011111000), // 254 - 011111000
										.y_(8'b00101000), // 45 -  00101000
										.clock_all(clock), 
										.enable_all(enable_draw_team_rocket),
										.reset_all(reset_all),
										.done(done_team_rocket),
										.out_x(draw_team_rocket_x),
										.out_y(draw_team_rocket_y),
										.out_colour(draw_team_rocket_colour));
	
	//63x59
	drawTrainer trainer(.x_(9'b000000000), // 0
							  .y_(8'b01011101), // 93
							  .clock_all(clock), 
							  .enable_all(enable_draw_trainer),
							  .reset_all(reset_all),
							  .done(done_trainer),
							  .out_x(draw_trainer_x),
							  .out_y(draw_trainer_y),
							  .out_colour(draw_trainer_colour));						  
							  
	//158x85
	drawAttackMenu Menu(.x_(9'b010100000), // 160
							  .y_(8'b10011011),  // 155
							  .clock_all(clock),
							  .enable_all(enable_draw_menu), 
							  .reset_all(reset_all), 
							  .done(done_menu), 
							  .out_x(draw_menu_x), 
							  .out_y(draw_menu_y), 
							  .out_colour(draw_menu_colour));
							  
	//158x85
	drawTeam team_menu(.x_(9'b000000010), //2
							 .y_(8'b10011011), //155
							 .clock_all(clock),
							 .enable_all(enable_draw_team), 
							 .reset_all(reset_all), 
							 .done(done_team), 
							 .out_x(draw_team_x), 
							 .out_y(draw_team_y), 
							 .out_colour(draw_team_colour));

	//deals damage against meowth
	damage_pika pika_damage(.in(move_input), // input of the damages;
									.clock(clock),
									.reset(reset_all),
									.enable_HP_calc(enable_HP_calc),
									.enable_DMG_reg(enable_DMG_reg), 
									.enable_DMG_calc(enable_DMG_calc),
									.enable_draw_decrease(enable_draw_decrease),
									.enable_decrement_control(enable_decrement_control),
									.done_damage(done_damage_p),
									.done_decrement(done_decrement_p),
									.game_over(game_over),
									.out_x(erase_HP_meowth_x),
									.out_y(erase_HP_meowth_y)); 
	
	//deals damage against pikachu
	damage_meowth meowth_damage(.clock(clock),
										 .reset(reset_all),
										 .enable_HP_calc(enable_HP_calc_m),
										 .enable_DMG_calc(enable_DMG_calc_m),
										 .enable_draw_decrease(enable_draw_decrease_m),
										 .enable_decrement_control(enable_decrement_control_m),
										 .done_damage(done_damage_m),
										 .done_decrement(done_decrement_m),
										 .game_over(game_over_m),
										 .out_x(erase_HP_pikachu_x),
										 .out_y(erase_HP_pikachu_y));
	
	choose_y y(.in1(draw_pika_y), // 0000
				  .in2(draw_meowth_HP_y), // 0001
				  .in3(draw_pikachu_HP_y), // 0010
				  .in4(draw_team_rocket_y), // 0011
				  .in5(draw_trainer_y), //0100
				  .in6(erase_HP_meowth_y), //0101
				  .in7(draw_menu_y), //0110
				  .in8(draw_meowth_y), //0111
				  .in9(erase_HP_pikachu_y), //1000
				  .in10(draw_team_y), //1001
				  .choose(choose_y_mode),
				  .out_y(out_y)); // output y
				  
	choose_x x(.in1(draw_pika_x), // 0000
				  .in2(draw_meowth_HP_x), // 0001
				  .in3(draw_pikachu_HP_x), // 0010
				  .in4(draw_team_rocket_x), // 0011
				  .in5(draw_trainer_x), //0100
				  .in6(erase_HP_meowth_x), //0101
				  .in7(draw_menu_x), //0110
				  .in8(draw_meowth_x), //0111
				  .in9(erase_HP_pikachu_x), //1000
				  .in10(draw_team_x), //1001
				  .choose(choose_x_mode), 
				  .out_x(out_x)); // output x
				  
	choose_c colour(.in1(draw_pika_colour), //colour for drawing pikachu 0000
					    .in2(3'b111), //colour for erasing pikachu 0001 and for dealing damage 
						 .in3(draw_meowth_HP_colour), //colour for meowth_HP 0010 
						 .in4(draw_pikachu_HP_colour), //colour for meowth_HP 0011
						 .in5(draw_team_rocket_colour), //0100
						 .in6(draw_trainer_colour), // 0101
						 .in7(draw_menu_colour), //0110
						 .in8(draw_meowth_colour), //0111
						 .in9(draw_team_colour), //1000
					    .choose(choose_colour), 
					    .out(out_colour));	 
endmodule

//ANIMATION_TIMER
module animation_frame(clock,
							  reset,	
							  enable, 
							  out_pulse);
	input clock;
	input reset;
	input enable;
	
	output out_pulse;

	wire count_pulse;
	
	fifteen_hz_counter done_fifteen(.pulse(count_pulse),
											  .clock(clock),
										     .reset(reset), 
											  .enable_fifteen(enable),
											  .out(out_pulse));
											  
	sixty_hz_clock	sixty_hz(.clock(clock), 
									.reset(reset), 
									.enable_sixty(enable),
									.pulse(count_pulse));
endmodule

//FIFTEEN_HZ_COUNTER
module fifteen_hz_counter(pulse, clock, reset, enable_fifteen, out);
	input pulse;
	input reset;
	input enable_fifteen;
	input clock;
	
	output out;
	
	reg [3:0]counter;
	
	assign out = (counter == 4'b1111)?1:0;
	
	always @(posedge clock)
	begin
		if(reset == 1 && enable_fifteen == 1)
			begin
				if(counter == 4'b1111)
					counter = 0;
				else if(pulse == 1)
					counter = counter + 1;
			end
		else if(reset == 0 || enable_fifteen == 0)
			counter = 0;
	end
endmodule

//SIXTY_HZ_CLOCK
module sixty_hz_clock(clock, reset, enable_sixty, pulse);
	input clock;
	input reset;
	input enable_sixty;
	
	output pulse;
	
	reg [14:0]rate; //change this back to 19:0
	
	assign pulse = (rate == 0)?1:0;
	
	always @(posedge clock)
	begin
		if(reset == 1 && enable_sixty == 1)
			begin
				if(rate == 0)
					rate = 15'b110000110101000; // change this value later to 20'b11001011011100110101
				else	
					rate = rate - 1;
			end
		else if(reset == 0 || enable_sixty == 0)
			begin
				rate = 15'b110000110101000;
			end
	end
endmodule

//Y MUX
module choose_y(in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, choose, out_y); //we will add more stuff later
	input [7:0]in1;
	input [7:0]in2;
	input [7:0]in3;
	input [7:0]in4;
	input [7:0]in5;
	input [7:0]in6;
	input [7:0]in7;
	input [7:0]in8;
	input [7:0]in9;
	input [7:0]in10;
	input [4:0]choose;
	
	output reg [7:0]out_y;
	
	always @(*)
		case(choose)
			5'b00000: out_y = in1;
			5'b00001: out_y = in2;
			5'b00010: out_y = in3;
			5'b00011: out_y = in4;
			5'b00100: out_y = in5;
			5'b00101: out_y = in6;
			5'b00110: out_y = in7;
			5'b00111: out_y = in8;
			5'b01000: out_y = in9;
			5'b01001: out_y = in10;
			default out_y = in1;
		endcase
endmodule

//X MUX
module choose_x(in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, choose, out_x); //we will add more stuff later
	input [8:0]in1;
	input [8:0]in2;
	input [8:0]in3;
	input [8:0]in4;
	input [8:0]in5;
	input [8:0]in6;
	input [8:0]in7;
	input [8:0]in8;
	input [8:0]in9;
	input [8:0]in10;
	input [4:0]choose;
	
	output reg [8:0]out_x;
	
	always @(*)
		case(choose)
			5'b00000: out_x = in1;
			5'b00001: out_x = in2;
			5'b00010: out_x = in3;
			5'b00011: out_x = in4;
			5'b00100: out_x = in5;
			5'b00101: out_x = in6;
			5'b00110: out_x = in7;
			5'b00111: out_x = in8;
			5'b01000: out_x = in9;
			5'b01001: out_x = in10;
			default out_x = in1;
		endcase
endmodule

//COLOUR MUX
module choose_c(in1, in2, in3, in4, in5, in6, in7, in8, in9, choose, out);//we will make this bigger as we add more characters
	input [2:0]in1;
	input [2:0]in2;
	input [2:0]in3;
	input [2:0]in4;
	input [2:0]in5;
	input [2:0]in6;
	input [2:0]in7;
	input [2:0]in8;
	input [2:0]in9;
	input [4:0]choose;
	
	output reg [2:0]out;
	
	always @(choose)
		case(choose)
			5'b00000: out = in1;
			5'b00001: out = in2;
			5'b00010: out = in3;
			5'b00011: out = in4;
			5'b00100: out = in5;
			5'b00101: out = in6;
			5'b00110: out = in7;
			5'b00111: out = in8;
			5'b01000: out = in9;
			default out = in1;
		endcase
endmodule

//ADDER
module adder_y(in1_y, in2_y, out_y);
	input [7:0]in1_y;
	input [7:0]in2_y; // actually lets just use 8bit and fill it with zeros
	output [7:0]out_y; 
	
	assign out_y = in1_y + in2_y;
endmodule

//ADDER
module adder_x(in1_x, in2_x, out_x);
	input [8:0]in1_x;
	input [8:0]in2_x; // we'll just use 8bit and fill it with zeros
	output [8:0]out_x;
	
	assign out_x = in1_x + in2_x;
endmodule

// we will implement this later
module white_out(enable_wht, reset, clock_wht, done, enable, out_x, out_y);
	input enable_wht;
	input clock_wht;
	input reset_wht;
	
	//wire y_clock;
	
	output reg [8:0]out_x;
	output reg [7:0]out_y;
	output reg done;
	
	always @(posedge clock_wht)
	begin
		if(reset == 1)
		begin
			out_x <= 0;
			out_y <= 0;
		end
		else if(out_x == 9'b010100000)
		begin
			out_x <= 0;
			out_y <= out_y + 1;
		end
		else if(enable_wht == 1)
			out_x <= out_x + 1;
		if(wht_y == 8'b01111000)
			done = 1;
	end
endmodule