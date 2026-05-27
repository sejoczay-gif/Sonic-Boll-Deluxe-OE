#define spritelist
stand,wait,lookup,pose,walk,jump,bonk,fall,wall,dash,bow,stand2,wait2,lookup2,pose2,walk2,jump2,bonk2,fall2,wall2,dash2,bow2,standcarry,walkcarry,jumpcarry,fallcarry,bonkcarry,dashcarry,flagslide,climbing,dead,grind,run,spin,piping,pipingup,sidepiping,doorenter,doorexit,fire

#define soundlist
jump2,fire,walljump,stomp,enemyhit,enemykill,glass,swim,yoku,reflect,dash


#define movelist
The Kid
#
[b]: Gun
[down][a]/[c]: Dash
[up][b]: Reset


#define rosterorder
15

#define unlock
unlocktext="You unlocked ##The Kid!" unlocktip="Have you ever gone the wrong way?"

#define grabbedflagpole
grabbedflagpole=1
hsp=0
vsp=0

#define skininit
dodeathanim=funnytruefalse(playerskindat(p2,string(name)+" death animation"))
mariodeath=funnytruefalse(playerskindat(p2,string(name)+" mario death"))
fireanim=funnytruefalse(playerskindat(p2,string(name)+" fire animation"))

var looper;

//graphic offsets
loopey=0
looper=0
repeat((projcoordbysize*MAXIMUMSIZESARGH)+1) {
	if (projcoordbysize) {
		looper=string(loopey)
	} else {looper=""}
	
	bullet_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" bullet graphic x"+looper),10) 
	bullet_sheety[loopey]=nozerounreal(playerskindat(p2,name+" bullet graphic y"+looper),87)

	blood_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" blood graphic x"+looper),29) 
	blood_sheety[loopey]=nozerounreal(playerskindat(p2,name+" blood graphic y"+looper),101)

	gibhead_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" gib head graphic x"+looper),10) 
	gibhead_sheety[loopey]=nozerounreal(playerskindat(p2,name+" gib head graphic y"+looper),98) 

	giblimbs_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" gib limbs graphic x"+looper),30) 
	giblimbs_sheety[loopey]=nozerounreal(playerskindat(p2,name+" gib limbs graphic y"+looper),87) 

	loopey+=1
}

#define start
mask_set(10,15)
global.animatePrincess=1



#define stop
reset=0
hp=0
bow=0
dead=0
hsp=0
vsp=0
jump=0
fall=0
hyperspeed=0
gm8exspd=0

#define effectsbehind
with (carryid) {hspeed=0 event_user(1)}

#define itemget
if (type="jumprefresh") {	insted=0
	mc=0
}
else if (type="mushroom") {
	if size!=5 && !star hurtplayer("item")
	if star instance_create(x,y,smoke)
	else if ((!piped && !hurt && !(global.mplay>1 && flash)) && size==5) {
		coll=other.id
		if (p2!=other.p2) {
		itemc+=1
		doscore_p(1000,1)
		}
		playgrowsfx("")
		grow=1
		size=0
		itemget=1
		doscore_p(1000,1)
	}	
}
else if (type="fflower") {
if star {instance_create(x,y,smoke)} else hurtplayer("item")             
}
else if (type="bfeather") {
	if star {instance_create(x,y,smoke)} else hurtplayer("item")   
	/*if (!piped && !hurt && !(global.mplay>1 && flash)) {
		coll=other.id
		if (p2!=other.p2) {
			itemc+=1
			doscore_p(1000,1)
		}
		playgrowsfx("")
		if (skidding) {soundstop(name+"skid") skidding=0}		
		if (!super && size!=1) grow=1
		oldsize=size
		size=1
		itemget=1
	}  */              
}
else if (type="star") {
	if ((!piped && !hurt && !(global.mplay>1 && flash))) {
		coll=other.id
		doscore_p(1000)
		sound("itemstar")
		itemc+=1
		if (!super) {
			star=1
			alarm[2]+=other.fuel+2
			alarm[3]=-1
			kek=0 with (player) if (super) other.kek=1
			if (!kek) {
				mus_play("starman",1,p2)
				global.music="star"
			}                      
		}
		if (skindat("growsfx3"+string(p2))) playsfx("growsfx3") 
		else playgrowsfx("3")
		itemget=1
	}            
}
else if (type="1up") {
    sound("item1up")
    itemc+=1	
	bow=1
	itemget=1	
}
else if (type="shield") {
    if ((!piped && !hurt && !(global.mplay>1 && flash))) {
        coll=other.id
        if (p2!=other.p2) {
            itemc+=1
            doscore_p(1000,1)
        }
        sound("itemshield")
		shielded=1
        itemget=1
    }   
}
else if (type="poison") {
    if ((!piped && !hurt && !(global.mplay>1 && flash))) {
        coll=other.id
         if !invincible() hurtplayer("enemy")
        itemget=1
    }   
}
else if (type="coin") {
}
else if (type="ring") {
} 

else if (type="redcoinreward") {
    itemc+=1
    if (bow) give_item(id,"shield") else bow=1
}

else if (type="checkpoint") {
}

else if (type="100coin1up") {
	bow=1
}

else {
	prevsize=size
    com_item()
	if (size==1 && prevsize==5) || (prevsize==1 && size==5) size=0
}
#define endofstage
right=1
akey=(push*!akey || (jump && akey) || instance_place(x+16,y,enemy) || !collision(16,8))


