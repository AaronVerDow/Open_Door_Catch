include <../src/door_latch.scad>;

trim_end=(sin($t*360)/2+0.5)*20;

// RENDER gif
module demo() {
    rotate([0,0,75])
    latch();
}

demo();
