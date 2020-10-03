include <../src/door_catch.scad>;

height=(sin($t*360)/2+0.5)*70+60;

// RENDER gif
module demo() {
    rotate([0,0,75])
    latch();
}

demo();