#define projectile
if (event="create") {
	breakflag=1
	timer1=60
	timer2=-1
	frame=0
	active=0
	bullet=1
	image_xscale=4
	image_yscale=2

	bullet_sheetx=owner.bullet_sheetx
	bullet_sheety=owner.bullet_sheetx
	blood_sheetx=owner.blood_sheetx
	blood_sheety=owner.blood_sheety
	gibhead_sheetx=owner.gibhead_sheetx
	gibhead_sheety=owner.gibhead_sheety
	giblimbs_sheetx=owner.giblimbs_sheetx
	giblimbs_sheety=owner.giblimbs_sheety

	frame_sub=0
	frame=0
	brickc=0
	seqcount=2
	a=1
	visible=1
	if bloddrop{
		speed=random(7)
		gravity=random_range(0.1,0.3)
		u=choose(29,36)
		v=choose(101,108)
		b=irandom(3)
		a=1
		image_xscale=3
		image_yscale=3
		bow=0
		ignoreoncount=1
	}else if gib{
		speed=random_range(2,4)
		direction=random_range(45,135)
		gravity=0.4
		fade=0
		a=1

		image_xscale=3
		image_yscale=3
		bow=0
		ignoreoncount=1
	}
	else if owner.createbow{
		ignoreoncount=1
		name=owner.name
		p2=owner.p2
		charm_init()
		bow=1 
		///////SPRITESWITCHER IS A FLAG TO LET THE BOW BE INSIDE HIS SHEET STORED LIKE AN ANIMATION, THIS CAN BE USED BY ALL MODDED CHARACTERS
		is_spriteswitcher=1
		bullet=0
		owner=owner.id
		size=owner.size
		owner.mybow=id
		xsc=owner.xsc
		ysc=owner.ysc
		water=owner.water
		set_sprite("bow")
		visible=1
		frspd=0.2
		alpha=1
		timer1=-1
		timer2=-1
	}else if owner.troll_door{

		my_door=instance_position(x,y,door)
		my_door.visible=0
		my_door.trolling=1
		depth=my_door.depth
		troll_door=1
		x+=8
		y+=16
		ignoreoncount=1
		
		sheet=owner.sheets[4]
	}else{
		bow=0
		bullet=1
		p2=owner.p2
		size=owner.size
		shadow=owner.shadow
		alpha=owner.alpha
		usepalette=owner.usepalette
		projectilepalettes=owner.projectilepalettes
		if owner.lookup {hspeed=owner.xsc*-6 vspeed=-6} 
		else {hspeed=owner.xsc*8}
		if (owner.hang && owner.vsp>1) {hspeed*=-1 x-=16*xsc}
	}
}
if (event="step") {
	///CUSTOM TROLLS
	if troll_door{
		frame+=1
		if frame==60{
			with (instance_create(x,y-8,smoke)) {direction=135 speed=2 friction=0.1}
			with (instance_create(x+16,y-8,smoke)) {direction=45 speed=2 friction=0.1}
			with (instance_create(x,y+8,smoke)) {direction=225 speed=2 friction=0.1}
			with (instance_create(x+16,y+8,smoke)) {direction=315 speed=2 friction=0.1}
		}
		if frame>=60 && frame<=60 {
			with my_door other.coll=instance_place(x,y,player) 
			if coll with coll {  hurtplayer("door")}		
		}
		if frame>=120 {
			my_door.visible=1
			my_door.trolling=0
			instance_destroy()
		}
		exit
	}


	///BULLET CODE

	timer1-=1 if (timer1=0) instance_destroy()
	timer2-=1 if (timer2=0) fade=1
	calcmoving()
	if (abs(x-owner.x)>256) instance_destroy()

	frame_sub=!frame_sub
	if frame_sub frame=!frame
	if (!bow){
		xsc=sign(hspeed)
	}
	active=1
	if(bullet){
	
		if owner.object_index==player{ //this is due to blue koopas. funny.
			coll=instance_place(x,y,bowserboss)
			if (coll) {
				if (!coll.flash) {
					coll.hp-=1
					coll.flash=64
					coll.owner=owner
					sound("enemybowserhurt")
					instance_create(x,y,kickpart)
					instance_destroy()
				}
			}
			with (invisibox){
				if untouched=1
				other.coll=instance_place(xstart-other.hsp,y-other.vsp,id)
				if untouched=0
				other.coll=instance_place(other.x,other.y,id)
			}
			if (coll) {
				if coll.seeit=0{ 
				instance_destroy()} else{
				hitblock(coll,owner,1,-1,1)
				instance_create(x,y,kickpart)     
				instance_destroy()}
			}

			coll=instance_place(x,y,coin)

			if (coll) {
				instance_destroy()
				with (owner) playsfx("kidglass")
				with (coll) {instance_create(x,y,kickpart) instance_destroy()}
			}
			coll=instance_place(x,y,axe)

			if (coll){
				with (coll) {
					hp-=1
					if (hp<=-5 && !hit) {
						hit=1    
						sound("itemaxe")
						with (coll.owner) playsfx("kidglass")
						if real(channelid) != 0 global.channel[real(channelid)] += 1
						with (mybridge) event_user(0)
						with (instance_nearest(x,y,axewall)) alarm[0]=30
						y=-verybignumber
					} else with (coll.owner) playsfx("kidenemyhit")
				}
			}
			coll=instance_place(x,y,spreng)
			if (coll){
				x-=hspeed
				hspeed*=-1
				xsc*=-1
				sound("itemspring") coll.shot=12
			}

			coll=instance_place(x,y,collider)
			if (coll && (coll.object_index!=phaser || ((coll.dir!=0 && coll.dir!=2) && sign(coll.dir)!=xsc))) {
				if (object_is_ancestor(coll.object_index,hittable)) {
					if (coll.object_index=brick) brickc+=1 else brickc=4
					hitblock(coll,owner,1,-1,1)
					instance_create(x,y,kickpart)     
					instance_destroy()
				} else brickc=4
				instance_create(x,y,kickpart)     
				if (brickc=4) {sound("itemblockbump") instance_destroy()
				}
			}

			coll=instance_place(x,y,enemy)
			if (coll) {
				if (coll.object_index=bulletbill || coll.object_index=bullseyebill || coll.object_index=banzaibill) {
					with (owner) playsfx("kidreflect")
					direction=90
					exit
				}
				else if (coll.object_index=shell) {
					if (coll.type="beetle") {playsfx("kidreflect") direction=90 exit}
					if coll.goblu  {if coll.id != owner.id {with owner playsfx("kidreflect") hspeed*=-1 owner=coll} exit}
					sound("enemykick")

					if coll.hspeed!=0 {
						playsfx("kidenemyhit")
						coll.hspeed=0
						coll.stop=1
						coll.kicked=0
						coll.spd=0
						//instance_create(x,y,kickpart) 
						instance_destroy();
						exit
					} else {
						coll.spd=3 coll.hspeed=coll.spd*xsc if (coll.type="red") {coll.hspeed*=-1} coll.kicked=1 coll.stop=0
					}
				} else if (coll.object_index=blukoopa) {if coll.spindash {with owner playsfx("kidreflect") direction+=180 owner=coll exit}}
				else if (coll.object_index!=bombenemy && coll.object_index!=drybones && coll.object_index!=boo && coll.object_index!=urchin) {
					coll.hp-=1
					if (coll.hp=-3) {enemydie(coll.id,seqcount,1) with (owner) playsfx("kidenemykill")}
					else with (owner) playsfx("kidenemyhit")
				} 
				if (coll.object_index!=boo) {
					if (coll.object_index=bombenemy || coll.object_index=drybones 
					|| coll.object_index=urchin) playsfx("kidenemyhit")
					instance_create(x,y,kickpart) 
					instance_destroy()
				}
			}

			coll=instance_place(x,y,player)
			if (coll) {
				if (coll.id!=owner) if (!invincible(coll)&&!intangible(coll)) {    
					if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !coll.flash && !coll.piped) { 
						if (coll.name="knux" && coll.glide && sign(hspeed)=-sign(coll.hsp) && object_index!=powah_wave) {hspeed=abs(coll.hsp+1)*esign(coll.hsp,1) owner=coll.id with (owner) playsfx("knuxreflect") exit}                                                                   
						if (coll.name="robo" && coll.lookup && coll.xsc=sign(hspeed)) {instance_create(x,y,kickpart) instance_destroy() exit}
						coll.hp-=1
						if (coll.hp<=-5) with (coll) hurtplayer("enemy")

						instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
						with (owner) playsfx("kidenemyhit")
						with(coll) fragplayer(other.owner)
					}
					instance_create(x,y,kickpart) instance_destroy()
				}
			} 
		} else {
			coll=instance_place(x,y,player)
			if (coll) {
				if (!invincible(coll)&&!intangible(coll)) {    
					if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !coll.flash && !coll.piped) { 
						if (coll.name="knux" && coll.glide && sign(hspeed)=-sign(coll.hsp) && object_index!=powah_wave) {hspeed=abs(coll.hsp+1)*esign(coll.hsp,1) owner=coll.id with (owner) playsfx("knuxreflect") exit}                                                                   
						if (coll.name="mecha" && coll.lookup && coll.xsc=sign(hspeed)) {instance_create(x,y,kickpart) instance_destroy() exit}
						coll.hp-=1
						if (coll.hp<=-5) with (coll) hurtplayer("enemy")

						instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
						with(coll) fragplayer(other.owner)
					}
					instance_create(x,y,kickpart) instance_destroy()
				}
			}
		
		}
	}//GIB CODE
	else if (gib){
		visible=1
		rot-=hspeed*8
		if (fade) {
		a=max(0,a-0.02)
		if (a=0) instance_destroy()
		}

		//collisions sp only
		if !(global.gamemode="battle"||global.gamemode="coop"){
			coll=instance_place(x,y,collider)
			if coll{
				if (instance_place(x,y,lavablock)) {
					instance_create(x,y,smoke)
					instance_destroy()
				} else if (vspeed>0 && vspeed<1) {
					y=yprevious
					speed=0
					gravity=0
				} else {
					if (instance_place(xprevious+hspeed,yprevious,coll.id)) hspeed*=-0.7                                        
					else hspeed*=0.7
					if (instance_place(xprevious,yprevious+vspeed,coll.id)) vspeed*=-0.5
					x=xprevious
					y=yprevious
				}
			}
		}
	} //BLOD CODE
	else if (bloddrop){
		visible=1
		if!nowimstuck{
			//waterology
			if (water) {
				if (!underwater()) vspeed=abs(vspeed)*0.5
				if (speed=0 && !splat) instance_destroy()
			}
			fade=0
			a=1
			//collisions sp only
			if !(global.gamemode="battle"||global.gamemode="coop"){
				coll=instance_place(x,y,collider)
				if coll{
					if (instance_place(x,y,lavablock)) {
						instance_create(x,y,smoke)
						instance_destroy()
					}
					else if (splat){
						nowimstuck=1
						stuckx=x-coll.x
						stucky=y-coll.y
						stuck=coll
						del=0
						fade=0
						a=1
						timer2=32*a
					}
				} 
			}
		} else{
			x=stuck.x+stuckx
			y=stuck.y+stucky
			water=underwater()
			gravity=0
			if (fade) {
				a=max(0,a-0.02)
				if (a=0) instance_destroy()
			}

		}

	}//////BOW CODE, hey there, -S- here, you would not believe how stupidly long it took me to fix this crashing the game, in fact, as i'm writing this, it's still not fixed,i hate this sooo much,,, EDIT: 27/12/2020 Finally fixed this with adding the spriteswitcherflag holy guacamole
	else if (bow){
		if bowlag{
			x=owner.xprevious y=owner.yprevious
		}else {x=owner.x+owner.hsp y=owner.y+owner.vsp}
		//spriteswitch(1)
		ssw_core(1)
		visible=1
		xsc=owner.xsc
		depth=owner.depth-1
		if ((owner.pose && finish) || !owner.bow) instance_change(smoke,0)
		with (owner){mybow.bowlag=skindat("bowlag")} 
		ysc=owner.ysc
	}

}
if (event="draw") {
	///CUSTOM TROLLS
	if troll_door{
		if frame<40	draw_sprite_part_ext(sheet,0,70,90,32,32,round(x-16),round(y-32),1,1,$ffffff,1)
		else if frame<50 draw_sprite_part_ext(sheet,0,103,90,32,32,round(x-16),round(y-32),1,1,$ffffff,1)
		else if frame<60 draw_sprite_part_ext(sheet,0,136,90,32,32,round(x-16),round(y-32),1,1,$ffffff,1)
		else if frame <90  draw_sprite_part_ext(sheet,0,169,90,32,32,round(x-16),round(y-32),1,1,$ffffff,1)
		else if frame<110 draw_sprite_part_ext(sheet,0,136,90,32,32,round(x-16),round(y-32),1,1,$ffffff,1)
		else if frame<120 draw_sprite_part_ext(sheet,0,103,90,32,32,round(x-16),round(y-32),1,1,$ffffff,1)
		exit
	}

	

	if (bow) {
		//ssw_core(0)
	} else if bullet{
		if usepalette scr_applyPaletteSegmentedAlpha(global.shaderPaletteSwapAlpha,global.palettesprites[p2*100],global.pal_1[p2]+1,global.pal_2[p2]+1,global.pal_3[p2]+1,global.pal_4[p2]+1,size,alpha*(1-0.75*shadow),totpal+1)
		draw_sprite_part_ext(sheet,0,bullet_sheetx[size*projcoordbysize]+9*frame,owner.bullet_sheety[size*projcoordbysize],8,8,round(x-4*xsc),round(y-4),xsc,1,$ffffff,1)
		shader_reset()
	}
	else if bloddrop {
		if owner.usepalette scr_applyPaletteSegmentedAlpha(global.shaderPaletteSwapAlpha,global.palettesprites[owner.p2*100],global.pal_1[owner.p2]+1,global.pal_2[owner.p2]+1,global.pal_3[owner.p2]+1,global.pal_4[owner.p2]+1,owner.size,a*(1-0.75*shadow),owner.totpal+1)
		draw_sprite_part_ext(sheet,0,u,v,6,6,round(x-4*xsc),round(y-4),xsc,1,$ffffff,a)
		shader_reset()
	}
	else if gib {
		if owner.usepalette scr_applyPaletteSegmentedAlpha(global.shaderPaletteSwapAlpha,global.palettesprites[owner.p2*100],global.pal_1[owner.p2]+1,global.pal_2[owner.p2]+1,global.pal_3[owner.p2]+1,global.pal_4[owner.p2]+1,owner.size,a*(1-0.75*shadow),owner.totpal+1)
		d3d_transform_add_rotation_z(rot)
		d3d_transform_add_translation(round(x),round(y),0)
		draw_sprite_part_ext(sheet,0,u,v,w,h,-w/2,-h/2,1,1,$ffffff,a)
		d3d_transform_set_identity()
		shader_reset()
	}
}

