switch(global.cobjectentrypoint){

	case "create":
		if !global.__bt_untower {
			object_event_add(globalmanager,ev_room_start,0,"if room!=game global.TOWER=0")
			global.__bt_untower=1
		}
	
		global.inf_time=1
		settings("cog inflives",1)
		skindat("hurry",0)
		skindat("hurrytime",-1)

		global.TOWER=1
		global.pizzatime=0
		global.bollface=noone

		timer=1

		if !(global.lemontest) || (global.lemonfilename == "") {
			wskin = global.lskins[global.levelskin+1,0]
			if (wskin == "") {
				wskin = global.lbase
			}
			wskin = globalmanager.moddir + wskin
		} else {
			wskin = filename_path(global.lemonfilename);
		}
		
		wskin=wskin+global.levelfname+'\'
		
		
		//look im desperate
		for (k=0;k<2;k+=1) {
			
			if k=0 typemus="pizzatime"
			else if k=1 typemus="lap2"
			else if k=2 typemus="lap3"

			//show_message("adding music "+typemus)
			with regionmarker {
				i=0
				prevmus=typemus
				typemus=other.typemus
				repeat (8) {
					//Custom Music
					with (globalmanager) {
						if !ds_map_exists(mushandles, other.typemus) {
							musc+=1 mload[musc]=other.typemus
							musc+=1 mload[musc]=other.typemus+"fast"
							ds_map_add(mushandles, other.typemus, 0)
							ds_map_add(mushandles, other.typemus+"_filename", 0)
						}
						if (string(global.lemonlskin) != "" && string(global.lemonlskin) != "None") {
							if (!replacemusic(other.typemus, global.lemonlskin+"\music\"))
								if (!replacemusic(other.typemus))
									replacemusic(other.typemus, global.wbase+"\music\")
						} else if (string(global.exception) != "" && string(global.exception) != "0") {
							if (!replacemusic(other.typemus, global.exceptdir+"\music\"))
								if (!replacemusic(other.typemus))
									replacemusic(other.typemus, global.wbase+"\music\")
						} else if (!replacemusic(other.typemus))
							replacemusic(other.typemus, global.wbase+"\music\")
					}
					typemus=prevmus
					i+=1
				}
			}

		}
		
		replacesound("itemtoppingclock",wskin+"sfx\bellcollectsmall.ogg")
		replacesound("itemtoppingbell",wskin+"sfx\bellcollectbig.ogg")
		replacesound("itemtreasure",wskin+"sfx\treasurefind.wav")
		replacesound("itembigtopping",wskin+"sfx\sfx_collectpizza.ogg")
		replacesound("itemtreasure",wskin+"sfx\sfx_collectgiantpizza.ogg")
		replacesound("itemtopping",wskin+"sfx\itemtopping.wav")
		replacesound("itemtoppin",wskin+"sfx\itemtoppin.wav")
		replacesound("secretfound",wskin+"sfx\secretfound.wav")
		replacesound("sambahit",wskin+"sfx\itemsambahit.wav")
		replacesound("metalbreak",wskin+"sfx\metalbreak.wav")
		replacesound("entrance",wskin+"sfx\entrance.wav")
	
		
		//temp
		with instance_create(x,y,scriptblock) {
			scriptname="charmodifiers"
			event_user(0)
		}
		
		with instance_create(x,y,scriptblock) {
				scriptname="samblockdrawer"
				event_user(0)
			}
		
	break;
	case "step":
		gamemanager.sekiro=1
		skindat("hurry",0)
		skindat("hurrytime",-1)
	
		//optimizer
		timer-=1
		if timer<0 {
			timer=5
			with customobject{
				if mytype="topping" || mytype="bigtopping" || (mytype="toppinfollower" && !imfollow) || mytype="entrancedoor"
				if !inview() instance_deactivate_object(self.id)
			
			}
		}

		//sync both timers if escape sequence is active
		if global.pizzatime {
			gamemanager.time=gamemanager.frog_escape_timer/60
			gamemanager.tick=gamemanager.frog_escape_timer
			player.tick=gamemanager.frog_escape_timer
		}

		if global.pizzatime && gamemanager.tick=0 && !player.finish {
		if global.bollface=0 || global.bollface=-4
		with instance_create(player.x,player.y,scriptblock) {
			scriptname="bollface_pursuit"
			global.bollface=id
			event_user(0)
		}
	}

	with (warpbox) with instance_place(x,y,player) with other {
		if string(target)=="Lap2" && global.pizzatime && mylap2<1{
			/*Do all the funny Lap 2 effects and shit*/
			if !mylap2 && !t
			t=instance_create(global.lap2x,global.lap2y,warpbox){t.visible=0 t.iamlap2=1 t.name="Lap2" with t getregion(x)}
			mylap2+=1
			t.mylap2=mylap2
			
			global.pizzatime+=1
			with other {regionmarker.typemus="lap2"} 
			gamemanager.frog_escape_timer=0
			with instance_create(x,y,scriptblock) {
				scriptname="pizzatimeanim"
				lap2=1
				event_user(0)
			}
			depth=other.depth-1
			with other {
				gamemanager.frog_escape=0
				stagemusic(id,p2)
				gamemanager.frog_escape=1
				set_sprite("roll")
				piped=1
				pipeid=other.id
				type="warpbox"
				pipe=6
				visible=0
			}
			hit=1
			t.hit=1
			t.oncooldown=60
		}
	}
	
	
	break;
	case "lemon_display":
		draw_omitext(x*16,y*16,"BOLLTOWERMANAGER")
	break;
	case "editobjdataname":
		{global.cobjectlemonreturnvalue= ""}
	break;

}