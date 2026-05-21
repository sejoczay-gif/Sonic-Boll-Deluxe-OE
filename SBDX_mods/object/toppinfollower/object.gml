switch(global.cobjectentrypoint){

	case "create":
		imfollow=0
		
		friction=0.1
		drop=0
		lok=0
		fresh=1

		mask_index=spr_mask12x12

	break;
	case "step":

	if !imfollow {
		with instance_place(x,y,player) {
				other.imfollow=1
				//o=instance_create(x,y,geromefollow)
				sound("itemcoin")
				if (!follower) {follower=other.id last=other.id}
				else {other.follower=follower follower.follow=other.id follower=other.id}
				other.follow=id
				other.owner=id
				//o.toppintype=real(other.toppintype)
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

	break;
	case "draw":
		draw_sprite(spr_spawner,0,x-8,y-8)
	break;
	
	
	case "lemon_display":
		xsc=1
		ysc=1
		if !sprite_exists(global.spr_bt_gerome) ||global.spr_bt_gerome==0{
			global.spr_bt_gerome=sprite_add(globalmanager.moddir+"object\"+data[0]+"\gerome.png",0,1,0,0,0)
		}
		sheet=global.spr_bt_gerome
		draw_sprite(spr_spawner,0,(x-8),(y-8))

		//draw_sprite_part_ext(sheet,0,8+34*frame,7,33,46,((x+1)*16)-17*xsc,y*16+2,xsc,1,c_white,1)

	break;
	case "deloaded":
		if !sprite_exists(global.spr_bt_gerome) ||global.spr_bt_gerome==0{
			//no need to deload anything.	
		}else {
			sprite_delete(global.spr_bt_gerome) global.spr_bt_gerome=0
		}
	
	break;

}