switch(global.cobjectentrypoint){

	case "create":
		friction=0.1
		drop=0
		lok=0
		fresh=1
		
		realtype=unreal(data_1,0)
		x+=unreal(data_2,0)
		y+=unreal(data_3,0)
		
		if realtype=0 {randomize() toppingtype=choose(0,1,2,3,4)}
		else toppingtype=5
		
		if !sprite_exists(global.spr_bt_toppings) ||global.spr_bt_toppings==0{
			global.spr_bt_toppings=sprite_add(globalmanager.moddir+"object\"+mytype+"\toppings.png",0,1,0,0,0)
		}
		sheet=global.spr_bt_toppings
		depth=1000000
		mask_index=spr_mask12x12
		
		x+=8
		y+=8
		
	break;
	case "step":
		if (toppingtype!=5 || !gamemanager.kaerublockstate) {
			with instance_place(x,y,player) {
				with other {
					with other {
						itemget=0
						give_item(id,"topping")
						if itemget=0 topping_get=1
					}
					
					
					stats("toppings collected",stats("toppings collected")+1)
					if toppingtype=5 sound("itemtoppingclock")
					else with other sound("itemtopping")
					instance_destroy()
				}
			}
	}
	break;
	case "draw":	
		switch toppingtype {
			case 0: draw_sprite_part_ext(sheet,0,4,4,16,16,x-8,y-8,1,1,c_white,1) break; 
			case 1: draw_sprite_part_ext(sheet,0,20,4,16,16,x-8,y-8,1,1,c_white,1) break;
			case 2: draw_sprite_part_ext(sheet,0,4,20,16,16,x-8,y-8,1,1,c_white,1) break;
			case 3: draw_sprite_part_ext(sheet,0,20,20,16,16,x-8,y-8,1,1,c_white,1) break;
			case 4 : draw_sprite_part_ext(sheet,0,4,36,16,16,x-8,y-8,1,1,c_white,1) break;
			
			case 5 : draw_sprite_part_ext(sheet,0,20,36,16,16,x-8,y-8,1,1,c_white,0.25+0.75*(!gamemanager.kaerublockstate)) break; 
		}
	break;
	
	case "lemon_display":
		if !sprite_exists(global.spr_bt_toppings) ||global.spr_bt_toppings==0{
			global.spr_bt_toppings=sprite_add(globalmanager.moddir+"object\"+data[0]+"\toppings.png",0,1,0,0,0)
		}
		sheet=global.spr_bt_toppings
		
		realtype=unreal(data[1],0)
		
		if realtype=0 draw_sprite_part_ext(sheet,0,52.5,36.5,16,16,(x*16),(y*16),1,1,c_white,1) 
		else draw_sprite_part_ext(sheet,0,20.5,36.5,16,16,(x*16),(y*16),1,1,c_white,1)

		 
	break;
	case "deloaded":
		if !sprite_exists(global.spr_bt_toppings) ||global.spr_bt_toppings==0{
			//no need to deload anything.	
		}else {
			sprite_delete(global.spr_bt_toppings) global.spr_bt_toppings=0
		}
	
	break;

	case "editobjmenu":
		
		if global.cobjectlemontype>3 {global.cobjectlemonreturnvalue=  "----"}
		
		else if (global.cobjectlemontype=2) {
            global.cobjectlemonreturnvalue=  get_string("Object's X Offset",global.cobjectlemondefault)
		
		}
		else if (global.cobjectlemontype=3) {
            global.cobjectlemonreturnvalue=  get_string("Object's Y Offset",global.cobjectlemondefault)
		
		}
	
		else if (global.cobjectlemontype=1) {
            i=show_contextmenu("Topping Type:|-|Normal|Timer",0)
            if (!i) global.cobjectlemonreturnvalue=  global.cobjectlemondefault
            else global.cobjectlemonreturnvalue=  string(i-1)
		
		
		}
	
	break;
	case "editobjdataname":
		i=global.cobjectlemondefault
		type=global.cobjectlemontype
		if global.cobjectlemontype>3 {global.cobjectlemonreturnvalue= "[NO DATA]"}
		else if type==2{
			global.cobjectlemonreturnvalue="Offset X: " + string(i)
		}else if type==3{
			global.cobjectlemonreturnvalue="Offset Y: " + string(i)
		}else if type==1{
			if i=="1" global.cobjectlemonreturnvalue=  "Timer";
			else global.cobjectlemonreturnvalue= "Normal";
		
		}
		
	break;

}