#define grabflagpole
grabflagpole=1
hsp=0
vsp=0

#define sprmanager
frspd=1

if (grabflagpole) {sprite="flagslide"}
else if (lookup) {sprite="lookup" if place_meeting(x,y,door) {if instance_place(x,y,door).trolling  sprite="doorenter" } }
else if (hang && vsp>=0) {sprite="wall"}
else if (abs(hsp+gm8exspd)>5) {sprite="run"}
else if (dash && dashtype) {sprite="dash"}
else if (jump) {
	if (onvine) {sprite="climbing" frspd=sign(left+right+up+down)}
	else if (bonk) sprite="bonk" 
	else if (vsp<0) sprite="jump" 
	else sprite="fall"
}
else if (hsp==0) {
	if (waittime>maxwait) {sprite="wait"} else sprite="stand"
	if place_meeting(x,y,door) {if instance_place(x,y,door).trolling  sprite="doorenter" }
}
else {sprite="walk"}

keepframebetween=0
if (sprite!="run") {
	if (carry) sprite=sprite+"carry"
	if (fired && !carry) { //I DONT GET IT this variable works for everything EXCEPT THE FIRE ANIMATION what the hell is happening
			sprite=sprite+"2"
			if oldspr+"2"=sprite keepframebetween=1
	}
	if (!fired && oldspr==sprite+"2") {
		keepframebetween=1
	}
}

