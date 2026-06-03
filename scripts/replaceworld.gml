///replaceworld(path)
//apply world skin

wskin=argument[0]
loadspec=0
if (argument_count >= 2) loadspec=argument[1]
// kelloggs was here

for (i=0;i<global.biomes;i+=1) {
    if (loadspec != -1) {
        if (loadspec && !(loadspec & (1 << i))) // skip if loadspec says this biome isn't needed
            continue
    }
    
    global.useterrainpng=1
    fn=wskin+global.biome[i]+"\tiles-new.png"
    if (file_exists(fn)) background_replace(global.master[i],fn,1,0)
    else if file_exists(wskin+"\tiles-new.png")  background_replace(global.master[i],wskin+"\tiles-new.png",1,0)
    fn=wskin+global.biome[i]+"\terrain.png"
    if (file_exists(fn)) background_replace(global.masterterrain[i],fn,1,0)
    else if file_exists(wskin+"\terrain.png")  background_replace(global.masterterrain[i],wskin+"\terrain.png",1,0)
    fn=wskin+global.biome[i]+"\objects.png"
    if (file_exists(fn)) background_replace(global.masterobjects[i],fn,1,0)
    else if file_exists(wskin+"\objects.png")  background_replace(global.masterobjects[i],wskin+"\objects.png",1,0)
    fn=wskin+global.biome[i]+"\decor.png"
    if (file_exists(fn)) background_replace(global.masterdecor[i],fn,1,0)
    else if file_exists(wskin+"\decor.png")  background_replace(global.masterdecor[i],wskin+"\decor.png",1,0)
    
    
    skindat("tex_master"+string(i),global.master[i])
    skindat("tex_master"+string(i)+"_filename",fn)
    skindat("tex_master"+string(i)+"_transp",1)
    
    var j;
    repeat (9) {     
        cleananimbg(global.biome[i],wskin,"daysky",j)
        cleananimbg(global.biome[i],wskin,"eveningsky",j)
        cleananimbg(global.biome[i],wskin,"nightsky",j)
        cleananimbg(global.biome[i],wskin,"daytrans",j)
        cleananimbg(global.biome[i],wskin,"eveningtrans",j)
        cleananimbg(global.biome[i],wskin,"nighttrans",j)
        j+=1;
    }
    
    
    
    //fallback
    replaceanimbg(global.biome[i],wskin,"sky")
    
    replaceanimbg(global.biome[i],wskin,"daysky")
    replaceanimbg(global.biome[i],wskin,"eveningsky")
    replaceanimbg(global.biome[i],wskin,"nightsky")
    
    replaceanimbg(global.biome[i],wskin,"trans")
    
    replaceanimbg(global.biome[i],wskin,"daytrans")
    replaceanimbg(global.biome[i],wskin,"eveningtrans")
    replaceanimbg(global.biome[i],wskin,"nighttrans")
    
    replaceanimbg(global.biome[i],wskin,"below")
    replaceanimbg(global.biome[i],wskin,"water")
    
    replacesheet("","item"+string(i),wskin+global.biome[i]+"\item.png",144,288,1)
    global.itemsheet[i]=skindat("tex_item"+string(i))
    replacesheet("","topsecret"+string(i),wskin+global.biome[i]+"\itern.png",144,288,1)
    global.topsheetcret[i]=skindat("tex_topsecret"+string(i))
    replacesheet("","enemy_"+string(i),wskin+global.biome[i]+"\enemy.png",500,1000,1)
    global.enemysheet[i]=skindat("tex_enemy_"+string(i))
    replacesheet("","boss"+string(i),wskin+global.biome[i]+"\boss.png",500,500,1)
    global.bosssheet[i]=skindat("tex_boss"+string(i))
    replacesheet("","bowser"+string(i),wskin+global.biome[i]+"\bowser.png",500,500,1)
    global.bowsersheet[i]=skindat("tex_bowser"+string(i))
    replacesheet("","dowser"+string(i),wskin+global.biome[i]+"\dowser.png",500,500,1)
    global.dowsersheet[i]=skindat("tex_dowser"+string(i))
    replacesheet("","effects"+string(i),wskin+global.biome[i]+"\effects.png",215,315,1)
    global.effectssheet[i]=skindat("tex_effects"+string(i))  
    replacesheet("","monitor"+string(i),wskin+global.biome[i]+"\monitor.png",144,184,1)  
    global.monitorsheet[i]=skindat("tex_monitor"+string(i))
}

replaceanimbg("special",wskin,"sky")
replacehud(global.wbase)
replacefont(wskin)
replacesheet("","gameover",wskin+"gameover.png",0,0,0)
replacesheet("","change",wskin+"change.png",0,0,0)
replacesheet("","hud-classic",wskin+"hud-classic.png",0,0,1)
replacesheet("","hud-battle",wskin+"hud-battle.png",0,0,1)
replacesheet("","hud-timeattack",wskin+"hud-timeattack.png",0,0,1)
replacesheet("","hud-coop",wskin+"hud-coop.png",0,0,1)
replacesheet("","retainer",wskin+"retainer.png",279,178,1)
replacesheet("","pause",wskin+"pause.png",0,0,1)


for (i=1;i<=7;i+=1) {
    if (!replacesheet("","specialstage"+string(i),wskin+"special\specialstage-"+string(i)+".png",256,128,1)) {
        i-=1
        break
    }
}
skindat("specialsheets",i+1)
if (i=0) {
    replacesheet("","specialstage1",wskin+"specialstage.png",256,128,1)
}

