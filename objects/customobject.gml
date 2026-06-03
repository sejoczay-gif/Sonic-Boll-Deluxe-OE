#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
alarm[0]=1

IMNOTDONEYET=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var thecode, listinator, curinator, keyinator, i_iterationator;

IMNOTDONEYET=0

thefile=globalmanager.moddir+"object\"+mytype+"\object.gml"
if string(mytype)=""||string(mytype)="0" || !file_exists(thefile) {instance_destroy() exit}

thecode=file_text_open_read(thefile)
listinator=ds_list_create()
curinator=""

while (!file_text_eof(thecode)) {

    curinator=file_text_read_string(thecode)

    if string_starts_with(curinator, "#define") {
        curinator=string_delete(curinator, 1, 8)
        ds_list_add(listinator,curinator)
    }

    file_text_readln(thecode)
    if file_text_eof(thecode) {
        break;
    }
}
file_text_close(thecode)

i_iterationator=0
repeat(ds_list_size(listinator)) {
    keyinator = ds_list_find_value(listinator,i_iterationator);

    switch(keyinator) {
        case "create":
            if !variable_global_get("cobject_code_"+mytype+"_"+"create") {
                variable_global_set("cobject_code_"+mytype+"_"+"create",code_compile(loopThrough("create",thefile)))
                createevent=variable_global_get("cobject_code_"+mytype+"_"+"create")
            } else {
                createevent=variable_global_get("cobject_code_"+mytype+"_"+"create")
            }
        break;
        case "step":
            if !variable_global_get("cobject_code_"+mytype+"_"+"step") {
                variable_global_set("cobject_code_"+mytype+"_"+"step",code_compile(loopThrough("step",thefile)))
                stepevent=variable_global_get("cobject_code_"+mytype+"_"+"step")
            } else {
                stepevent=variable_global_get("cobject_code_"+mytype+"_"+"step")
            }
        break;
        case "draw":
            if !variable_global_get("cobject_code_"+mytype+"_"+"draw") {
                variable_global_set("cobject_code_"+mytype+"_"+"draw",code_compile(loopThrough("draw",thefile)))
                drawevent=variable_global_get("cobject_code_"+mytype+"_"+"draw")
            } else {
                drawevent=variable_global_get("cobject_code_"+mytype+"_"+"draw")
            }
        break;
        case "draw_hud":
            if !variable_global_get("cobject_code_"+mytype+"_"+"draw_hud") {
                variable_global_set("cobject_code_"+mytype+"_"+"draw_hud",code_compile(loopThrough("draw_hud",thefile)))
                drawhudevent=variable_global_get("cobject_code_"+mytype+"_"+"draw_hud")
            } else {
                drawhudevent=variable_global_get("cobject_code_"+mytype+"_"+"draw_hud")
            }
        break;
        case "lemon_display":
        case "editobjmenu":
        case "editobjdataname":
        case "deloaded": break;
        default : show_debug_message("Invalid define ("+keyinator+") in "+string(mytype)) break;
    }
    i_iterationator+=1;
}
ds_list_destroy(listinator);



//.. is it really this simple? Uhh... wow.


///not so shrimple now -- c
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if IMNOTDONEYET||(stepevent==0) exit
code_execute(stepevent)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if IMNOTDONEYET||(drawevent==0) exit
code_execute(drawevent)
