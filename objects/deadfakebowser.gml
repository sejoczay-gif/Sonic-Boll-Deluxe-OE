#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xsc=-1
ysc=-1
gravity=0.075
panic=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (collision(0,4).object_index != bridgeblock || kil) {gravity=0.075 kil=1}
if (!inview() && btype) {sound("finalbowserdie", 0, 1 - ((btype - 1) * 0.165)) instance_destroy()}
step = (step + 0.125) mod 2
#define Collision_collider
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!kil) {
    vspeed=0 gravity=0
    y=other.y-18
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*if btype=1 sprite="bowser"
else if btype=2 sprite="dowser"
else sprite="fakebowser"

ssw_enemy(sprite+"panic",1)*/
ssw_boss()
