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
type=""
alarm[0]=200
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite=type+"spikeballthrow"
alarm[1]=70
alarm[2]=10
hspeed=0
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite=type+"spike"
if type="old" hspeed=-0.5*xsc
alarm[0]=200
#define Alarm_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
switch (type) {
    case "old": {
        with (instance_create(x,y-12,spikeball)) {hspeed=0 alarm[0]=40 owner=other.id xsc=owner.xsc hasgrav=0 gravity=0 vspeed=0 type=other.type}
    break}
    case "fire": {
        with (instance_create(x,y-12,fireballplant)) {hspeed=0 vspeed=0 alarm[0]=40 owner=other.id xsc=owner.xsc orig=owner}
    break}
    default: {
        with (instance_create(x,y-12,spikeball)) {hspeed=0 alarm[0]=40 owner=other.id xsc=owner.xsc hasgrav=1 gravity=0 vspeed=0 type=other.type}
    }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type!="old" xsc=esign(x-nearestplayer().x,1)
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
switch (spiketype) {
    case "1": { //Classic (SMB3-ish)
        type="old"
        hspeed=-0.5
    break}
    case "2": { //Snow
        type="snow"
    break}
    case "3": { //Fire
        type="fire"
    break}
    default: {
        type=""
    break}
}
sprite=type+"spike"
