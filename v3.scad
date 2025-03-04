//---------------------------------------------------------
// Yet Another Parameterized Projectbox generator
//
//  This will generate a projectbox for a "ESP32AY"
//
//  Version 3.0 (02-12-2023)
//
// This design is parameterized based on the size of a PCB.
//---------------------------------------------------------
include <./library/YAPPgenerator_v3.scad>

// Note: length/lengte refers to X axis, 
//       width/breedte to Y, 
//       height/hoogte to Z

/*
      padding-back|<------pcb length --->|<padding-front
                            RIGHT
        0    X-as ---> 
        +----------------------------------------+   ---
        |                                        |    ^
        |                                        |   padding-right 
        |                                        |    v
        |    -5,y +----------------------+       |   ---              
 B    Y |         | 0,y              x,y |       |     ^              F
 A    - |         |                      |       |     |              R
 C    a |         |                      |       |     | pcb width    O
 K    s |         |                      |       |     |              N
        |         | 0,0              x,0 |       |     v              T
      ^ |   -5,0  +----------------------+       |   ---
      | |                                        |    padding-left
      0 +----------------------------------------+   ---
        0    X-as --->
                          LEFT
*/

//-- which half do you want to print?
printBaseShell    = true;
printLidShell     = true;
printSwitchExtenders  = false;

//-- Show 3D models of the PCB
show3dModelsPCB = true;

//-- PCB 3D models
myPcb = "./models/ESP32AY.stl";
myKnob = "./release/knob.stl";

//-- Edit these parameters for your own board dimensions
wallThickness       = 2; 
basePlaneThickness  = 2;
lidPlaneThickness   = 2;

//-- Total height of box = basePlaneThickness + lidPlaneThickness 
//--                     + baseWallHeight + lidWallHeight
//-- space between pcb and lidPlane :=
//--      (baseWallHeight+lidWall_heigth) - (standoff_heigth+pcbThickness)
baseWallHeight    = 13.0;
lidWallHeight     = 7.0;

//-- pcb dimensions
pcbLength         = 100;
pcbWidth          = 55;
pcbThickness      = 1.6;
                            
//-- padding between pcb and inside wall
paddingFront      = 0.5;
paddingBack       = 0.5;
paddingRight      = 0.5;
paddingLeft       = 0.5;

//-- ridge where base and lid off box can overlap
//-- Make sure this isn't less than lidWallHeight
ridgeHeight       = 2.0;
ridgeSlack          = 0.2;
roundRadius       = 2.0;

//-- How much the PCB needs to be raised from the base
//-- to leave room for solderings and whatnot
standoffHeight    = 14.0;
standoffPinDiameter = 2.8;
standoffDiameter  = 6.0;

//-- C O N T R O L -------------//-> Default ---------
showSideBySide      = false;     //-> true
previewQuality      = 5;        //-> from 1 to 32, Default = 5
renderQuality       = 8;        //-> from 1 to 32, Default = 8
onLidGap            = 0;
shiftLid            = 1;
hideLidWalls        = false;    //-> false
colorLid            = "yellow";  
alphaLid            = 0.8;
hideBaseWalls       = false;    //-> false
colorBase           = "blue";
alphaBase           = 0.8;
showPCB             = true;
showSwitches        = true;
showPCBmarkers      = true;
showShellZero       = true;
showCenterMarkers   = true;
inspectX            = 0;        //-> 0=none (>0 from Back)
inspectY            = 0;        //-> 0=none (>0 from Right)
inspectZ            = 0;        //-> 0=none (>0 from Bottom)
inspectXfromBack    = true;     //-> View from the inspection cut foreward
inspectYfromLeft    = true;     //-> View from the inspection cut to the right
inspectZfromTop     = true;    //-> View from the inspection cut down

if (show3dModelsPCB)
{
  translate([-17.5, -17.5, 16.8]) 
  {
    rotate([180,180,-90]) color("lightgray") import(myPcb);
  }
  translate([84.5, 30.0, 29.0]) 
  {
    rotate([180,0,-90]) color([0,1.0,1.0,0.8]) import(myKnob);
  }
}


//-- C O N T R O L ---------------------------------------

//===================================================================
//  *** Connectors ***
//  Standoffs with hole through base and socket in lid for screw type connections.
//-------------------------------------------------------------------

connectors   =
[
  [ 5.00, 5.00, -1.6, 3, 5, 3, 7, yappAllCorners, yappSelfThreading], 
];

//===================================================================
//  *** Cutouts ***
//-------------------------------------------------------------------

