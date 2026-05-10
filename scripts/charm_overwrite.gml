///charm_load(filename,modded,myid)
var fn,state,script,c,f,str,name,protecc,i;

//this is /*"/**/ and it collects open strings and open comments
protecc="/*"+qt+"/**/"

if (current_time>global.loadtime+64) loadtext()

state=0
script=""
c=argument[2]
movesetpage=0

name=string(filename_name(argument[0]))

for (i=0;(string(global.movelist[c,i])!="0" || string(movelistcache[i])!="0");i+=1) {global.movelist[c,i]="" movelistcache[i]=""}
for (i=0;i<5;i+=1) global.pagespec[c,i]=-1
//for compatibility
global.pagespec[c,0]=0
global.damagercode[c]=""
global.projectilecode[c]=""
global.deathcode[c]=""
global.defaultspritelist[c]=""
global.soundlist[c]=""
global.charmod[c]=argument[1]
global.charicon[c,0]=spr_unknown
global.charlock[c]=spr_unknown
global.chariconr[c]=spr_chariconb
//global.chariconb[c]=spr_unknown
global.chariconsp[c,0]=spr_missingsprays
global.charname[c]=name
global.charbio[c]=""
global.chargames[c]=""
global.chardata[c]="No data."
global.changecode[c]=""
global.rosterswap[c]=""
global.unlockdata[c]=""

fn=string(argument[0])+"\"+name+".gml"

