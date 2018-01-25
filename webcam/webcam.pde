/*****************************
 *                           *
 *          WARNING          *
 *                           *
 *  UNDOCUMENTED CODE AHEAD  *
 *   PROCEEED WITH CAUTION   *
 *                           *
 *****************************/

import processing.video.*;
import oscP5.*;
import netP5.*;

final int fps = 15;
int halfWidth, halfHeight;

Capture webcam;
OscP5 oscP5;
NetAddress puredata;

AreaChecker[] areaCheckers;
int[] areaDiffs;

/* ==== ==== ==== SETUP ==== ==== ==== */

void setup() 
{  
  size(640, 480);
  frameRate(fps);

  halfWidth = int(width * 0.5);
  halfHeight = int(height * 0.5);

  webcam = new Capture(this, 640, 480);
  webcam.start();  

  // Listen to 12001, send on 12000
  oscP5 = new OscP5(this, 12001);
  puredata = new NetAddress("localhost", 12000);

  // Create AreaCheckers for the 4 area's of a screen, orientation:
  // 0 1
  // 2 3
  areaCheckers = new AreaChecker[4];
  areaCheckers[0] = new AreaChecker(0, 0, halfWidth, halfHeight);
  areaCheckers[1] = new AreaChecker(halfWidth, 0, halfWidth, halfHeight);
  areaCheckers[2] = new AreaChecker(0, halfHeight, halfWidth, halfHeight);
  areaCheckers[3] = new AreaChecker(halfWidth, halfHeight, halfWidth, halfHeight);

  // Initialize all areaDiffs with 0
  areaDiffs = new int[areaCheckers.length];
  for (int i=0; i<areaCheckers.length; i++) areaDiffs[i] = 0;

  noFill();
  textAlign(CENTER, CENTER);
  textSize(20);
}

/* ==== ==== ==== DRAW ==== ==== ==== */

void draw() 
{
  image(webcam, 0, 0);

  for (int i=0; i<4; i++)
  {
    areaCheckers[i].check();

    // Store the activity to be sent later
    // Using abs() to prevent positive and negative activity to cancel each other
    areaDiffs[i] += abs(areaCheckers[i].difference);
  }

  // Only send an OSC message once per second
  if (frameCount % fps == 0) 
  {
    // Send the message and empty the difference memory
    OscMessage msgDifference = new OscMessage("/difference");
    for (int i=0; i<areaCheckers.length; i++) {
      msgDifference.add(areaDiffs[i]);
      areaDiffs[i] = 0;
    }
    oscP5.send(msgDifference, puredata);
  }

  line(halfWidth, 0, halfWidth, height);
  line(0, halfHeight, width, halfHeight);
}  

void captureEvent(Capture webcam) {
  webcam.read();
}