///ssw_enemy(sprite,[isboss])
//This handles sprite switching for the various enemies
var frx,fry,index;

//if object_index!=bowserboss && object_index!=deadfakebowser {
if (eid!=-1) {
    index=string(argument[0])

    frx=frox+floor(frame)
    fry=froy
        draw_sprite_general(
    //  sprite, subimage
        global.enemysheet[biome],0,
    //  left, top
        8+frx*global.enemywidth,128+fry*global.enemyheight,
    //  width, height
        global.enemywidth-1,global.enemyheight-1,
    //  left top corner of the quad, accounting for rotation
        round(x)+xoff+lengthdir_x((margin-global.enemyoffx)*xsc,sprite_angle)+lengthdir_x((margin+dy-(14+global.enemyoffy))*ysc+14*ysc,sprite_angle-90),
        round(y)+yoff+lengthdir_y((margin-global.enemyoffx)*xsc,sprite_angle)+lengthdir_y((margin+dy-(14+global.enemyoffy))*ysc+14*ysc,sprite_angle-90),
    //  scale and rotation
        xsc,ysc,sprite_angle,
    //  blending
        $ffffff,$ffffff,$ffffff,$ffffff,1
    )

    if (gh) draw_sprite_ext(spr_jeff,0,round(x+0.5),round(y+0.5),xsc,1,0,$ffffff,1)

    if (global.debug && mask_index) draw_sprite_ext(mask_index,0,x,y,image_xscale,image_yscale,0,$ffffff,1)//nice
} else if (string(argument[0])="" && object_index != enemydummy) draw_sprite(spr_unknown,0,x,y)

/*} else {

    frx=frox+floor(frame)
    fry=froy
        draw_sprite_general(
    //  sprite, subimage
        global.enemysheet[biome],0,
    //  left, top
        8+frx*global.enemybosswidth,global.enemybosssheetheight+fry*global.enemybossheight,
    //  width, height
        global.enemybosswidth-1,global.enemybossheight-1,
    //  left top corner of the quad, accounting for rotation
        floor(x-30*xsc),
        floor(y-35+dy),
    //  scale and rotation
        xsc,1,0,
    //  blending
        $ffffff,$ffffff,$ffffff,$ffffff,1
    )

}*/
