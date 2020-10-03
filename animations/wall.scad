include <../src/door_latch.scad>;

wall=(sin($t*360)/2+0.5)*10+1;

// RENDER gif
module demo() {
    rotate([0,0,75])
    latch();
}

demo();
