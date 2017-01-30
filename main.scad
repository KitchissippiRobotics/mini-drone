
// *********************************************************************************************************************
// ( )/ )(_  _)(_  _)___(  _ \(  _  )(  _ \(  _  )(_  _)(_  _)/ __)/ __)
//  )  (  _)(_   )( (___))   / )(_)(  ) _ < )(_)(   )(   _)(_( (__ \__ \
// (_)\_)(____) (__)    (_)\_)(_____)(____/(_____) (__) (____)\___)(___/
// *********************************************************************************************************************
// Mini Quadcopter frame
//
// Written by bcantin@kitchissippi-robotics.com
// Copyright (c) 2017 Kitchissippi Robotics
// *********************************************************************************************************************

 use <naca4.scad>

// =====================================================================================================================
// Configuration
// ---------------------------------------------------------------------------------------------------------------------

PROP_DIAMETER = 37.5;	// 37.5mm tip-to-tip
PROP_HEIGHT = 4.5;		// 4.5mm from top to bottom of prop hub
PROP_BASE = 3.6;		// 3.6mm from top to bottom of prop bushing

MOTOR_RING_HEIGHT = 2;
MOTOR_RING_THICKNESS = 3;
MOTOR_DIAMETER = 7;		// 7mm wide motor
MOTOR_HEIGHT = 16;		// 15mm tall motor

MotorSpacing = 50;

PropClearance = 0.5;	// 0.5mm clearance from edge of propellor and inside edge of duct
RingHeight = 6;			// 6mm motor retaining ring
DuctHeight = PROP_HEIGHT + PROP_BASE + MOTOR_RING_HEIGHT;		// calculated to be same as the top of prop
DuctThickness = 0.6;	// 0.6mm thick wall

DuctDiameter = PROP_DIAMETER + PropClearance + 3;

DuctOuterDiameter = DuctDiameter + 7.6; // tweak this manually until it fits

DuctSpacing = 7.5;
NACAOverhang = 3;

fnLevel = 100;
nacaType = 0020;
nacaTilt = 20;

ElectronicsPostSpacing = 14; 	// electronics mounting posts are 14mm apart
ElectronicsPostDiameter = 2.5;	// 2.5mm
ElectronicsPostRiser = 3.5;		// 3.5mm

ductRotationTweak = 10;

// prototype testing

//duct_thinwall();

// Make four ducts
translate([-MotorSpacing/2,-MotorSpacing/2,0])
rotate([0,0,-60 + ductRotationTweak])
	duct_thinwall();

translate([MotorSpacing/2,-MotorSpacing/2,0])
rotate([0,0,60  -ductRotationTweak])
	duct_thinwall();

translate([-MotorSpacing/2,MotorSpacing/2,0])
rotate([0,0,-120 - ductRotationTweak])
	duct_thinwall();

translate([MotorSpacing/2,MotorSpacing/2,0])
rotate([0,0,120 + ductRotationTweak])
	duct_thinwall();




difference() {
union() {

// electronics posts
translate([-ElectronicsPostSpacing/2,-ElectronicsPostSpacing/2,0])
	cylinder(h = MOTOR_RING_HEIGHT +1, d = ElectronicsPostDiameter, $fn = fnLevel);

translate([-ElectronicsPostSpacing/2,ElectronicsPostSpacing/2,0])
	cylinder(h = MOTOR_RING_HEIGHT +1 + ElectronicsPostRiser, d = ElectronicsPostDiameter, $fn = fnLevel);
	
translate([ElectronicsPostSpacing/2,-ElectronicsPostSpacing/2,0])
	cylinder(h = MOTOR_RING_HEIGHT +1 + ElectronicsPostRiser, d = ElectronicsPostDiameter, $fn = fnLevel);
	
translate([ElectronicsPostSpacing/2,ElectronicsPostSpacing/2,0])
	cylinder(h = MOTOR_RING_HEIGHT +1, d = ElectronicsPostDiameter, $fn = fnLevel);

rotate([0,90,51])
	cylinder( 	d1 = MOTOR_RING_HEIGHT *2,
				d2 = MOTOR_RING_HEIGHT *2 + 1 ,
		 		h = 16, $fn = fnLevel);
	
rotate([0,90,-51])
	cylinder( 	d1 = MOTOR_RING_HEIGHT *2,
				d2 = MOTOR_RING_HEIGHT *2 + 1 ,
		 		h = 16, $fn = fnLevel);
	
rotate([0,90,51 + 180])
	cylinder( 	d1 = MOTOR_RING_HEIGHT *2,
				d2 = MOTOR_RING_HEIGHT *2 + 1 ,
		 		h = 16, $fn = fnLevel);
	
rotate([0,90,-51 - 180])
	cylinder( 	d1 = MOTOR_RING_HEIGHT *2,
				d2 = MOTOR_RING_HEIGHT *2 + 1 ,
		 		h = 16, $fn = fnLevel);
}

// remove purposeful overhang
		translate([-DuctDiameter/2-5,-DuctDiameter/2-5,-10])
			cube([DuctDiameter + 10,DuctDiameter + 10, 10]);
		}


module duct_thinwall() {
	difference() {
	
		union() {

			cylinder(	d1 = MOTOR_DIAMETER + MOTOR_RING_THICKNESS +1,
						d2 = MOTOR_DIAMETER + MOTOR_RING_THICKNESS,
					 	h = MOTOR_RING_HEIGHT, $fn = fnLevel);
					 	
			
			
			rotate([90,0,180])
			cylinder(d1 = MOTOR_RING_HEIGHT *2, d2 = MOTOR_RING_HEIGHT *2 + 1, h = 20, $fn = fnLevel);
			
			rotate([90,0,60])
			cylinder(d1 = MOTOR_RING_HEIGHT *2, d2 = MOTOR_RING_HEIGHT *2 + 1, h = 20, $fn = fnLevel);
			
			rotate([90,0,-60])
			cylinder(d1 = MOTOR_RING_HEIGHT *2, d2 = MOTOR_RING_HEIGHT *2 + 1, h = 20, $fn = fnLevel);
	
				
			// draw duct
			translate([0,0,DuctHeight])
			rotate([0,180,0])
				rotate_extrude($fn = fnLevel) {
				translate([DuctDiameter/2,0,10])
				rotate([0,nacaTilt,90])

					flat_airfoil(naca=nacaType, L = DuctHeight +NACAOverhang, N = 100, open = false);
				}
		}
		
		translate([0,0,DuctHeight])
		rotate([0,180,0])
			rotate_extrude($fn = fnLevel) {
			translate([DuctThickness + (DuctDiameter/2),0,10])
			rotate([0,nacaTilt,90])
				flat_airfoil(naca=nacaType, L = DuctHeight +NACAOverhang, N = 100, open = false);
		}
		
		
		cylinder(d = MOTOR_DIAMETER, h = MOTOR_RING_HEIGHT + 2, $fn = fnLevel);
		
		// remove purposeful overhang
		translate([-DuctDiameter/2-5,-DuctDiameter/2-5,-10])
			cube([DuctDiameter + 10,DuctDiameter + 10, 10]);
			
		rotate([90,0,180])
			translate([0,0,10])
			cylinder(d1 = 2, d2 =2, h = 15, $fn = fnLevel);
	}

}


module flat_airfoil(naca=12, L = 100, N = 81, h = 1, open = false)
{
  //linear_extrude(height = h)
  polygon(points = airfoil_data(naca, L, N, open));
}
