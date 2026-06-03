//camera movement code
var l,r,panl,panr,t,b,w,h,hw,bgl,bgr,i,memx,noy,cs;

if (settings("frameskip") && !fallbacky) {view_yview[p2]=viewy}

if ((gamemanager.debugcamlock || gamemanager.codeblockcamlock || overwritecam || alarm[0]!=-1 || dead) || (piped && !argument[0] && !finish) || (finish && posed && !c)) {
    gamemanager.shake[p2]=0
    exit
}

i=id
w=400
h=240
hw=w/2
noy=0
l=0
r=verybignumber
t=0
b=region.ky
shim=0

if (shim!=0) camspd=1
camspd=(camspd*24+(1.5+abs(hsp)+abs(hyperspeed)+abs(gm8exspd)+abs(x-(viewx+200))/16))/25
//if (camspd<2) cs=0 else
cs=camspd

camwallr=0
camwalll=0
camwallt=0

if (shim!=0) {
    panl=16*(sign(shim)=1)
    panr=-16*(sign(shim)=-1)
}

//perform camera collision
with (camblock) if (!within(other.camcx,other.camcy,x,y,sprite_width,sprite_height)) {
    with (other) if (collision_rectangle(viewx+hw-204,viewy-4,viewx+hw+204,viewy+h+4,other.id,0,0)) {
        if (camcy>=other.bbox_top && camcy<=other.bbox_bottom+1 && camcx<=other.x && other.left) {r=max(viewx+w-2,other.bbox_left)-panl  camwallr=(other.object_index=camblock)}
        if (camcy>=other.bbox_top && camcy<=other.bbox_bottom+1 && camcx>=other.x && other.right) {l=min(viewx+2,other.bbox_right+1)-panr camwalll=(other.object_index=camblock)}
        if (camcx>=other.bbox_left && camcx<=other.bbox_right+1 && camcy<=other.y && other.top) b=max(viewy+h-2,other.bbox_top)
        if (camcx>=other.bbox_left && camcx<=other.bbox_right+1 && camcy>=other.y && other.bottom) {t=min(viewy+2,other.bbox_bottom+1) camwallt=(other.object_index=camblock)}
        if (x>=other.bbox_left && x<=other.bbox_right+1 && y>=other.bbox_top && y<=other.bbox_bottom+1) noy=1
    }
}

l=max(l,min(viewx-cs+panl,x-(160-128*max(shim=0,abs(shim)))))
r=min(r,max(viewx+w+cs+panr,x+(160-128*max(shim=0,abs(shim)))))

if (diggity) {
    with (flag) if (passed[other.p2]) {l=max(other.viewx,min(endstagex,other.viewx)) r=min(r,flag.x+240)}
    viewx=max(l,median(gamemanager.origin[p2],round(mean(x,xdig))-hw,gamemanager.righthand[p2]-w))
    exit
}

if (argument[0]) {
    l=0 r=verybignumber memx=0
    t=0
    getregion(x)
    b=region.ky
    ygoto=y
    viewx=x-200
    viewy=ygoto-128
    camcx=round(x)
    camcy=viewy+h/2

    with (camsecret) event_user(1)

    with (camblock) with (other) if (collision_rectangle(viewx+hw-204,viewy-4,viewx+hw+204,viewy+h+4,other.id,0,0)) {
        if (camcy>=other.bbox_top && camcy<=other.bbox_bottom+1 && camcx<=other.x && other.left) r=other.bbox_left
        if (camcy>=other.bbox_top && camcy<=other.bbox_bottom+1 && camcx>=other.x && other.right) l=other.bbox_right+1
        if (camcx>=other.bbox_left && camcx<=other.bbox_right+1 && camcy<=other.y && other.top) b=other.bbox_top
        if (camcx>=other.bbox_left && camcx<=other.bbox_right+1 && camcy>=other.y && other.bottom) t=other.bbox_bottom+1
    }

} else memx=viewx

if (finish && !dead && ending="retainer") {
    viewx=inch(viewx,myretainer.x-hw,2)
} else viewx=round(round(x)-hw)

if (!jump || climb) ygoto=y+looky
else ygoto=min(y+looky+48,max(ygoto,y+looky))+min(8,8*(vsp/4)*(vsp>2 || vsp<0)*settings("camshimmie"))

viewy=(viewy*4+round(ygoto)-128)/5

//background shenanigans
bgl=0 bgr=verybignumber
with (regionmarker) {
    if (lefthand<other.x) {l=max(lefthand,l) if (l=lefthand && abs(panr)) r=l+w bgl=max(bgl,lefthand)}
    if (x>other.x) {r=min(x,r) if (r=x && panl) l=r-w bgr=min(bgr,x)}
}
gamemanager.origin[p2]=bgl
gamemanager.righthand[p2]=bgr

with (flag) if (passed[other.p2]) {endstagex=x l=min(endstagex,memx) r=max(bgl+400,min(r,x+240))}
if (gamemanager.ratchet) l=max(l,memx)

camcx=viewx+hw
camcy=viewy+h/2

viewx=median(l,viewx,r-w) if (r-l<w) viewx=round((r+l-w)/2)
viewy=median(t,viewy,b-h) if (b-t<h) viewy=round((b+t-h)/2)

with (flag) if (passed[other.p2] && issign) {other.viewx=view_xview[other.p2]}

//i cant believe youve done this
view_xview[p2]=viewx
if (!noy || argument[0]) view_yview[p2]=viewy