#define controls
com_inputstack()

tempbrick=0

//situations in which it should skip controls entirely
if (piped || move_lock) {
    di=0
    exit
}

if (up) {

	if position_meeting(x,y+8,door) {
		
		pipeid=instance_position(x,y+8,door)
		if pipeid.visible
		if (pipeid) 
		if !(!pipeid.key || count_owned(keyfollow)>=pipeid.key) || !((pipeid.t || pipeid.warp) && abs(x-(pipeid.x+8))<4 && !pipeid.oneway) {
			
			troll_door=pipeid.id
			fire_projectile(pipeid.x,pipeid.y)
			troll_door=0
		} 
		
	}
	com_piping()
	
}
oup=up
               
if (up) {
    if (hsp=0 && !jump) lookup=1
    else lookup=0
} else lookup=0

//movement
if (wallkick) h=kicked
if (h!=0) {
    coll=collision(h,0)
    if (coll) {
        com_hitwall(h)
        push=h
        if (!water && knuxcanclimb(collision(8*h,0))) {
            if (jump && !carry) framegoby+=1 if framegoby>2 {hang=4}
            xsc=h
        }  else {framegoby=0}
    } 
    if (!hang) xsc=h
}

if (dash) {
    if (jump) dashside=h
    hsp=(3+(dash-1)/10)*dashside
} else hsp=h*2
    
if (push!=h) push=0

com_di()

