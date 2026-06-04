#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
//hspeed=-0.5
brat=0
sprite="spike"
alarm[0]=200
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite="spikeballthrow"
alarm[1]=70
alarm[2]=10
hspeed=0
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite="spike"
//hspeed=-0.5*xsc
alarm[0]=200
#define Alarm_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (instance_create(x,y-12,spikeball)) {hspeed=0 alarm[0]=40 owner=other.id xsc=owner.xsc hasgrav=1 gravity=0 vspeed=0}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xsc=esign(x-nearestplayer().x,1)
