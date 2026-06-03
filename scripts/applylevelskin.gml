///applylevelskin(directory,loadspec)
//applies level skins

var wskin, successes, i, fn, loadspec;
wskin = argument[0]+"\"
loadspec=0
if (argument_count >= 2) loadspec=argument[1]

//how did we get here? if argument is skin just assume its over and done with
if argument[0]==global.wskins[1+global.worldskin,0] {global.exception="" global.exceptdir="" applyworldskin(global.wskins[1+global.worldskin,0],loadspec) global.lemonlskin="" updatemusic() exit;}

// kelloggs was here

for (i=0;i<global.biomes;i+=1) {
    if (loadspec && !(loadspec & (1 << i))) // skip if loadspec says this biome isn't needed
        continue
    if (directory_exists(wskin+global.biome[i])) {
        
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
        replacesheet("","enemy_"+string(i),wskin+global.biome[i]+"\enemy.png",330,1824,1)
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
        successes+=1
    } else {show_debug_message("I HAAAATE IT!!##Couldn't find "+global.biome[i]+"##Directory = "+wskin+global.biome[i])}
}

if !successes && !directory_exists(wskin+"music\") && !directory_exists(wskin+"sfx\") && !directory_exists(wskin+"assets\") {
    applyworldskin(global.wskins[1+global.worldskin,0],loadspec)
    updatemusic()
    show_message("Failed to load level skin.")
    return 0
}   

if string(global.currentlevel)!="0" && string(global.currentlevel)!="" global.exception = global.currentlevel
else global.exception=global.lemonlskin
global.exceptdir = wskin

replaceanimbg("special",wskin,"sky")
    
replacefont(wskin)

for (i=1;i<=7;i+=1) if (!replacesheet("","specialstage"+string(i),wskin+"special\specialstage-"+string(i)+".png",256,128,1)) {i-=1 break}
skindat("specialsheets",i+1)
if (i=0) replacesheet("","specialstage1",wskin+"specialstage.png",256,128,1)

if (directory_exists(wskin+"assets")) {
    replaceasset(wskin,global.lskins[global.levelskin+1,0])
}

with globalmanager {
    for (i=0;i<=musc;i+=1) {
        replacemusic(mload[i], wskin+"music\")
    }
}

replaceworldsfx(wskin)

return 1
