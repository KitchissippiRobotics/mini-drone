
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

MOTOR_RING_HEIGHT = 5;
MOTOR_RING_THICKNESS = 4;
MOTOR_DIAMETER = 7.3;		// 7mm wide motor
MOTOR_HEIGHT = 16;		// 15mm tall motor

MotorSpacing = 54.5;

PropClearance = 0.5;	// 0.5mm clearance from edge of propellor and inside edge of duct
RingHeight = 6;			// 6mm motor retaining ring
DuctHeight = PROP_HEIGHT + PROP_BASE + MOTOR_RING_HEIGHT;		// calculated to be same as the top of prop
DuctThickness = 0.6;	// 0.6mm thick wall

DuctDiameter = PROP_DIAMETER + PropClearance + 4;

DuctOuterDiameter = DuctDiameter + 7.6; // tweak this manually until it fits

DuctSpacing = 7.5;
NACAOverhang = 3;

fnLevel = 20;
nacaType = 0020;
nacaTilt = 20;

ElectronicsPostSpacing = 14; 	// electronics mounting posts are 14mm apart
ElectronicsPostDiameter = 2.5;	// 2.5mm
ElectronicsPostRiser = 3.5;		// 3.5mm

// ---------------------------------------------------------------------------------------------------------------------
// make the base



difference() {
	// rounded rectangle below electronics
	hull() {
		translate([10, 13.5, 0])
		cylinder(d = 3, h = 1.5, $fn = fnLevel);

		translate([-10, 13.5, 0])
		cylinder(d = 3, h = 1.5, $fn = fnLevel);

		translate([10, -13.5, 0])
		cylinder(d = 3, h = 1.5, $fn = fnLevel);

		translate([-10, -13.5, 0])
		cylinder(d = 3, h = 1.5, $fn = fnLevel);
	}

	// cut outs
	union() {
		// smaller rounded rectangle cut out to make a thiner frame
		hull() {
			translate([10 -3, 13.5 -3, -0.25])
			cylinder(d = 2, h = 2, $fn = fnLevel);

			translate([-10 + 3, 13.5 -3, -0.25])
			cylinder(d = 2, h = 2, $fn = fnLevel);

			translate([10 -3, -13.5 + 3, -0.25])
			cylinder(d = 2, h = 2, $fn = fnLevel);

			translate([-10  +3, -13.5 + 3, -0.25])
			cylinder(d = 2, h = 2, $fn = fnLevel);
		}

		// battery connector hole
		hull() {
			translate([3, 15, -0.25])
			cylinder(d = 3, h = 2, $fn = fnLevel);

			translate([-3, 15, -0.25])
			cylinder(d = 3, h = 2, $fn = fnLevel);

		}
	}
}

// strengthening frame in front on battery connector

hull() {
	translate([4, 11.5, 0])
	cylinder(d = 3.5, h = 1.5, $fn = fnLevel);

	translate([-4, 11.5, 0])
	cylinder(d = 3.5, h = 1.5, $fn = fnLevel);

}

bumpOffset = 17;

// little bump in the front
difference() {
	// shape ...
	hull() {
	translate([0, -bumpOffset + 2, 0])
	cylinder(d = 8, h = 1.5, $fn = fnLevel);

	translate([0, -bumpOffset, 0])
	cylinder(d = 6, h = 1.5, $fn = fnLevel);
	}

	// ... subtract
	union() {
		translate([0, -bumpOffset, 0])
			cylinder(d = 2.5, h = 1.5, $fn = fnLevel);

		hull() {
			translate([0, -bumpOffset, 0])
			cylinder(d = 2, h = 1.5, $fn = fnLevel);

			translate([0, -bumpOffset - 3, 0])
			cylinder(d = 1, h = 1.5, $fn = fnLevel);
		}
	}



}

difference() {
	union() {
		// do-dads & widgets
		base_right_hardpoints();	// right points
		rotate([0,0,180])
		base_right_hardpoints();	// left points
	}

	carve_ducts();
}

// ---------------------------------------------------------------------------------------------------------------------

ductRotationTweak = 15;
supportTiltAngle = 22.5;
supportScale = 0.25;
// Make four ducts


draw_ducts();

side_support();

rotate([0,0,90])
	side_support();

rotate([0,0,180])
	side_support();

rotate([0,0,-90])
	side_support();


// ---------------------------------------------------------------------------------------------------------------------

