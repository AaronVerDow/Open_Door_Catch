include <../src/door_catch.scad>;

close_r=(sin($t*360)/2+0.5)*15;

// RENDER gif
module demo() {
    rotate([0,0,75])
    latch();
}

demo();
