#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale=1
image_yscale=1

/*gravity=0.2
vspeed=-2*/

owner=noone

type=0

//sound("enemyhammerthrow")
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
 i=instance_create(x+4 ,y+12,spikeballpart) i.hspeed=-1 i.vspeed=-1+2*go  i.ps=0 i.ps2=1 i.type=type
 i=instance_create(x+12,y+12,spikeballpart) i.hspeed=1 i.vspeed=-1+2*go  i.ps=1 i.ps2=1 i.type=type
 i=instance_create(x+4 ,y+4 ,spikeballpart) i.hspeed=-1 i.vspeed=-3+2*go i.ps=0 i.ps2=0 i.type=type
 i=instance_create(x+12,y+4 ,spikeballpart) i.hspeed=1 i.vspeed=-3+2*go i.ps=1 i.ps2=0 i.type=type
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*vspeed=-0.5
hspeed=-1*owner.xsc*/
ready=1
if hasgrav {
    gravity=0.2
    vspeed=-2
    hspeed=-1.5*owner.xsc
} else {
    gravity=0
    vspeed=0
    hspeed=-2*owner.xsc
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (pitdeath() || !inview()) instance_destroy()

if !hasgrav {
    if vspeed > 0 d=1
    if instance_place(x,y+5,owner) && d=1 && !ready {
        y-=1
        gravity=0
        vspeed=0
    }
}

/*coll=collision(hspeed,-4)
if (coll) && hasgrav {
    instance_destroy()
}*/

pla=nearestplayer()

coll=instance_place(x+hspeed,y,hittable)
if (coll) && hasgrav {
hitblock(coll,pla,1,-1,0)
instance_destroy()
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if hasgrav=1 && !alarm[0]
{
    /*
    //Old Spikeball code
    calcmoving()
    vspeed=min(3,vspeed)
    if (vspeed<0) {
        coll=collision(0,vspeed)
        if (coll) {
            y=coll.bbox_bottom+(y-bbox_top)+1
            vspeed=1
        } else vspeed=min(3,vspeed)
    } else {
        yground=easyground()
        if (bbox_bottom>=yground-1 && yground!=verybignumber) {
            vspeed=0
            y=floor(y)
            y=yground-(bbox_bottom-2-y)
        } else vspeed=min(3,vspeed)
    } */

    //Shell code copy

        calcmoving()
        time=max(0,time-1)
        if (vspeed<0) {
            vspeed+=0.15
            coll=collision(0,vspeed)
            if (coll) {
                sound("itemblockbump")
                if (object_is_ancestor(coll.object_index,hittable)) {
                    global.coll=nearestplayer()
                    with (coll) {insted=1 go=-1 event_user(0) insted=0}
                }
                vspeed=1
            }
        }
        if (vspeed>=0) {

            if (collision(0,vspeed) && !grounded) {


            s=esign(vspeed,1)
            y+=vspeed
            halved=0
            while (collision(0,0)) {
                y-=s
                if !halved {vspeed=-0.5*vspeed halved=1}
                if !floor(vspeed) vspeed=0
            }

            //vspeed=0

            belt=collision(0,1)
            if belt.object_index=conveyorbelt && !collision(belt.beltspd,0) && !collision(-belt.beltspd,0)
                x=x+belt.beltspd;


                if (stop) {
                    vspeed=-abs(vspeed)*0.25
                    hspeed*=0.5
                }
                if (abs(vspeed)<0.5 || !stop) {
                    vspeed=0
                    if (stop) {
                        hspeed=0
                        stop=0
                    }
                }
            } else if !grounded {vspeed=min(4,vspeed+0.15)}
        }
        coll=collision(hspeed,-4)
        if (coll) {
            //hspeed*=-1
            sound("itemblockbump")
            if (object_is_ancestor(coll.object_index,hittable)) {
                global.coll=nearestplayer()
                with (coll) {insted=1 go=-1 event_user(0) insted=0}
            }
            instance_destroy()

        }
}


if (place_meeting(x-2,y+1,nslopl) || place_meeting(x-2,y+1,nslopl2) || place_meeting(x+2,y+1,nslopr) || place_meeting(x+2,y+1,nslopr2))
{
if hasgrav=0
hasgrav=1
}

if hasgrav
{
if place_meeting(x-2,y+1,nslopl2s) && hspeed!=2
hspeed+=0.02

if place_meeting(x+2,y+1,nslopr2s) && hspeed!=-2
hspeed-=0.02

if place_meeting(x-2,y+1,nslopls) && hspeed!=2
hspeed+=0.15

if place_meeting(x+2,y+1,nsloprs) && hspeed!=-2
hspeed-=0.15

if place_meeting(x-2,y+1,nslopl2) && hspeed!=2
hspeed+=0.02

if place_meeting(x+2,y+1,nslopr2) && hspeed!=-2
hspeed-=0.02

if place_meeting(x-2,y+1,nslopl) && hspeed!=2
hspeed+=0.15

if place_meeting(x+2,y+1,nslopr) && hspeed!=-2
hspeed-=0.15
}

if (place_meeting(x-2,y+1,nslopls) && hspeed < 0 || place_meeting(x-2,y+1,nslopl2s) && hspeed < 0 || place_meeting(x+2,y+1,nsloprs) && hspeed > 0 || place_meeting(x+2,y+1,nslopr2s) && hspeed > 0)
{
if hasgrav=0
hasgrav=1
}
#define Collision_enemy
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//@todo: refactor

if (owner!=noone && owner!=other && owner.object_index=player) {doscore_e(8000,other.id) with (other) {sound("enemykick") with (instance_create(x,y,genericdead)) {hspeed*=sign(x-other.x) type=2 biome=other.biome} instance_destroy()}}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ssw_effects("spikeball"+type)