//code for specifically the a button
if ((abut || jumpbufferdo) && !springin) {
    if (!jump||fall=69||grabflagpole) { //jump
        if (down && !grabflagpole) {
            if (!dash) {
                dash=20
                dashside=xsc
                dashtype=1
                playsfx("kiddash",0,1+(size==5)/3)                
                shoot(x-4*xsc,y+4,psmoke,-2*xsc,-1)
                shoot(x-4*xsc,y+4,psmoke,-2*xsc,1)
            }
        } else {
            jumpsnd=playsfx("kidjump",0,1+(size==5)/3)
            vsp=-6
            if (water) vsp=-sqrt(sqr(vsp)*wf+2)                                           
            squat=4
            jump=1
            if (size==7) {antigrav=!antigrav vsp*=-1}

            braking=0  
			onvine=0
			grabflagpole=0
            canstopjump=1
            if (mymoving) hsp+=avgmovingh
            fall=1
            dashtype=0
            jumpspd=min(1,0.5+abs(hsp)/5)
        }
    } else { //air jumps
        if (hang) {
			if !(carry) {
				hang=0
				canstopjump=1
				squat=4
				xsc*=-1 vsp=-5
				hsp=xsc*2.5 instance_create(x-6*xsc,y+8,kickpart) 
				kicked=xsc
				playsfx("kidwalljump",0,1+(size==5)/3)
				wallkick=12
			}
            if (down||ckey) {
                dash=20
                dashside=xsc
                dashtype=1
                playsfx("kiddash",0,1+(size==5)/3)
                shoot(x-4*t,y+4,psmoke,-2*t,-1)
                shoot(x-4*t,y+4,psmoke,-2*t,1) 
            }
        } else if (!insted) {
            insted=(size!=7)
            canstopjump=1
            dashtype=0
            if (water) {
                vsp=-3
            	if (size==7) {antigrav=!antigrav vsp*=-1}
                squat=4
                playsfx("kidswim",0,1+(size==5)/3)
                if (sprite="jump" || sprite="fall") frame=0
            } else {
                vsp=-5
            	if (size==7) {antigrav=!antigrav vsp*=-1}
                squat=4
                playsfx("kidjump2",0,1+(size==5)/3)
                shoot(x,y+12,psmoke,0,2)
            }
        }
        jumpbuffer=4*!jumpbufferdo
    }
}
jumpbufferdo=0    
springin=0

if (akey) {
    if (jumpbuffer) jumpbuffer-=1
} else jumpbuffer=0

if (!akey) {
    if (canstopjump=1 && jump && vsp<-2 && !sprung) {
        vsp*=0.5
    }
    canstopjump=0
}

//code for specifically the b button
if (bbut) && !(carry) && !size {
    fired=firelength
	if fireanim frame=0
    if (lookup) {
		playsfx("kidfire")
		if size!=5 bull=fire_projectile(x+8*xsc,y+5)
		else bull=fire_projectile(x+8*xsc,y+9)
		bull.bullet=1
        hurtplayer(1)
    } else if (count_projectiles()<(3+bow)) {
		playsfx("kidfire")
		if size!=5 bull=fire_projectile(x+8*xsc,y+5)
		else bull=fire_projectile(x+8*xsc,y+9)
		bull.bullet=1
    }           
}

if (bkey) {
//ounno
} else {
	if (carry) {
        updatecarry()
        if (!down) {throw=16 instance_create(carryid.x,carryid.y,kickpart) sound("enemykick")}
        with (carryid) event_user(0)
        carryid=noone
        carry=0
    }
}


if (cbut) {
    if (!dash && !jump) {
        dash=20
        dashside=xsc
        dashtype=1
        playsfx("kiddash",0,1+(size==5)/3)                
        shoot(x-4*xsc,y+4,psmoke,-2*xsc,-1)
        shoot(x-4*xsc,y+4,psmoke,-2*xsc,1)
    }      
}

if (down && !up) {
    	if position_meeting(x,y+8,door) {
		
		pipeid=instance_position(x,y+8,door)
		if pipeid.visible
		if (pipeid) 
		if !(!pipeid.key || count_owned(keyfollow)>=pipeid.key) || !((pipeid.t || pipeid.warp) && abs(x-(pipeid.x+8))<4 && !pipeid.oneway) {
			
			troll_door=pipeid.id
			fire_projectile(pipeid.x,pipeid.y)
			
		} 
		
	}
	com_piping()
}

if (size==5) mask_set(2,2) else if size==1 mask_set(20,30) else mask_set(10,15)

if (rbut && !resetbuf && global.wanna) {skindat("musmem",global.music) io_clear() loadtas()} else if (!rbut && resetbuf) resetbuf-=1

#define movement
if (piped || move_lock) exit

if (loose && !jump) {
    frick=0.06
    hsp=max(0,abs(hsp)-frick+((size==5)*0.75))*sign(hsp)
}

maxspd=2+dash+((size==5)*0.75)
if (abs(hsp)>maxspd) hsp=(abs(hsp)*2+maxspd)/3*sign(hsp)         

vsp=min(7+downpiped,vsp)
 
//the kid reveals invisible blocks on touch 
with (invisibox) if (untouched) if (instance_place(xstart-other.hsp,y-other.vsp,other.id)) {untouched=0 seeit=1 x=xstart with (other) playsfx("kidyoku")}

///movement
//hi moster here dont uncomment the yground or easyground stuff because its required for the cool new slope system to work
//for anyone porting a charm from unfinished build or below to this build, delete or comment all of the commented code and add player_nslopforce()
calcmoving()     