module side_support() {

difference() {
union() {
	/*translate([-24.75,7,0])
	rotate([90,0,0])
	cylinder(h = 14, d = 2, $fn = fnLevel);

	translate([-24.75,7.5,10.75])
	rotate([90,0,0])
	cylinder(h = 15, d = 1.2, $fn = fnLevel);*/

	hull() {
	translate([-25,6.5,8])
	rotate([0,90,0])
	scale([1,0.2,1])
		cylinder(h = 0.6, d = 10, $fn = fnLevel);

	translate([-25,5.5,0])
	rotate([0,90,0])
	scale([1,1,1])
		cylinder(h = 0.6, d = 3, $fn = fnLevel);

	translate([-25,-6.5,8])
	rotate([0,90,0])
	scale([1,0.2,1])
		cylinder(h = 0.6, d = 10, $fn = fnLevel);

	translate([-25,-5.5,0])
	rotate([0,90,0])
	scale([1,1,1])
		cylinder(h = 0.6, d = 3, $fn = fnLevel);
	}
}
/*translate([-100,-100, 4])
cube([200,200,20]);*/

translate([-100,-100, -20])
cube([200,200,20]);
}

}


// ---------------------------------------------------------------------------------------------------------------------

module base_right_hardpoints() {
	// Front & Right Central Structure ----

	elasticNubSize = 8;
	elasticNubAngle = 0;

	// front right arm
	hull() {
		translate([-ElectronicsPostSpacing/2,-ElectronicsPostSpacing/2,0])
			cylinder(h = MOTOR_RING_HEIGHT /2, d = ElectronicsPostDiameter * 2, $fn = fnLevel);
		translate([-ElectronicsPostSpacing/2 - 8,-ElectronicsPostSpacing/2 - 8,0])
			cylinder(h = MOTOR_RING_HEIGHT /2, d = 4, $fn = fnLevel);
	}

	difference() {
		hull() {
			translate([-ElectronicsPostSpacing/2 - 6,-ElectronicsPostSpacing/2 - 6,2])
				sphere(d = 4, $fn = fnLevel);

			translate([-ElectronicsPostSpacing/2 - 6,-ElectronicsPostSpacing/2 - 6,12])
				sphere(d = 1, $fn = fnLevel);
		}

		translate([-100,-100, -20])
			cube([200,200,20]);
	}

	// front right elastic nub
	hull() {
		translate([-ElectronicsPostSpacing/2,-ElectronicsPostSpacing/2,0])
			cylinder(h = 1.5, d = ElectronicsPostDiameter * 2, $fn = fnLevel);
		translate([-ElectronicsPostSpacing/2 - elasticNubSize,-ElectronicsPostSpacing/2,0])
			cylinder(h = 1.5, d = 2, $fn = fnLevel);
	}

	// front right electronics post
	translate([-ElectronicsPostSpacing/2,-ElectronicsPostSpacing/2,0])
		cylinder(h = MOTOR_RING_HEIGHT /2 +1 + ElectronicsPostRiser, d = ElectronicsPostDiameter, $fn = fnLevel);

	// electronics post nub
			translate([-ElectronicsPostSpacing/2,-ElectronicsPostSpacing/2,0])
				cylinder(h = MOTOR_RING_HEIGHT /2 +1, d = ElectronicsPostDiameter + 2, $fn = fnLevel);

	// Rear & Right Central Structure ----

	difference() {
		union() {
			// rear right arm
			hull() {
				translate([-ElectronicsPostSpacing/2,ElectronicsPostSpacing/2,0])
					cylinder(h = MOTOR_RING_HEIGHT /2, d = ElectronicsPostDiameter * 2, $fn = fnLevel);
				translate([-ElectronicsPostSpacing/2 - 8,ElectronicsPostSpacing/2 + 8,0])
					cylinder(h = MOTOR_RING_HEIGHT /2, d = 4, $fn = fnLevel);
			}

			difference() {
				hull() {
					translate([-ElectronicsPostSpacing/2 - 6, ElectronicsPostSpacing/2 + 6,2])
						sphere(d = 4.5, $fn = fnLevel);

					translate([-ElectronicsPostSpacing/2 - 6, ElectronicsPostSpacing/2 + 6,12])
						sphere(d = 1, $fn = fnLevel);
				}

				translate([-100,-100, -20])
					cube([200,200,20]);
			}

			// rear right elastic nub
			hull() {
				translate([-ElectronicsPostSpacing/2,ElectronicsPostSpacing/2,0])
					cylinder(h = 1.5, d = ElectronicsPostDiameter * 2, $fn = fnLevel);
				translate([-ElectronicsPostSpacing/2 - elasticNubSize,ElectronicsPostSpacing/2,0])
					cylinder(h = 1.5, d = 2, $fn = fnLevel);
			}

			// electronics post nub
			translate([-ElectronicsPostSpacing/2,ElectronicsPostSpacing/2,0])
				cylinder(h = MOTOR_RING_HEIGHT /2 +1, d1 = ElectronicsPostDiameter + 2, d2 = ElectronicsPostDiameter + 1, $fn = fnLevel);
		}

		// cut out little screw hole
		translate([-ElectronicsPostSpacing/2,ElectronicsPostSpacing/2,0])
			cylinder(h = MOTOR_RING_HEIGHT +4, d = 1.5, $fn = fnLevel);

	}
}

