#define create
global.inf_time=1
settings("cog inflives",1)
skindat("hurry",0)
skindat("hurrytime",-1)

global.TOWER=1
global.pizzatime=0
global.bollface=noone

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
					musc+=1 mload[musc]=global.biome[i]
					musc+=1 mload[musc]=global.biome[i]+"fast"
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

#define step
gamemanager.sekiro=1
skindat("hurry",0)
skindat("hurrytime",-1)

if global.pizzatime && gamemanager.tick=0 && !player.finish {
	if global.bollface=0 || global.bollface=-4
	with instance_create(player.x,player.y,scriptblock) {
		scriptname="bollface_pursuit"
		global.bollface=id
		event_user(0)
	}
}

with (warpbox) with instance_place(x,y,player) with other {
	if target="Lap2" && global.pizzatime && mylap2<2{
		/*Do all the funny Lap 2 effects and shit*/
		if !mylap2 && !t
		t=instance_create(global.lap2x,global.lap2y,warpbox){t.visible=0 t.iamlap2=1 t.name="Lap2" with t getregion(x)}
		mylap2+=1
		t.mylap2=mylap2
		
		gamemanager.time=0 
        gamemanager.tick=0
		with instance_create(x,y,scriptblock) {
			scriptname="pizzatimeanim"
			lap2=1
			event_user(0)
		}
		depth=other.depth-1
		with other {
			set_sprite("roll")
			piped=1
			pipeid=other.id
			type="warpbox"
			pipe=6
			visible=0
			
			for (i=0;i<8;i+=1) {regionmarker.typemus="lap2" stagemusic(id,p2)}
		}
		hit=1
		t.hit=1
		t.oncooldown=60
	}
}