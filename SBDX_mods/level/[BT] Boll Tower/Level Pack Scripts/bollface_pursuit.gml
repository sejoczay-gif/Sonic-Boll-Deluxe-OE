#define create
if global.spr_bollface=0 {
	thefile=filename_path(global.lemonfilename)+"tower_assets\bollface.png"
	if !file_exists(thefile) instance_destroy()
	else global.spr_bollface=sprite_add(filename_path(global.lemonfilename)+"tower_assets\bollface.png",0,1,0,37,37)
}

mask_index=spr_mask32c32

///LAUGH
actuallyhere=0
image_alpha=1
image_blend=c_red

#define step
if (!player.piped || sjumpcancel) {
    visible=1
    if !appeartime image_alpha+=0.05
	impiping=0
   if actuallyhere move_towards_point(player.x,player.y,3)
}else if (player.piped) && !sjumpcancel ||impiping{ 
	if !player.dead {
		image_alpha=0
		visible=0
		impiping=1
	}
	//global.bollface=noone
    //instance_destroy()
	appeartime=0
	actuallyhere=0
	x=player.x
	y=player.y
}


if !actuallyhere{
	hspeed=0
	vspeed=0
    image_blend=c_red
    if image_alpha>=1 alphadirection=-1
    if image_alpha<=0 alphadirection=1
    image_alpha+=0.05*alphadirection
    
    appeartime+=1
    if appeartime>120 {image_alpha=1 image_blend=c_white  appeartime=0 actuallyhere=1}
}

with instance_place(x,y,player) {
	with other {
		if other.piped exit
		if actuallyhere=0 exit
		other.timesup=1
		with other die()
		gamemanager.sekiro=0
	}
}

#define draw
if sprite_exists_0(global.spr_bollface) && global.spr_bollface!=-1 
draw_sprite_ext(global.spr_bollface,0,x,y,1,1,0,image_blend,image_alpha)