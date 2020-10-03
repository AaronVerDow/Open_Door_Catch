in=25.4;

// how thick is the door?
door_thick=44;


// how wide the door is; makes for cleaner angles
door_width=28*in;

// how far should the door be open?
// distance of gap will be echo'd
//open_angle=(sin($t*360)/2+0.5)*45;
open_angle=13;

// distance to edge, used to place hole
catch=15;

// size of catch hole
catch_x=18;
catch_y=35;

// size of screw holes
screw=6;

// space between screws
// screws are assumed to be centered in door_thick
screw_gap=55;

// space around screw holes if automatically calculating height
screw_wall=4;

// thickness of part
wall=1.2;

//height=screw_gap+screw+screw_wall*2;
height=70;

// size of Z shape that stops the door from closing
latch=in/2;

// extra curve at end of the part to make closing smoother
close_r=3;

// trim off ends to fit printer bed 
//trim_base=14;
trim_base=3;
trim_end=10;

// only used for drawing a preview door
door_h=height;
display_angle=open_angle;


$fn=90;

big_fn=400;

function segment_radius(height, chord) = (height/2)+(chord*chord)/(8*height);

// link to sketch
open_y=sin(open_angle)*door_width;
open_x=door_width-(cos(open_angle)*door_width);
opening=sqrt((pow(open_x,2)+pow((open_y-door_thick),2)));
echo(opening/in);
echo(opening);

// link to sketch
latch_x=door_width-(cos(open_angle)*(door_width-latch));
latch_y=(sin(open_angle)*(door_width-latch))-door_thick;
latch_hyp=sqrt(pow(latch_x,2)+pow(latch_y,2));
latch_angle=atan(latch_y/latch_x);
radius=segment_radius(latch_x,latch_y*2);

module door() {
    translate([door_width,0])
    mirror([1,0,0])
    rotate([0,0,display_angle])
    color("tan")
    cube([door_width,door_thick,door_h]);
}

module profile() {
    translate([-wall,trim_base])
    square([wall,door_thick-trim_base]);
    translate([radius,door_thick])
    difference() {
        circle(r=radius+wall,$fn=big_fn);
        circle(r=radius,$fn=big_fn);

        // cut off botttom 
        translate([-radius-wall,-radius-wall*2])
        square([radius*2+wall*2,radius+wall*2]);

        // top right
        square([radius+wall*2,radius+wall*2]);

        // door
        translate([door_width-radius,-door_thick])
        mirror([1,0,0])
        rotate([0,0,display_angle])
        square([door_width,radius]);
    }
    translate([door_width,0])
    rotate([0,0,-open_angle]) 
    translate([-door_width,0]) {
        translate([-wall,-wall])
        square([latch,wall]);
        translate([-wall,-wall])
        square([wall,door_thick+wall-close_r-trim_end]);
        translate([-wall-close_r,door_thick-close_r-trim_end])
        difference() {
            intersection() {
                circle(r=close_r+wall);
                square([close_r+wall,close_r+wall]);
            }
            circle(r=close_r);
        }
    }
}

module dirror_y() {
    children();
    mirror([0,1])
    children();
}

module catch() {
    translate([door_thick/2-catch_x/2-catch,0])
    square([catch_x,catch_y],center=true);
    children();
}

module screws() {
    dirror_y()
    translate([0,screw_gap/2])
    circle(d=screw);
}

module place_catch(angle=0) {
    translate([door_width,0])
    rotate([0,0,-angle])
    translate([-door_width-wall*2,door_thick/2,height/2])
    rotate([90,0,90])
    linear_extrude(height=wall*3)
    children();
}

module latch() {
    difference() {
        linear_extrude(height=height)
        profile();
        place_catch()
        // uncomment this to allow the door to close
        catch()
        screws();
        place_catch(open_angle)
        catch();
    }
}