// ---------------------------------------------------------------------------------------------------------------------

module duct_thinwall(supportTilt = 0, supportThickness = 0.35) {
	difference() {

		union() {

			cylinder(	d1 = MOTOR_DIAMETER + MOTOR_RING_THICKNESS +1,
						d2 = MOTOR_DIAMETER + MOTOR_RING_THICKNESS,
					 	h = MOTOR_RING_HEIGHT, $fn = fnLevel);


			// three arms joining the duct to the motor ring

			rotate([88,supportTilt,180])
			scale([supportThickness,1,1])
				cylinder(d1 = MOTOR_RING_HEIGHT, d2 = MOTOR_RING_HEIGHT + 1, h = DuctDiameter / 2, $fn = fnLevel);

			rotate([88,supportTilt,60])
			scale([supportThickness,1,1])
				cylinder(d1 = MOTOR_RING_HEIGHT, d2 = MOTOR_RING_HEIGHT + 1, h =  DuctDiameter / 2, $fn = fnLevel);

			rotate([88,supportTilt,-60])
			scale([supportThickness,1,1])
				cylinder(d1 = MOTOR_RING_HEIGHT, d2 = MOTOR_RING_HEIGHT + 1, h =  DuctDiameter / 2, $fn = fnLevel);


			// draw duct
			translate([0,0,DuctHeight])
			rotate([0,180,0])
				rotate_extrude($fn = fnLevel) {
				translate([DuctDiameter/2,0,10])
				rotate([0,nacaTilt,90])

					flat_airfoil(naca=nacaType, L = DuctHeight +NACAOverhang, N = 100, open = false);
				}
		}

		// carve out offset duct
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


	}

}

// ---------------------------------------------------------------------------------------------------------------------
// draw four ducts

module draw_ducts()
{
	// front right
	translate([-MotorSpacing/2,-MotorSpacing/2,0])
	rotate([0,0,-60 + ductRotationTweak])
		duct_thinwall(supportTiltAngle, supportScale);

	// front left
	translate([MotorSpacing/2,-MotorSpacing/2,0])
	rotate([0,0,60  -ductRotationTweak])
		duct_thinwall(-supportTiltAngle, supportScale);

	// rear right
	translate([-MotorSpacing/2,MotorSpacing/2,0])
	rotate([0,0,-120 - ductRotationTweak])
		duct_thinwall(-supportTiltAngle, supportScale);


	// rear left
	translate([MotorSpacing/2,MotorSpacing/2,0])
	rotate([0,0,120 + ductRotationTweak])
		duct_thinwall(supportTiltAngle, supportScale);
}

// ---------------------------------------------------------------------------------------------------------------------
// draw four duct bulks

module carve_ducts()
{
		// front right
	translate([-MotorSpacing/2,-MotorSpacing/2,0])
	rotate([0,0,-60 + ductRotationTweak])
		duct_bulk();

	// front left
	translate([MotorSpacing/2,-MotorSpacing/2,0])
	rotate([0,0,60  -ductRotationTweak])
		duct_bulk(-supportTiltAngle, supportScale);

	// rear right
	translate([-MotorSpacing/2,MotorSpacing/2,0])
	rotate([0,0,-120 - ductRotationTweak])
		duct_bulk();


	// rear left
	translate([MotorSpacing/2,MotorSpacing/2,0])
	rotate([0,0,120 + ductRotationTweak])
		duct_bulk();
}
// ---------------------------------------------------------------------------------------------------------------------
// solid bulk of the duct - used for carving the shape out of other objects

module duct_bulk()
{
		difference() {
			hull() {
			translate([0,0,DuctHeight])
			rotate([0,180,0])
			rotate_extrude($fn = fnLevel) {
				translate([DuctDiameter/2,0,10])
				rotate([0,nacaTilt,90])
					flat_airfoil(naca=nacaType, L = DuctHeight +NACAOverhang, N = 100, open = false);
				}
			}

			// carve out offset duct
			translate([0,0,DuctHeight])
			rotate([0,180,0])
			rotate_extrude($fn = fnLevel) {
				translate([DuctThickness + (DuctDiameter/2),0,10])
				rotate([0,nacaTilt,90])
					flat_airfoil(naca=nacaType, L = DuctHeight +NACAOverhang, N = 100, open = false);
			}
		}

}

// ---------------------------------------------------------------------------------------------------------------------
module flat_airfoil(naca=12, L = 100, N = 81, h = 1, open = false)
{
  //linear_extrude(height = h)
  polygon(points = airfoil_data(naca, L, N, open));
}
