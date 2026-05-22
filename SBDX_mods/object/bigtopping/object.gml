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
		
		if !sprite_exists(global.spr_bt_bigtoppings) ||global.spr_bt_bigtoppings==0{
			global.spr_bt_bigtoppings=sprite_add(globalmanager.moddir+"object\"+mytype+"\bigtoppings.png",0,1,0,0,0)
		}
		sheet=global.spr_bt_bigtoppings
		depth=1000000
		mask_index=spr_mask32c32
		
	break;
	case "step":
		if (toppingtype!=5 || !gamemanager.kaerublockstate) {
			with instance_place(x,y,player) {
				with other {
					if (give_item(other.id,"bigtopping")) {
						stats("toppings collected",stats("toppings collected")+1)
						//with other sound("itembigtopping")
						with other sound("itemjumprefresh") //temp
						instance_destroy()
					}
				}
			}
	}
	break;
	case "draw":	
		switch toppingtype {
			case 0: draw_sprite_part_ext(sheet,0,4,4,32,32,x,y,1,1,c_white,1) break; 
			case 1: draw_sprite_part_ext(sheet,0,36,4,32,32,x,y,1,1,c_white,1) break;
			case 2: draw_sprite_part_ext(sheet,0,68,4,32,32,x,y,1,1,c_white,1) break;
			case 3: draw_sprite_part_ext(sheet,0,4,36,32,32,x,y,1,1,c_white,1) break;
			case 4 : draw_sprite_part_ext(sheet,0,36,36,32,32,x,y,1,1,c_white,1) break;
			
			case 5 : draw_sprite_part_ext(sheet,0,68,36,32,32,x,y,1,1,c_white,0.25+0.75*(!gamemanager.kaerublockstate)) break; 
		}
	break;
	
	case "lemon_display":
		if !sprite_exists(global.spr_bt_bigtoppings) ||global.spr_bt_bigtoppings==0{
			global.spr_bt_bigtoppings=sprite_add(globalmanager.moddir+"object\"+data[0]+"\bigtoppings.png",0,1,0,0,0)
		}
		sheet=global.spr_bt_bigtoppings
		
		realtype=unreal(data[1],0)
		
		if realtype=0 draw_sprite_part_ext(sheet,0,4.5,4.5,32,32,(x*16+unreal(data[2],0)),(y*16+unreal(data[3],0)),1,1,c_white,1) 
		else draw_sprite_part_ext(sheet,0,68.5,36.5,32,32,(x*16+unreal(data[2],0)),(y*16+unreal(data[3],0)),1,1,c_white,1)

		 
	break;
	case "deloaded":
		if !sprite_exists(global.spr_bt_bigtoppings) ||global.spr_bt_bigtoppings==0{
			//no need to deload anything.	
		}else {
			sprite_delete(global.spr_bt_bigtoppings) global.spr_bigbt_toppings=0
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
            i=show_contextmenu("Topping Type:|-|Normal|Bell",0)
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
			if i=="1" global.cobjectlemonreturnvalue=  "Bell";
			else global.cobjectlemonreturnvalue= "Normal";
		
		}
		
	break;

}