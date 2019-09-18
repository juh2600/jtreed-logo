use <rainbow.scad>

$fn  = 720;
$vpr = [0, 0, 0];
$vpt = [0, 0, 0];
$vpd = 40;
background_radius = 1;
stripe_center_low = [1.0625, 1.75];
stripe_ir_low     = 2.5;
stripe_width_low  = 0.175;
stripe_center_high = [1.875, -1.2625];
stripe_ir_high     = 2.875;
stripe_width_high  = 0.175;
dot_center = [0.275, 0.45];
dot_radius = 0.165;

module background(profile=false) {
	if(profile) {
		circle(r = background_radius);
	} else {
		translate([0, 0, -0.105])
		cylinder(r = background_radius, h = 0.1);
	}
}

module stripe(ir, or, center, i=0) {
	index = i + 2; // idk why but index=1 does sad things
	intersection() {
		translate([center[0], center[1], 0.05])
		difference() {
			cylinder(r = or, h = 0.1+0.01*index, center=true);
			cylinder(r = ir, h = 0.2+0.01*index, center=true);
		};
		translate([0,0,-0.0045]) linear_extrude(h = 1) background(true);
	}
}

module dot(radius = dot_radius, center = dot_center) {
	translate(dot_center)
	cylinder(r = radius, h = 0.1);
}

module logo(profile=false) {
if(profile) {
$fn = 720;
projection() scale(1000) {
//	background();
	stripe(stripe_ir_low, stripe_ir_low+stripe_width_low, stripe_center_low);
	stripe(stripe_ir_high, stripe_ir_high+stripe_width_high, stripe_center_high);
	dot();
}
} else scale(10) {
	background();
	color(rainbow(7,4))
	stripe(stripe_ir_low, stripe_ir_low+stripe_width_low, stripe_center_low);
	color(rainbow(7,4))
	stripe(stripe_ir_high, stripe_ir_high+stripe_width_high, stripe_center_high);
	color(rainbow(7,4))
	dot();
}
}

logo();
// for generating SVGs
//logo(true);
//scale(1000) background(true);
