if !variable_global_get("cobject_code_"+string(data[0])+"_"+argument[0]) {
    var thefile, thecode, curinator, founded;
    thefile=globalmanager.moddir+"object\"+string(data[0])+"\object.gml"
    if !file_exists(globalmanager.moddir+"object\"+string(data[0])+"\object.gml") {break}
    else {
        thecode=file_text_open_read(thefile)
        curinator=""

        while (!file_text_eof(thecode)) {

            curinator=file_text_read_string(thecode)

            if string_starts_with(curinator, "#define") {
                curinator=string_delete(curinator, 1, 8)
                if curinator=argument[0] founded=1
            }

            file_text_readln(thecode)
            if file_text_eof(thecode) {
                break;
            }
        }
        file_text_close(thecode)

        if !founded return code_execute("")

        variable_global_set("cobject_code_"+string(data[0])+"_"+argument[0],code_compile(loopThrough(argument[0],globalmanager.moddir+"object\"+string(data[0])+"\object.gml")))
        my_code=variable_global_get("cobject_code_"+string(data[0])+"_"+argument[0])
    }
} else {
    my_code=variable_global_get("cobject_code_"+string(data[0])+"_"+argument[0])

}
//global.cobjectentrypoint=argument[0]
global.cobjectlemontype=argument[1]
global.cobjectlemondefault=argument[2]


return code_execute(my_code)
