var enemyspr_index,i;


if string(enemyspr_index)==string(sprite) exit

enemyspr_index=string(sprite)

if argument_count && argument[0] { //Boss

eid=-1
for (i=0;i<global.enemybosssprites;i+=1) {
    if (global.enemybosssprite[i,0]=enemyspr_index) {
        eid=i
        if (eid+1!=emem) {
            emem=eid+1
            frame=0
            frn =global.enemybosssprite[i,1] //frame number
            frox=global.enemybosssprite[i,2] //frame offset x (the enemysprite connect=true one)
            froy=global.enemybosssprite[i,3] //frame offset y -||-
        }
        break
    }
}

} else {

eid=-1
for (i=0;i<global.enemysprites;i+=1) {
    if (global.enemysprite[i,0]=enemyspr_index) {
        eid=i
        if (eid+1!=emem) {
            emem=eid+1
            frame=0
            frn =global.enemysprite[i,1] //frame number
            frs =global.enemysprite[i,2] //frame speed
            frl =global.enemysprite[i,3] //frame loop
            //new ones by Poker:
            frox=global.enemysprite[i,4] //frame offset x (the enemysprite connect=true one)
            froy=global.enemysprite[i,5] //frame offset y -||-
        }
        break
    }
}
}
