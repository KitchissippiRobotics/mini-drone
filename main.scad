
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

MOTOR_DIAMETER = 7;		// 7mm wide motor
MOTOR_HEIGHT = 16;		// 15mm tall motor

PropClearance = 0.5;	// 0.5mm clearance from edge of propellor and inside edge of duct
RingHeight = 6;			// 6mm motor retaining ring
DuctHeight = RingHeight + PROP_BASE + PROP_HEIGHT;		// calculated to be same as the top of prop
DuctThickness = 0.6;	// 0.6mm thick wall

DuctDiameter = PROP_DIAMETER + PropClearance;

// prototype testing

duct_thinwall();

module duct_thinwall() {
difference() {
	rotate_extrude() {
		translate([3.8 + (DuctDiameter/2),0,10])
		rotate([0,20,90])

			flat_airfoil(naca=2015, L = DuctHeight, N = 100, h =1, open = false);
	}

	rotate_extrude() {
		translate([DuctThickness + 3.8 + (DuctDiameter/2),0,10])
		rotate([0,20,90])
			flat_airfoil(naca=2015, L = DuctHeight, N = 100, h =1, open = false);
	}

}
}


module flat_airfoil(naca=12, L = 100, N = 81, h = 1, open = false)
{
  //linear_extrude(height = h)
  polygon(points = airfoil_data(naca, L, N, open));
}

module Draw_Duct(innerDiameter, ductHeight, wallThickness) {
	// 1) draw NACA profile 4415
	// 2) rotate it around the center at the specified distance
	// 3) carve a 2nd NACA profile out of the outside of it at the specified thickness
}