if (!dead && !grabflagpole) {
if fall!=69
    player_horstep()
    player_nslopforce()
    //yground=easyground()
	//if (yground!=verybignumber) yground-=14
    if (jump) {
	if fall!=69 {
            vsp=min((5+3*downpiped)*wf,vsp+0.25*wf)
			if size==5 && vsp>-0.45 vsp-=0.105
        } vine_climbing()
        if (hang && vsp>1) vsp=1.5
        push=0 
        player_vertstep()
        coyote=0
    }
    
    if (!jump) {
		//if (yground!=verybignumber) {y=yground while collision(0,0) && !collision(0,-8) {y-=1 }}
        if (finish && ending="retainer" && !jump) coyote=0
        if (!collision(0,4) && !antigrav) || (!collision(0,-4) && antigrav) /*&& (y<yground-2)*/ {
            coyote+=1
            if (coyote=1) {y+=1 coyote=3}
            if (coyote=3) {
				jump=1
				fall=1
			}
        } else coyote=0
        if (jumpbuffer=-1) {
            jumpbuffer=0
            if (!down) jumpbufferdo=1
        }
    }  
}
com_finishmove()   


#define actions
com_warping()
com_actions()
   
if bow && !createbow {createbow=1} 
  
if (createbow) {if (!mybow || mybow=noone) fire_projectile(x,y) createbow=0}

if bigtroll_enteringgorund {
	hsp=0
	depth=1000004
}

if size==1{
	with collision_circle(x,y,30,brick,0,1){
		sound("itemblockbreak")
		i=instance_create(x+4,y+12,part) i.type=0 i.hspeed=-1 i.vspeed=-1
		i=instance_create(x+12,y+12,part) i.type=0 i.hspeed=1 i.vspeed=-1
		i=instance_create(x+4,y+4,part) i.type=0 i.hspeed=-1 i.vspeed=-3
		i=instance_create(x+12,y+4,part) i.type=0 i.hspeed=1 i.vspeed=-3
		instance_destroy()
	}
	with collision_circle(x,y,30,crate,0,1){
		sound("itemblockbreak")
		i=instance_create(x+4,y+12,part) i.type=0 i.hspeed=-1 i.vspeed=-1
		i=instance_create(x+12,y+12,part) i.type=0 i.hspeed=1 i.vspeed=-1
		i=instance_create(x+4,y+4,part) i.type=0 i.hspeed=-1 i.vspeed=-3
		i=instance_create(x+12,y+4,part) i.type=0 i.hspeed=1 i.vspeed=-3
		instance_destroy()
	}
}

weight=1
bartype=0

is_intangible=0
with (flag) if (passed[other.p2]) other.is_intangible=1
if (transform || finish || piped=1) is_intangible=1

power_lv=0
if (star) power_lv=5
if (super) power_lv+=1

//Special interactions
pvp_spin=0 //rolling clash
pvp_avoid=0 //I don't like social interactions
pvp_stomper=1 //make sure to set for 0 for the mario bros when pounding
pvp_ignore=0 //For when you wanna hit the others but not yourself
pvp_knockaway=1 //I won't hurt you, just go away

coll=instance_place(x+(abs(hsp)+2)*xsc,y,cork)
if (coll || carryid.object_index==cork) && (!coll.time) {
	if (bkey && !carry && !spin && !dropkick && !dive && size!=5) {
		coll.carry=id coll.owner=id carryid=coll
		carry=1
		skidding=0
		updatecarry()
	} else if !(bkey) { 
		if (carry) {
			updatecarry()
			if (!down) {throw=16 instance_create(carryid.x,carryid.y,kickpart) sound("enemykick")}
			with (carryid) event_user(0)
			carryid=noone
			carry=0
		}
    }              	
}

coll=instance_place(x+(abs(hsp)+2)*xsc,y,litbobomb)
if (coll || carryid.object_index==litbobomb) && (!coll.time) {
	if (bkey && !carry && !spin && !dropkick && !dive && size!=5) {
		coll.carry=id coll.owner=id carryid=coll
		carry=1
		skidding=0
		updatecarry()
	} else if !(bkey) { 
		if (carry) {
			updatecarry()
			if (!down) {throw=16 instance_create(carryid.x,carryid.y,kickpart) sound("enemykick")}
			with (carryid) event_user(0)
			carryid=noone
			carry=0
		}
    }              	
}

if (piped) exit

//waiting animation
if maxwait{
if (sprite="stand" && !fired)
{waittime+=1}
else if sprite!="wait" waittime=0
}


if (!jump) {
    vsp=0
    if (!star && !spin && !spindash) seqcount=0
    hang=0                   
    if (instance_place(x,y+4,lavablock)) hurtplayer(1)
}

if (underwater()) {
    if (!water) {
        if (abs(vsp)>2) water_splash(1)
        vsp=min(1,vsp/2)
        jumpspd=1           
    }
    water=1 wf=0.4
} else {
    if (water) {
        water=0
        vsp=max(-4,vsp*2)
        if (abs(vsp)>2) water_splash(0)
    }
    wf=1
}

//smoke generation
if (global.dustframe) {
    if (dash && !jump) {
        i=shoot(x,y+10,psmoke) i.depth=depth+2
    }
    if (vsp<-5-2*!sprung) {
        shoot(x,y+8,psmoke,0,-1)
    }
    if (vsp>7) {
        speedwagon+=1
        if (speedwagon>60) shoot(x,y,psmoke,0,1)
    } else speedwagon=0
}

if (size==7 && global.fastframe4 != ff4prev) {ff4prev = global.fastframe4 with instance_create(x, y, afterimagenoblend) {event_user(0) alphadecay=1 alarm[0] = 24 maxalarm = 24 maxalpha=0.8}}

//character specific actions
wallkick=max(0,wallkick-1)

hang=max(0,hang-1)
squat=max(0,squat-1)

if (instance_place(x,y,part)) && size!=1 && !invincible() hurtplayer(1)

if (water || hang) insted=0

if (dash) {
    dash-=1
    if ((right-left!=dashside && right-left!=0) || (hang && vsp>0))
        dash=0
    if (jump && dash=0 && !(hang && vsp>0))
        dash=1
}


