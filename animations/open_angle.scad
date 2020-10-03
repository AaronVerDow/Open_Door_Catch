include <../src/door_catch.scad>;

open_angle=(sin($t*360)/2+0.5)*45+5;
display_angle=open_angle;

// RENDER gif 
module demo() {
    //door();
    rotate([0,0,75])
    latch();
}

demo();