skindat("anims"         ,funnytruefalse(skindat("settings snes animations"      )))
skindat("chkrng"        ,funnytruefalse(skindat("settings checkpoint ring"      )))
skindat("bricd"         ,funnytruefalse(skindat("settings bricks explode"       )))
skindat("toadjump"      ,funnytruefalse(skindat("settings retainer jump"        )))    
skindat("signpost"      ,funnytruefalse(skindat("settings sonic signpost"       )))
skindat("itemflip"      ,funnytruefalse(skindat("settings items turn around"    )))
skindat("groundstag"    ,funnytruefalse(skindat("settings stagger ground"       )))               
skindat("gameoverfade"  ,funnytruefalse(skindat("settings game over fade"       )))
skindat("grasslayer"    ,funnytruefalse(skindat("settings layered grass"        )))
skindat("mariotime"     ,funnytruefalse(skindat("settings mario timer"          )))
skindat("left"          ,funnytruefalse(skindat("settings go left"              )))
skindat("brickvar"      ,funnytruefalse(skindat("settings brick variations"     )))
skindat("cardtext"      ,funnytruefalse(skindat("settings level card text"      )))
skindat("pitchkick"     ,funnytruefalse(skindat("settings pitch kick sound"     )))
skindat("nofade"        ,funnytruefalse(skindat("settings disable fades"        )))
skindat("classflag"     ,funnytruefalse(skindat("settings classic flag"         )))
skindat("chopbar"       ,funnytruefalse(skindat("settings choppy firebars"      )))
skindat("liqsync"       ,funnytruefalse(skindat("settings sync liquid animation")))
skindat("skipchange"    ,funnytruefalse(skindat("settings skip level card"      )))    

skindat("uppercase"     ,funnytruefalse(skindat("lang uppercase text"           )))

skinstr("langthanks"    ,skindat("lang thank you"   ))
skinstr("langbut"       ,skindat("lang but"         ))
    
if (settings("mirror")) skindat("left",!skindat("left"))
    
skindat("itspd",median(1,round(unreal(skindat("settings item anim speed"),8)),64))
skindat("bgspd",median(1,round(unreal(skindat("settings bg anim speed"),8)),256))
    
skindat("hurrytime",median(1,round(unreal(skindat("music hurry timer"),30)),100))                                                                                                              
skindat("deathmusic",funnytruefalse(skindat("music music continues after death")))
skindat("nofast",!funnytruefalse(skindat("music fast music")))  
skindat("bossmusic",funnytruefalse(skindat("music boss music"))) 
skindat("autofast",power(root12of2,median(0,unreal(skindat("music automatic fast music semitones"),0),12)))
    
skindat("voffset",median(-64,unreal(skindat("settings vertical offset"),8),64))

skindat("walpha",median(0.1,unreal(skindat("settings water alpha"),1),1))
    
skindat("walkin",funnytruefalse(skindat("settings walk into castle")))
    
skindat("ealign",unreal(skindat("settings hud energy alignment"),1))
skindat("hudlayer",unreal(skindat("settings hud layer"),1))

global.enemyoffx=unreal(skindat("enemy center x"),0)
global.enemyoffy=unreal(skindat("enemy center y"),0)
global.enemywidth=unreal(skindat("enemy box width"),32)
global.enemyheight=unreal(skindat("enemy box height"),32)

for (i=0;i<global.enemysprites;i+=1) {
    global.enemysprite[i,1]=median(1,unreal(skindat("enemy "+global.enemysprite[i,0]+" frames"),1),32)
    global.enemysprite[i,2]=median(0,unreal(skindat("enemy "+global.enemysprite[i,0]+" speed"),0.125),1)
    global.enemysprite[i,3]=median(1,unreal(skindat("enemy "+global.enemysprite[i,0]+" loop"),1),global.enemysprite[i,1])-1
}

global.enemysprite[i,4]=0
global.enemysprite[i,5]=0

i=0
repeat (global.enemysprites) {
    if i!=0 {

        global.enemysprite[i,4]=global.enemysprite[i-1,4]
        global.enemysprite[i,5]=global.enemysprite[i-1,5]

        if funnytruefalse(skindat("enemy "+global.enemysprite[i,0]+" connect")) {
            global.enemysprite[i,4]+=global.enemysprite[i-1,1]
        } else {
            global.enemysprite[i,4]=0
            global.enemysprite[i,5]+=1
        }
    }
    i+=1
}

global.enemybosssheetheight=unreal(skindat("enemy boss sheet height"),128)
global.enemybossoffx=unreal(skindat("enemy boss center x"),0)
global.enemybossoffy=unreal(skindat("enemy boss center y"),0)
global.enemybosswidth=unreal(skindat("enemy boss box width"),60)
global.enemybossheight=unreal(skindat("enemy boss box height"),60)

for (i=0;i<global.enemybosssprites;i+=1) {
    global.enemybosssprite[i,1]=median(1,unreal(skindat("enemy boss "+global.enemybosssprite[i,0]+" frames"),1),32)
}

global.enemybosssprite[i,2]=0
global.enemybosssprite[i,3]=0

i=0
repeat (global.enemybosssprites) {
    if i!=0 {

        global.enemybosssprite[i,2]=global.enemybosssprite[i-1,2]
        global.enemybosssprite[i,3]=global.enemybosssprite[i-1,3]

        if funnytruefalse(skindat("enemy boss "+global.enemybosssprite[i,0]+" connect")) {
            global.enemybosssprite[i,2]+=global.enemybosssprite[i-1,1]
        } else {
            global.enemybosssprite[i,2]=0
            global.enemybosssprite[i,3]+=1
        }
    }
    i+=1
}

replaceworldsfx(wskin)