jeezus=((size==5 && !down && abs(hsp)>2.5) && !water)
if jeezus==1 {
    if !plat plat=instance_create(0,0,ground)
    plat.x=x-6
    plat.y=y-80
    plat.image_yscale=0.3
    with instance_place(x,y+4,waterblock) other.plat.y=y
    if plat.y=y-80 {
        if plat with plat instance_destroy() plat=0
    }
    else if instance_place(x,y+4,plat) && splashtime<=0 {splashtime=9 water_splash(-1)}
    splashtime-=1
} else {splashtime=0 plat.x=verybignumber plat.y=verybignumber if plat with plat instance_destroy() plat=0}


com_endactions()

#define enemycoll
if (hurt || piped || (intangible() && !diggity) || (star&&size!=1)) exit

if size==1{
	flash=1
	instance_create(x,y,BOM)
	flash=0
	enemydie(coll)                
    exit
}


coll=noone extracheck=id inst=0
if (insta) {extracheck=myhitbox inst=1}


with (pswitch) if (phase!=other.id && !lock && !carry) {
    mask_index=spr_cratemask
    if (instance_place(x,y-other.vsp-16*!!other.diggity,other.id) || instance_place(x,y,extracheck)) other.coll=id
    mask_index=spr_mask16x16
}
with (enemy) if (phase!=other.id && !lock && !carry)
    if (instance_place(x,y-other.vsp-16*!!other.diggity,other.id) || instance_place(x,y,extracheck)) other.coll=id


if (coll) {
    if (!coll.damage_player_on_contact) {
        calcfall=fall
        if (fall=5 || fall=12) calcfall=0
        global.coll=id
        type=coll.object_index
    
		if (type=shell && !coll.time) && (carryid != coll) {          
            if (coll.type="spiny" && (coll.vspeed-vsp)*coll.ysc<0) {
                hurtplayer("enemy") exit
            } else if (!coll.kicked || (coll.stop && (coll.owner=id || coll.vspeed>=0))) {
                if (bkey && !carry && !spin && !dropkick && !dive) {
                    coll.carry=id coll.owner=id coll.alarm[1]=600 coll.alarm[2]=-1 carryid=coll
                    carry=1
					skidding=0
					exit
                }
            }
        }
    
        if (type=piranha || type=redpiranha || type=podoboo || (type=blooper && water) || type=spiny || type=spinyegg) hurtplayer("enemy")
        else if (type=cheepfly) {
            coll.phase=id
            playsfx("kidenemyhit")
            if (!wallkick) kicked=-coll.xsc             
            wallkick=16
            jump=1
            vsp=-4
            if antigrav vsp*=-1
            canstopjump=akey                                                                         
            } else {
                if ((vsp<=0 || y>coll.y) && !antigrav) || ((vsp>=0 || y<coll.y) && antigrav) hurtplayer("enemy")
                else {
                    playsfx("kidstomp")
                    vsp=-4-akey*2
            		if antigrav vsp*=-1
                    canstopjump=akey
                    jump=1
                    insted=0
                }
            }
            exit
        
    } else if (!star && !flash) hurtplayer("enemy")
}

#define hurt
if size=1 exit
pipe=0
sprongin=0
speed=0

onvine=0
energy=0
braking=0
sprung=0
diggity=0
grow=0
gk=0
fk=0
jumpbuffer=0
hyperspeed=0
antigrav=0
hp=0
star=0
if (super) stopsuper()   

if (!shielded ||invincible() || hurt || flash || intangible() || (ohgoditslava && !shielded)) {
   if (global.mplay>1 || global.debug || global.lemontest) alarm[7]=120
   if (global.gamemode="battle") dropcoins(0) else if !global.lemontest mus_play("reset",1)
   with projectile if (owner=other.id && bow) {instance_change(smoke,0)} //should do this before he moves
   die()  
}else {
	jump=1 hurt=1+starhit if (!starhit) if (shielded) {shielded=0 playsfx(name+"shielddamage") } hsp=xsc*-2*wf vsp=-3*wf
}



//Block hitting
#define hitblocks
if typeblockhit=0{
with (blockcoll){
if (!owner.tempkill && cracked=0 && !insted) {
    if (!goinup) {if (insted!=2) owner.vsp=1.5 sound("itemblockbump") tpos=1}
} else { 
    com_breakblocks()
  }
 }
}  else if typeblockhit=1{
	hititembox()
}

#define hitwall
if (abs(hyperspeed+hsp)>5) {x-=hsp+hyperspeed hurtplayer("crush")}
hsp=0
hyperspeed=0       


#define landing
insted=0
if hurt {flash=1 fk=0 hsp=0 hurt=0}

