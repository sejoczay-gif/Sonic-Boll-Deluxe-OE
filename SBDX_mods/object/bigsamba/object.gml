switch(global.cobjectentrypoint){

	case "create":
		friction=0.1
		drop=0
		lok=0
		fresh=1

		timeamount=unreal(data_1,0)
		x+=unreal(data_2,0)
		y+=unreal(data_3,0)
		
		if !sprite_exists(global.spr_bt_bigsamba) ||global.spr_bt_bigsamba==0{
			global.spr_bt_bigsamba=sprite_add(globalmanager.moddir+"object\"+mytype+"\bigsamba.png",0,1,0,0,0)
		}
		sheet=global.spr_bt_bigsamba
		
		if !sprite_exists(global.spr_bt_bigsambamask) ||global.spr_bt_bigsambamask==0{
			global.spr_bt_bigsambamask=sprite_add(globalmanager.moddir+"object\"+mytype+"\bigsambamask.png",0,0,0,0,0)
		}
		
		mask_index=global.spr_bt_bigsambamask
		
	break;
	case "step":

	if instance_place(x,y,player) {
		if !dead {
			global.pizzatime=1 
			with other sound("sambahit") //temp
			with other {for (i=0;i<8;i+=1) {regionmarker.typemus="pizzatime"} stagemusic(id,p2)}
			//other.combo+=1
			gamemanager.time=real(timeamount)
			vspeed = random_range(-3, -5) 
			hspeed = (random_range(3, 5)) 
			gravity=0.2 
			dead=1 
			instance_activate_object(konblock)
			instance_activate_object(koffblock)
			with (konblock) alarm[0]=1
			with (koffblock) {alarm[0]=1 owner=global.coll} //koffmo is DEAD!
			gamemanager.kaerublockstate=!gamemanager.kaerublockstate

			with (door) if (is_frogdoor) {frogged=1}
			wait=13
			tpos=1
			global.inf_time=0
			gamemanager.tick=real(timeamount)*60
			global.lap2x=x
			global.lap2y=y
			
			with instance_create(x,y,scriptblock) {
				scriptname="pizzatimeanim"
				event_user(0)
			}
} 

	}

	break;
	case "draw":	
		lookxsc=1
		if instance_exists(player) && !dead {
			lookxsc=sign(player.x-x)   
		}
	
		draw_sprite_part_ext(sheet,0,4+64*dead,4,64,112,x-32*lookxsc+16,y-48,lookxsc,1,c_white,1)
		
	break;
	
	
	case "lemon_display":
		if !sprite_exists(global.spr_bt_bigsamba) ||global.spr_bt_bigsamba==0{
			global.spr_bt_bigsamba=sprite_add(globalmanager.moddir+"object\"+data[0]+"\bigsamba.png",0,1,0,0,0)
		}
		sheet=global.spr_bt_bigsamba
		
		lookxsc=1
		if instance_exists(lemongrab){
			lookxsc=sign(lemongrab.spawnx-x)   
		}
		
		draw_sprite_part_ext(sheet,0,4,4,64,112,(x*16+16)-32*lookxsc+unreal(data[2],0),(y*16)-48,lookxsc+unreal(data[3],0),1,c_white,1)
	break;
	case "deloaded":
		if !sprite_exists(global.spr_bt_bigsamba) ||global.spr_bt_bigsamba==0{
			//no need to deload anything.	
		}else {
			sprite_delete(global.spr_bt_bigsamba) global.spr_bt_bigsamba=0
		}
		
		if !sprite_exists(global.spr_bt_bigsambamask) ||global.spr_bt_bigsambamask==0{
			//no need to deload anything.	
		}else {
			sprite_delete(global.spr_bt_bigsambamask) global.spr_bt_bigsambamask=0
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
            global.cobjectlemonreturnvalue=  get_string("Time to escape:",global.cobjectlemondefault)
		
		
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
			global.cobjectlemonreturnvalue="Timer: " + string(i)
		
		}
		
	break;

}