if (!file_exists(fn) || !file_exists(filename_change_ext(fn,"-card.png")) || !file_exists(argument[0]+"\"+"player.txt")) exit

cacheload = 1

if (file_exists(global.savedir+"cache\charm\"+name+".gml")) {
    execute_file(global.savedir+"cache\charm\"+name+".gml", argument[0], name, c)
    script = global.__cachedscript;
    broken = global.__tempbroken;
    global.__cachedscript = ""
    global.__tempbroken = 0
    if (!settings(name + " disabled")) execute_string(global.unlockdata[c])
} else {
    cacheload = 0;
}

if (!cacheload) {
    
    var str,opencount,closecount,closeline,blockcomment;
    f=file_text_open_read(fn);
    while (!file_text_eof(f)) {
        str="" opencount=0 closecount=0 closeline=0 blockcomment=0
        str = string_replace_all(file_text_read_string(f),chr(9)," ")
        if (string_replace_all(str," ","")!="") {
            if (str="#" && state=4) str=""
            blockcomment = string_count("/*",script) - string_count("*/",script) - string_count(protecc,script)
            if (string_pos("#define",str)) {
                if ((string_pos("#define",str) < string_pos("//",str)) || !string_pos("//",str) && !blockcomment) {
                    if (state=-1) script+=protecc+"return 0}"+lf
                    if (string_pos("rosterorder",str)) state=1
                    else if (string_pos("spritelist",str)) state=2
                    else if (string_pos("soundlist",str)) state=3
                    else if (string_pos("movelist",str)) state=4
                    else if (string_pos("damager",str)) state=5
                    else if (string_pos("projectile",str)) state=6
                    else if (string_pos("description",str)) state=7
                    else if (string_pos("death",str)) state=8
                    else if (string_pos("customchange",str)) state=9
                    else if (string_pos("rosterswap",str)) state=10
                    else if (string_pos("unlock",str)) state=11
                    else if (string_pos("lockvariable",str)) state=12
                    else {
                        state=-1
                        script+="if (entrypoint="+qt+string_letters(string_replace(str,"#define",""))+qt+") {"+protecc+lf
                    }
                    continue       
                }
                
            }
            switch(state) {
                case 1: global.rosterorder[c]=unreal(str,0) state=0 break;
                case 2: global.defaultspritelist[c]=str state=0 break;
                case 3: global.soundlist[c]=str state=0 break;
                case 4: addmovelist(c,str) break;
                case 5: global.damagercode[c]+=str+lf break;
                case 6: global.projectilecode[c]+=str+lf break;
                case 7: global.chardata[c]=str state=0 break;
                case 8: global.deathcode[c]+=str+lf break;
                case 9: global.changecode[c]+=str+lf break;
                case 10: global.rosterswap[c]+=str break;
                case 11: global.unlockdata[c]+=str+lf break;
                case 12: charm_lock(str,name) state=0 break;
                default: script+=str+lf break;
            }
        }
        file_text_readln(f);
        if (current_time>global.loadtime+64) loadtext(1)
    } file_text_close(f)
    if (state=-1) script+=protecc+" return 0}"+lf
    
}

if (script="") {error(lang("error charmload1")+fn+lang("error charm nocode")) exit}
keepmafn=fn
global.charicon[c,0]=sprite_add(filename_change_ext(fn,"-card.png"),1,0,0,12,12)
if (global.charicon[c,0]) {
    if (sprite_get_width(global.charicon[c,0])!=24 || sprite_get_height(global.charicon[c,0])!=24) {
        error(lang("error icon dimensions")+filename_change_ext(fn,"-card.png"))
        sprite_delete(global.charicon[c,0])
        global.charicon[c,0]=spr_unknown
    }
} else global.charicon[c,0]=spr_unknown


global.charlock[c]=sprite_add(filename_change_ext(fn,"-lock.png"),1,0,0,12,12)
if (global.charlock[c]) {
    if (sprite_get_width(global.charlock[c])!=24 || sprite_get_height(global.charlock[c])!=24) {
        error(lang("error icon dimensions")+filename_change_ext(fn,"-lock.png"))
        sprite_delete(global.charlock[c])
        global.charlock[c]=spr_unknown
    }
} else global.charlock[c]=spr_unknown


global.chariconsp[c,0]=sprite_add(filename_change_ext(fn,"-sprays.png"),1,1,0,0,0)
if !(global.chariconsp[c,0]) {
    global.chariconsp[c,0]=spr_missingsprays
}

fn=keepmafn
global.chariconr[c]=sprite_add(argument[0]+"\"+name+"-replay.png",1,1,0,0,0)
fn=keepmafn
if !sprite_exists_0(global.chariconr[c]) global.chariconr[c,0]=spr_chariconb
//global.chariconb[c]=spr_unknown
global.charicone[c]=sprite_add(argument[0]+"\"+name+"-emblem.png",1,1,0,0,0)


/*if (file_exists(argument[0]+"\bio.txt")) {
    f=file_text_open_read(argument[0]+"\bio.txt")
    if (f) {
        global.charbio[c]=file_text_read_string(f)
        file_text_readln(f)
        global.chargames[c]=file_text_read_string(f)
        file_text_close(f)
    }
}*/


if (!cacheload) {
    error_occurred=0      
    with (instance_create(0,0,compiler_dummy)) {
        entrypoint="null_test"
        execute_string(script)
        event="null_test"
        execute_string(global.projectilecode[c])
        if (current_time>global.loadtime+64) loadtext(1)
        owner=id
        execute_string(global.damagercode[c])
        execute_string(global.deathcode[c])
        if (!settings(name + " disabled")) execute_string(global.unlockdata[c]) //this technically should Not be here it doesn't use events but theres charms that use this to run game-start code so idc
        if (current_time>global.loadtime+64) loadtext(1)
        instance_destroy()
    }
    if (error_occurred) {
        file_delete(argument[0]+"\errors.txt")
        if (file_exists(argument[0]+"\errors.txt"))
            file_rename("game_errors.log",argument[0]+"\errors.txt")
        else {
            f=file_text_open_write(argument[0]+"\errors.txt")
            file_text_write_string(f,error_last)
            file_text_close(f)
        }
        error_occurred=0
        settings(name+" broken",1)
        if (!argument[1]) error(lang("error vanilla broken")+name,1)
    } else {
        settings(name+" broken",0)
        global.charcode[c]=script       
    }

} else { //no need to error check if we already know the outcome #einsteinstrats
    if (broken) {settings(name+" broken",1) if (!argument[1]) error(lang("error vanilla broken")+name,1)}
    else {settings(name+" broken",0) global.charcode[c]=script}
}


if (!cacheload) {

    // Cache the "loaded" charm to a file to load the charm faster later
        
        var cf;
        
        if (!directory_exists(global.savedir+"cache\charm\")) {
            directory_create(global.savedir+"cache\charm\")
        }
        
        cf = file_text_open_write(global.savedir+"cache\charm\"+name+".gml")
        
        if (cf == -1) exit;
        
        file_text_write_string(cf, "name = argument[1]; c = argument[2]; global.__tempbroken="+string(settings(name+" broken"))+"; ")
        file_text_write_string(cf, "if string(sha1_file(argument[0]+'\'+name+'.gml')) != '"+string(sha1_file(argument[0]+"\"+name+".gml"))+"' {cacheload = 0; exit;}")
        
        file_text_write_string(cf, "global.__cachedscript = string_replace_all(string_replace_all('"+string_replace_all(string_replace_all(script, "'", "/@+/"), '"', "/@++/")+"', '/@+/', '"+qt+"'), '/@++/', "+qt+"'"+qt+")")
        file_text_writeln(cf)
        file_text_write_string(cf, "global.projectilecode[c] = string_replace_all(string_replace_all('"+string_replace_all(string_replace_all(global.projectilecode[c], "'", "/@+/"), '"', "/@++/")+"', '/@+/', '"+qt+"'), '/@++/', "+qt+"'"+qt+")")
        file_text_writeln(cf)
        file_text_write_string(cf, "global.damagercode[c] = string_replace_all(string_replace_all('"+string_replace_all(string_replace_all(global.damagercode[c], "'", "/@+/"), '"', "/@++/")+"', '/@+/', '"+qt+"'), '/@++/', "+qt+"'"+qt+")")
        file_text_writeln(cf)
        file_text_write_string(cf, "global.deathcode[c] = string_replace_all(string_replace_all('"+string_replace_all(string_replace_all(global.deathcode[c], "'", "/@+/"), '"', "/@++/")+"', '/@+/', '"+qt+"'), '/@++/', "+qt+"'"+qt+")")
        file_text_writeln(cf)
        file_text_write_string(cf, "global.changecode[c] = string_replace_all(string_replace_all('"+string_replace_all(string_replace_all(global.changecode[c], "'", "/@+/"), '"', "/@++/")+"', '/@+/', '"+qt+"'), '/@++/', "+qt+"'"+qt+")")
        file_text_writeln(cf)
        file_text_write_string(cf, "global.unlockdata[c] = string_replace_all(string_replace_all('"+string_replace_all(string_replace_all(global.unlockdata[c], "'", "/@+/"), '"', "/@++/")+"', '/@+/', '"+qt+"'), '/@++/', "+qt+"'"+qt+")")
        file_text_writeln(cf)
        file_text_write_string(cf, "global.rosterorder[c] = " + string(global.rosterorder[c])
                              +  "; global.defaultspritelist[c] = '" + global.defaultspritelist[c]
                              + "'; global.soundlist[c] = '" + global.soundlist[c]
                              + "'; global.chardata[c] = string_replace_all(string_replace_all('"+string_replace_all(string_replace_all(global.chardata[c], "'", "/@+/"), '"', "/@++/")+"', '/@+/', '"+qt+"'), '/@++/', "+qt+"'"+qt
                              + "); global.rosterswap[c] = '" + global.rosterswap[c] + "';")
        file_text_writeln(cf)
        if string(mylock) != "0" file_text_write_string(cf, "charm_lock("+mylock+",name)")
        file_text_writeln(cf)
        var spec;
        spec = 0;
        
        i = 0
        repeat (movesetpage + 1) {
            spec = findspec[i];    
            file_text_write_string(cf,"global.pagespec[c, "+string(spec)+"] = "+string(global.pagespec[c, spec])+"; ") 
            file_text_writeln(cf)
            file_text_write_string(cf,"global.movelist[c, "+string(i)+"] = string_replace_all(string_replace_all(replacebuttonnames('"+string_replace_all(string_replace_all(string(movelistcache[i]), "'", "/@+/"), '"', "/@++/") +"'), '/@+/', '"+qt+"'), '/@++/', "+qt+"'"+qt+")")
            i += 1
        }
                
        file_text_close(cf)
}