if (downpiped) {
    shoot(x-8,y+4,psmoke,-2,-1)
    shoot(x+8,y+4,psmoke,2,-1)
    downpiped=0
}
if size==1{
	coll= collision(0,1)
	if coll {
		jump=1
		vsp=-2
		//show_message(object_get_name(coll.object_index))
	}
	if coll.object_index==ground { if coll.image_yscale>1 {coll.y+=16 coll.image_yscale-=1 } else with coll instance_destroy() depth=1000003 bigtroll_enteringgorund=1
		sound("itemblockbreak")
		
		 i=instance_create(x+4,y+12,part) with(i){type=4 hspeed=-1 vspeed=-1+2*go}
		 i=instance_create(x+12,y+12,part) with(i){type=4 hspeed=1 vspeed=-1+2*go}
		 i=instance_create(x+4,y+4,part) with(i){type=4 hspeed=-1 vspeed=-3+2*go}
		 i=instance_create(x+12,y+4,part) with(i){type=4 hspeed=1 vspeed=-3+2*go}
		

	}
	if coll.object_index==hardblock with coll{
		sound("itemblockbreak")
		instance_destroy();
		 i=instance_create(x+4,y+12,part) with(i){type=4 hspeed=-1 vspeed=-1+2*go}
		 i=instance_create(x+12,y+12,part) with(i){type=4 hspeed=1 vspeed=-1+2*go}
		 i=instance_create(x+4,y+4,part) with(i){type=4 hspeed=-1 vspeed=-3+2*go}
		 i=instance_create(x+12,y+4,part) with(i){type=4 hspeed=1 vspeed=-3+2*go}
	}
	if object_is_ancestor(coll.object_index,hittable) with coll{
		sound("itemblockbreak")
		instance_destroy();
		 i=instance_create(x+4,y+12,part) with(i){type=4 hspeed=-1 vspeed=-1+2*go}
		 i=instance_create(x+12,y+12,part) with(i){type=4 hspeed=1 vspeed=-1+2*go}
		 i=instance_create(x+4,y+4,part) with(i){type=4 hspeed=-1 vspeed=-3+2*go}
		 i=instance_create(x+12,y+4,part) with(i){type=4 hspeed=1 vspeed=-3+2*go}
	}
	coll= collision(0,1) //if ther'es two below him, break both at once.
	if coll.object_index==hardblock with coll{
		sound("itemblockbreak")
		instance_destroy();
		 i=instance_create(x+4,y+12,part) with(i){type=4 hspeed=-1 vspeed=-1+2*go}
		 i=instance_create(x+12,y+12,part) with(i){type=4 hspeed=1 vspeed=-1+2*go}
		 i=instance_create(x+4,y+4,part) with(i){type=4 hspeed=-1 vspeed=-3+2*go}
		 i=instance_create(x+12,y+4,part) with(i){type=4 hspeed=1 vspeed=-3+2*go}
	}
	if object_is_ancestor(coll.object_index,hittable) with coll{
		sound("itemblockbreak")
		instance_destroy();
		 i=instance_create(x+4,y+12,part) with(i){type=4 hspeed=-1 vspeed=-1+2*go}
		 i=instance_create(x+12,y+12,part) with(i){type=4 hspeed=1 vspeed=-1+2*go}
		 i=instance_create(x+4,y+4,part) with(i){type=4 hspeed=-1 vspeed=-3+2*go}
		 i=instance_create(x+12,y+4,part) with(i){type=4 hspeed=1 vspeed=-3+2*go}
	}
	
	shoot(x-8,y+4,psmoke,-2,-1)
        shoot(x+8,y+4,psmoke,2,-1)    
}
playsfx(name+"step")

//jump buffering
if (jumpbuffer) jumpbuffer=-1     

if (piped=1 && star=0 && depth=-11 && friction=0.05 && jump=0) set_sprite("spin")

#define death
if (event="create"){
c=0
del=0
a=0
visible=0
sprite="dead"
frame=0
frspd=0.2
alpha=1
mybow=noone
bow=0


if owner.sprite!=sprite {owner.sprite=sprite with owner set_sprite(sprite)}
name=owner.name
p2=owner.p2
owner=owner.id
size=owner.size
if size==5 size=0
xsc=owner.xsc
ysc=owner.ysc
water=owner.water
frn=owner.frn
dodeathanim=owner.dodeathanim
mariodeath=owner.mariodeath


if (dodeathanim || mariodeath) {visible=1}

if mariodeath {
	alarmmp=60
	alarm0=30
	alarm1=300
}

}

else if (event="step") {

	if mariodeath {
		alarm0=max(0,alarm0-1)
		alarm1=max(0,alarm1-1)
		if (alarm0=0 && !didonce) {
			vspeed=-3.5 gravity=0.1-(owner.water*0.015) didonce=1
		}
		alarmmp=max(0,alarmmp-1)
		if alphadecay &&!alarmmp alpha-=0.1
		if alarm1=0 instance_destroy()
	}

		for (i=0;i<=360;i+=10) if (!irandom(5) && c<20) repeat (4-3*(i>180)) {
			splat=playerskindat(owner.p2,"kidsplat"+string(owner.p2)) || del
			owner.me=id
			with(owner){
			o=fire_projectile(me.x,me.y)}
			o=owner.o
			if instance_exists(o) {
			o.bloddrop=1
			o.bullet=0
			o.gib=0
			o.bow=0
			o.direction=i
			o.owner=owner
			o.del=del
			o.splat=splat
			o.a=a
			o.speed=random(7)
			o.gravity=random_range(0.1,0.3)
			o.u=choose(owner.blood_sheetx[owner.size*owner.projcoordbysize],owner.blood_sheetx[owner.size*owner.projcoordbysize]+7)
			o.v=choose(owner.blood_sheety[owner.size*owner.projcoordbysize],owner.blood_sheety[owner.size*owner.projcoordbysize]+7)
			o.b=irandom(3)
			o.image_xscale=3
			o.image_yscale=3
			if (water) {
				o.speed=random(2)
				o.gravity=0
				o.friction=0.01
				o.water=1
				}
			}
		}


	if (!del) if (c<4) {
		with(owner)
		owner.me=id
		o=fire_projectile(me.x,me.y)
		o=owner.o
		if instance_exists(o) {
		o.gib=1
		o.bullet=0
		o.bow=0
		o.bloddrop=0
		o.type=c
		o.owner=owner
		o.speed=random_range(2,4)
		o.direction=random_range(45,135)
		o.gravity=0.4
		o.fade=0
		o.a=1
		o.image_xscale=3
		o.image_yscale=3
		o.bow=0
		if (water) {
			o.speed=random(3)
			o.gravity=0.1
			o.friction=0.01
		}
		}
		
		with (o) {
			if (type=3) {
				w=16 h=16
				u=owner.gibhead_sheetx v=owner.gibhead_sheety
			} else {
				w=8 h=8
				u=owner.giblimbs_sheetx+9*type v=owner.giblimbs_sheety
			}
		}
	}

	spriteswitch(1)

	c+=1 if (c=20 && !visible) instance_destroy()
	
} 
else if (event="draw"){
//if (!del) spriteswitch(0)
}

#define enterpipe
push=0


#define exitpipe
mybow=noone //technically our bow dies offscreen, but the pointer doesn't. we'll recognize it's gone when we're out and make a new one

if (type="door") {}
if (type="side") {}
if (type="up") {}
if (type="down") {}
