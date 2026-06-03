
#define create
imfollow=0

friction=0.1
drop=0
lok=0
fresh=1

mask_index=spr_monitormask
y-=4

realtype=unreal(data_1,0)
x+=unreal(data_2,0)
y+=unreal(data_3,0)

if !sprite_exists(global.spr_bt_toppinfollower) ||global.spr_bt_toppinfollower==0{
	global.spr_bt_toppinfollower=sprite_add(globalmanager.moddir+"object\"+mytype+"\toppins.png",0,1,0,0,0)
}
sheet=global.spr_bt_toppinfollower

#define step
if !imfollow {
	with instance_place(x,y,player) {
			other.imfollow=1
			sound("itemtoppin")
			if (!follower) {follower=other.id last=other.id}
			else {other.follower=follower follower.follow=other.id follower=other.id}
			other.follow=id
			other.owner=id
			
			with other {
				with other {
					itemget=0
					with other give_item(other.id,"bigtopping")
					if itemget=0 bigtopping_get=1
				}
				
				stats("toppings collected",stats("toppings collected")+1)
				with other sound("itemtopping")
				
				if realtype!=5 {
					i=instance_create(x,y,part)
					i.vspeed=-2
					i.hspeed=-2
					i.spritepart=0
					i.visible=0
					i.toppingcagepart=1

					i=instance_create(x,y,part)
					i.vspeed=2
					i.hspeed=2
					i.spritepart=1
					i.visible=0
					i.toppingcagepart=1
					
					i=instance_create(x,y,part)
					i.vspeed=-2
					i.hspeed=2
					i.spritepart=1
					i.visible=0
					i.toppingcagepart=1
					
					i=instance_create(x,y,part)
					i.vspeed=2
					i.hspeed=-2
					i.spritepart=0
					i.visible=0
					i.toppingcagepart=1
					
					sound("itemblockbreak")
				}
			}
		}

}

if imfollow && !readyfollow {
	mask_index=spr_itemmask
	for (pos=0;pos<6;pos+=1) {
		list[pos,0]=x
		list[pos,1]=y
	}

	follower=noone

	jump=0
	xsc=1
	xp=x
	frc=0
	frame=0
	bob=0
	posbob=0

	readyfollow=1
}

if readyfollow {
	if (!instance_exists(owner) || !instance_exists(follow)) {instance_create(x,y,smoke) instance_destroy() exit}

	if (owner.hold=id) exit

	grounded=instance_position(list[pos,0],list[pos,1]+9,collider) 
	image_xscale=0.5
	walled=instance_place(x,y,collider)
	image_xscale=1

	if (abs(x-follow.x)>8 || abs(bbox_bottom-follow.bbox_bottom)>14 || !(grounded || instance_position(x,y+9,collider)) || walled) {
		list[pos,0]=follow.x
		list[pos,1]=follow.bbox_bottom-6
		list[pos,2]=follow.depth
		pos=(pos+1) mod (6-3*!!owner.piped)
		posbob+=0.4
	} else if (!grounded) {
		list[pos,1]+=1
		list[pos,0]+=sign(list[pos,0]-follow.x)
		x+=sign(x-follow.x)
	}

	if (!grounded) bob=0

	x=mean(x,x,list[pos,0]+6*sign(x-owner.x)*!!grounded*!walled)
	y=mean(y,list[pos,1])  
	if (point_distance(x,y,follow.x,follow.y)>100) {
		instance_create(x,y,smoke)
		x=follow.x
		y=follow.y
		for (pos=0;pos<6;pos+=1) {
			list[pos,0]=x
			list[pos,1]=y            
			list[pos,2]=owner.depth
		}
	}

	bob=(bob*9+abs(x-xprevious)*1.5)/10     
	depth=list[pos,2]
	k=id
	do {k=k.follow depth+=0.1} until (k=owner || depth>5)
	if (owner.piped) depth=owner.depth
	if (abs(x-xp)>4) {xp=x xsc=esign(x-xp,xsc)}
	frc+=1 if (frc=30) {frc=0 frame=!frame}

}

#define draw
	if readyfollow {
		if realtype!=5 {
			xsc=owner.xsc
			if owner.hsp=0 draw_sprite_part_ext(sheet,0,112,24*realtype,16,24,x-(8*xsc),y-16,xsc,1,c_white,1)
			else draw_sprite_part_ext(sheet,0,64+16*(global.frame mod 3),24*realtype,16,24,x-(8*xsc),y-16,xsc,1,c_white,1)
		} else {
			xsc=owner.xsc 
			if owner.hsp=0 draw_sprite_part_ext(sheet,0,32,40,32,40,x-16,y-32,1,1,c_white,1)
			else draw_sprite_part_ext(sheet,0,0+32*(global.frame mod 2),80,32,40,x-(16*xsc),y-32,xsc,1,c_white,1)
		}
	} else {
		if realtype!=5 {
			draw_sprite_part_ext(sheet,0,128,0,24,24,x-3,y-4,1,1,c_white,1)
		} else {
			draw_sprite_part_ext(sheet,0,32,0,32,40,x-8,y-20,1,1,c_white,1)
		}
	}
	
	with (part) if toppingcagepart {
		draw_sprite_part_ext(other.sheet,0,128+8*other.spritepart,24,8,8,x,y,1,1,c_white,1)
	}
	
	if global.debug draw_sprite_ext(mask_index,0,x,y,1,1,0,c_white,0.5)
	
#define lemon_display
xsc=1
ysc=1

realtype=unreal(data[1],0)

if !sprite_exists(global.spr_bt_toppinfollower) ||global.spr_bt_toppinfollower==0{
	global.spr_bt_toppinfollower=sprite_add(globalmanager.moddir+"object\"+data[0]+"\toppins.png",0,1,0,0,0)
}
sheet=global.spr_bt_toppinfollower
if realtype!=5 {
	draw_sprite_part_ext(sheet,0,128,0,24,24,(x*16)-4,(y*16)-8,1,1,c_white,1)
	draw_sprite_part_ext(sheet,0,112,0.5+24*realtype,16,24,(x*16),(y*16)-8,xsc,1,c_white,0.65)
} else {
	draw_sprite_part_ext(sheet,0,32.5,40.5,32,40,(x*16)-8,(y*16)-24,1,1,c_white,1)
}
//draw_sprite_part_ext(sheet,0,8+34*frame,7,33,46,((x+1)*16)-17*xsc,y*16+2,xsc,1,c_white,1)


#define deloaded
if !sprite_exists(global.spr_bt_toppinfollower) ||global.spr_bt_toppinfollower==0{
	//no need to deload anything.	
}else {
	sprite_delete(global.spr_bt_toppinfollower) global.spr_bt_toppinfollower=0
}


#define editobjmenu
	
if global.cobjectlemontype>3 {global.cobjectlemonreturnvalue=  "----"}

else if (global.cobjectlemontype=2) {
	global.cobjectlemonreturnvalue=  get_string("Object's X Offset",global.cobjectlemondefault)


}
else if (global.cobjectlemontype=3) {
	global.cobjectlemonreturnvalue=  get_string("Object's Y Offset",global.cobjectlemondefault)


}
else if (global.cobjectlemontype=1) {
	i=show_contextmenu("Toppin Type:|-|Mushroom|Flower|1up|Star|Feather|Gerome",0)
	if (!i) global.cobjectlemonreturnvalue=  global.cobjectlemondefault
	else global.cobjectlemonreturnvalue=  string(i-1)


}


#define editobjdataname
i=global.cobjectlemondefault
type=global.cobjectlemontype
if global.cobjectlemontype>3 {global.cobjectlemonreturnvalue= "[NO DATA]"}
else if type==2{
	global.cobjectlemonreturnvalue="Offset X: " + string(i)
}else if type==3{
	global.cobjectlemonreturnvalue="Offset Y: " + string(i)
}else if type==1{
	if i=="0" global.cobjectlemonreturnvalue= "Mushroom";
	if i=="1" global.cobjectlemonreturnvalue=  "Flower";
	if i=="2" global.cobjectlemonreturnvalue=  "1up";
	if i=="3" global.cobjectlemonreturnvalue=  "Star";
	if i=="4" global.cobjectlemonreturnvalue=  "Feather";
	if i=="5" global.cobjectlemonreturnvalue=  "Gerome";
	else global.cobjectlemonreturnvalue= "Mushroom";

}
	