cutoutsLid =  
[
    [82.0, 12.5, 0, 0, 2.2, yappCircle, yappCenter, yappCoordPCB], // B1
    [82.0, 42.5, 0, 0, 2.2, yappCircle, yappCenter, yappCoordPCB], // B2
    [82.0, 27.5, 0, 0, 4, yappCircle, yappCenter, yappCoordPCB], // ENC
    [38, 27.5, 49, 37, 1, yappRoundedRect, yappCenter, yappCoordPCB], // display
    [80.0, 1.7, 0, 0, 0.5, yappCircle, yappCenter, yappCoordPCB], // LED1
    [83.2, 1.7, 0, 0, 0.5, yappCircle, yappCenter, yappCoordPCB], // LED2
    [86.4, 1.7, 0, 0, 0.5, yappCircle, yappCenter, yappCoordPCB], // LED3
    [89.6, 1.7, 0, 0, 0.5, yappCircle, yappCenter, yappCoordPCB], // LED4    
    [41, 27.5, 62, 44, undef, yappRectangle, 0.5, yappCenter, yappFromInside], // display inner cutoff
    [82.0, 12.5, 8, 8, undef, yappRectangle, 0.5, yappCenter, yappFromInside], // B1 inner cutoff
    [82.0, 42.5, 8, 8, undef, yappRectangle, 0.5, yappCenter, yappFromInside], // B2 inner cutoff
    [82.0, 27.5, 0, 0, 9.5, yappCircle, 0.5, yappCenter], // ENC cutoff
]; 
              
cutoutsBase = [];

cutoutsBack = [];

ridgeExtLeft = 
[
    [69.0,10, 13, yappCoordBox] // switch
];

ridgeExtFront = 
[
    [13.8, 9.5, 14.2, yappCoordBox], // type-c
    [38.8, 6, 13.60, yappCoordBox], // 3.5mm
];

cutoutsFront = 
[
    [39.3, -4, 0, 0, 3.0, yappCircle, yappCenter, yappCoordPCB], // 3.5mm    
    [16, -3.4, 9.5, 3.5, 1.4, yappRoundedRect, yappCenter, yappCoordPCB] // usb-c
];

cutoutsRight = [];

cutoutsLeft = 
[
    [17.5, 1.2, 15, 2, 1, yappRoundedRect, yappCenter, yappCoordPCB], // SD1
    [71.5, -4.6, 10, 4, 1, yappRoundedRect, yappCenter, yappCoordPCB], // power switch    
    //[17.5, 1.2, 18, 5, 2, yappRoundedRect, 1, yappCenter], // SD1 cutoff    
];


//===================================================================
//  *** Labels ***
//-------------------------------------------------------------------

labelsPlane = [
[12.5, 11.5, 90, 0.2, yappLid, "Fixedsys Excelsior:style=bold", 7.8, "ESP32AY"],
];

//===================================================================
// *** Custom LED pipes ***
//-------------------------------------------------------------------

switchWallHeight = 4.4;
switchLength = 3.5;
switchWidth = 5.0;
switchWallThickness = 1.2;

module hookLidInside()
{
  translate([(78.0+wallThickness+paddingFront)
                , (-0.5+wallThickness+paddingRight+paddingLeft)
                , (switchWallHeight+0)/-2])
  {
    difference()
    {
      color("blue") cube([switchLength, switchWidth, switchWallHeight], center=true);
      color("red")  cube([switchLength-switchWallThickness, 
                            switchWidth-switchWallThickness, switchWallHeight+1], center=true);
    }
  }

  translate([(78.0+3.3+wallThickness+paddingFront)
                , (-0.5+wallThickness+paddingRight+paddingLeft)
                , (switchWallHeight+0)/-2])
  {
    difference()
    {
      color("blue") cube([switchLength, switchWidth, switchWallHeight], center=true);
      color("red")  cube([switchLength-switchWallThickness, 
                            switchWidth-switchWallThickness, switchWallHeight+1], center=true);
    }
  }
  
  translate([(78.0+6.6+wallThickness+paddingFront)
                , (-0.5+wallThickness+paddingRight+paddingLeft)
                , (switchWallHeight+0)/-2])
  {
    difference()
    {
      color("blue") cube([switchLength, switchWidth, switchWallHeight], center=true);
      color("red")  cube([switchLength-switchWallThickness, 
                            switchWidth-switchWallThickness, switchWallHeight+1], center=true);
    }
  }
  
translate([(78.0+9.9+wallThickness+paddingFront)
                , (-0.5+wallThickness+paddingRight+paddingLeft)
                , (switchWallHeight+0)/-2])
  {
    difference()
    {
      color("blue") cube([switchLength, switchWidth, switchWallHeight], center=true);
      color("red")  cube([switchLength-switchWallThickness, 
                            switchWidth-switchWallThickness, switchWallHeight+1], center=true);
    }
  }  
  
}


YAPPgenerate();