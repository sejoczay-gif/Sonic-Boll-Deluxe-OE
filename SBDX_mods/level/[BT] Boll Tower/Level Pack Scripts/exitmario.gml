#define create

mask_index=spr_mask16x16

if global.exitmariosheet=0 {
	thefile=filename_path(global.lemonfilename)+"tower_assets\gustario-escape.png"
	if !file_exists(thefile) instance_destroy()
	else global.exitmariosheet=sprite_add(filename_path(global.lemonfilename)+"tower_assets\"+"gustario-escape.png",0,1,0,0,0)
}

vsp=0
fr=0
xsc=-1
visible=0
vspeed=0
y=ystart-224

#define step

if global.pizzatime
{
if distance_to_point(nearestplayer().x,nearestplayer().y) < 300 && nearestplayer().y>y && visible=0 {visible=1 y-=10}
if visible=1
{
if !wave
{
fr=0
}
else
{
fr+=0.2
if fr>=9
fr=1
}
 
  
    yground=ystart+8
        if (bbox_bottom>=yground-2-2*(vspeed=0) && yground!=verybignumber) {
            vspeed=0
            y=floor(y)
            y=yground-(bbox_bottom+1-y)
            if !wave {fr=1 wave=1}
}
else
vspeed=10
}
}
else
{
visible=0
y=ystart-224
vspeed=0
}

#define draw

draw_sprite_part_ext(global.exitmariosheet,0,8+66*floor(fr),8,65,54,x+8-32*xsc,y-37+8,xsc,1,c_white,1)