
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
MOTOR_RING_THICKNESS = 2;
MOTOR_DIAMETER = 7;		// 7mm wide motor
MOTOR_HEIGHT = 16;		// 15mm tall motor

PropClearance = 0.5;	// 0.5mm clearance from edge of propellor and inside edge of duct
RingHeight = 6;			// 6mm motor retaining ring
DuctHeight = PROP_HEIGHT + PROP_BASE + MOTOR_RING_HEIGHT;		// calculated to be same as the top of prop
DuctThickness = 0.6;	// 0.6mm thick wall

DuctDiameter = PROP_DIAMETER + PropClearance + 1.5;

DuctOuterDiameter = DuctDiameter + 7.6; // tweak this manually until it fits

DuctSpacing = 7.5;

fnLevel = 200;
nacaType = 0020;
nacaTilt = 0;

// prototype testing

duct_thinwall();

// Make four ducts
/*translate([-DuctOuterDiameter/2,-DuctOuterDiameter/2,0])
	duct_thinwall();

translate([DuctOuterDiameter/2,-DuctOuterDiameter/2,0])
	duct_thinwall();

translate([-DuctOuterDiameter/2,DuctOuterDiameter/2,0])
	duct_thinwall();

translate([DuctOuterDiameter/2,DuctOuterDiameter/2,0])
	duct_thinwall();
*/

module duct_thinwall() {
	// draw central motor hole
	difference() {
		union() {
			cylinder(d = MOTOR_DIAMETER + MOTOR_RING_THICKNESS, h = MOTOR_RING_HEIGHT, $fn = fnLevel);
			
			// draw support
			translate([-1,0,0])
				cube([2, 20, 2]);
	
			rotate([0,0,120])
			translate([-1,0,0])
				cube([2, 20, 2]);
		
			rotate([0,0,-120])
			translate([-1,0,0])
				cube([2, 20, 2]);
		}
		cylinder(d = MOTOR_DIAMETER, h = MOTOR_RING_HEIGHT, $fn = fnLevel);
	}
	
	

	// draw duct
	translate([0,0,DuctHeight])
	rotate([0,180,0])
	difference() {
		rotate_extrude($fn = fnLevel) {
			translate([DuctDiameter/2,0,10])
			rotate([0,nacaTilt,90])

				flat_airfoil(naca=nacaType, L = DuctHeight, N = 100, open = false);
		}

		//translate([0,0, DuctThickness])
		rotate_extrude($fn = fnLevel) {
			translate([DuctThickness + (DuctDiameter/2),0,10])
			rotate([0,nacaTilt,90])
				flat_airfoil(naca=nacaType, L = DuctHeight, N = 100, open = false);
		}

	}
}


module flat_airfoil(naca=12, L = 100, N = 81, h = 1, open = false)
{
  //linear_extrude(height = h)
  polygon(points = airfoil_data(naca, L, N, open));
}
