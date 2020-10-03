include <../src/door_catch.scad>;

latch=(sin($t*360)/2+0.5)*30+5;

// RENDER gif
module demo() {
    rotate([0,0,75])
    latch();
}

demo();
