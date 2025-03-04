// Rotary knob for encoders and potentiometers

// Parameter definition

knob_diam              = 18;
knob_height            = 5;
chamfering_height      = 1.0;     // 45° chamfering on top side (height & width)

fluting_depth          = 0.2;     // ==> set to zero for smooth knob
fluting_count          = 24;

marking_depth          = 0.2;     // Marking line for knob position
marking_width          = 0.7;
marking_distance       = 3;     

outer_wall             = 2;

axis_diam              = 5.95;
axis_holder_indent     = 0.2;
axis_hole_depth        = 4;      // Max. knob height - outer wall
nut_axis_distance      = 0.7;     // distance from nut slot to axis hole wall

// Nut size according DIN934, M3 (plus tolerance for easy fit)
nut_diameter_e         = 0; //6.4;
nut_diameter_s         = 0; //5.55;
nut_thickness          = 0; //2.45;

screw_hole_diam        = 0;//3.2;

resol                  = 120;


// Constant calculation

knob_radius            = knob_diam / 2;
knob_top_radius        = knob_radius - chamfering_height;
fluting_step           = 360 / fluting_count;
fluting_block_size     = 2 * ( fluting_depth / sqrt (2) );
marking_length         = knob_radius - ( 2* marking_distance);
axis_radius            = axis_diam / 2;
axis_holder_diam       = knob_diam - ( 2* outer_wall );  // can be defined smaller manually for large knobs
axis_holder_radius     = axis_holder_diam / 2;
screw_hole_radius      = screw_hole_diam / 2;
screw_height           = knob_height - (axis_hole_depth / 2);   // can be defined manual, if desired
nut_x_pos              = -axis_radius - nut_axis_distance - ( nut_thickness / 2);
nutslot_z_pos          = knob_height - (( knob_height - screw_height) / 2);


// Construction main body

difference () {
    union () {
        cylinder (h = chamfering_height, r2 = knob_radius, r1 = knob_top_radius, center = false, $fn = resol);
        translate ( [ 0, 0, chamfering_height] ) {
            cylinder (h = knob_height - chamfering_height, r = knob_radius, center = false, $fn = resol);
        };
    };
    translate ( [ 0, 0, outer_wall] ) {
        cylinder (h = knob_height, r = knob_radius - outer_wall, center = false, $fn = resol);
    };
    // outer fluting
    for ( step = [ 0 : fluting_step : 360 ] ) {
        rotate ( [ 0, 0, step ] ) {
            translate ( [ knob_radius, 0, knob_height / 2] ) {
                rotate ( [ 0, 0, 45 ] ) {
                    cube ( [ fluting_block_size, fluting_block_size, knob_height ], center = true );
                };
            };
        };
    };
    // Position marking
    translate ( [ marking_distance, -marking_width / 2, 0 ] ) {
        cube ( [ marking_length, marking_width,  marking_depth ], center = false );
    };
    // Screw hole for outer body
    translate ( [  0, 0, screw_height] ) {
        rotate ( [ 0, -90, 0 ] ) {
            cylinder ( h = knob_radius, r = screw_hole_radius, center = false, $fn = resol );
        };
    };
};

// Axis holder (can be smaller than knob size minus wall size (default) for large knobs to save material, but be careful with forces from screwing in the nut)
difference () {
    union () {
        cylinder ( h = knob_height - axis_holder_indent, r = axis_holder_radius, center = false, $fn = resol);
    };
    translate ( [ 0, 0, knob_height - axis_hole_depth ] ) {
        cylinder ( h = axis_hole_depth, r = axis_radius, center = false, $fn = resol);
    };
    // Position marking
    translate ( [ marking_distance, -marking_width / 2, 0 ] ) {
        cube ( [ marking_length, marking_width,  marking_depth ], center = false );
    };
    // Screw hole for axis holder
    translate ( [  0, 0, screw_height] ) {
        rotate ( [ 0, -90, 0 ] ) {
            cylinder ( h = knob_radius, r = screw_hole_radius, center = false, $fn = resol );
        };
    };
    // Nut hole
    translate ( [ nut_x_pos, 0, nutslot_z_pos ] ) {
        cube ( [ nut_thickness, nut_diameter_s, knob_height - screw_height ], center = true);
    };
    translate ( [ nut_x_pos, 0, screw_height ] ) {
        rotate ( [ 0, 90, 0 ] ) {
            cylinder ( h = nut_thickness, d = nut_diameter_e, center = true, $fn = 6 );
        };
    };

};
