#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (keyboard_check(vk_shift)) {
   settings("hardboiled",!settings("hardboiled")) // dankeschun poker
   settings("killjoy",0)
} else {
   settings("killjoy",!settings("killjoy"))
   settings("hardboiled",0)
}
sound("systemselect")
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (keyboard_check(vk_shift)) {
   settings("hardboiled",!settings("hardboiled")) // dankeschun poker
   settings("killjoy",0)
} else {
   settings("killjoy",!settings("killjoy"))
   settings("hardboiled",0)
}
sound("systemselect")
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (settings("hardboiled"))
   draw_sprite(sprite_index,!!over+4,x,y)
else draw_sprite(sprite_index,!!over+2*settings("killjoy"),x,y)

over=0
