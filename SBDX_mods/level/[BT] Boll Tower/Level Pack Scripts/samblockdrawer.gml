#define create

if global.spr_samblock=0 {
	thefile=filename_path(global.lemonfilename)+"tower_assets\samblock.png"
	if !file_exists(thefile) instance_destroy()
	else global.spr_samblock=sprite_add(filename_path(global.lemonfilename)+"tower_assets\samblock.png",0,1,0,75,62)
}
instance_activate_object(konblock) konblock.visible=0
instance_activate_object(koffblock) koffblock.visible=0

prevstate=gamemanager.kaerublockstate

depth=5

#define step

if prevstate!=gamemanager.kaerublockstate {
	instance_activate_object(konblock) konblock.visible=0
	instance_activate_object(koffblock) koffblock.visible=0
	prevstate=gamemanager.kaerublockstate
}

#define draw

frame=(frame+0.3) mod 6

with konblock draw_sprite_part_ext(global.spr_samblock,0,4+16*floor(other.frame),4,16,16,x,y,1,1,c_white,1)
with koffblock draw_sprite_part_ext(global.spr_samblock,0,100,4,16,16,x,y,1,1,c_white,0.5)