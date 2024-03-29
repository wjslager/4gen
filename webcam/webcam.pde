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
final int gain = 3;
int halfWidth, halfHeight;

Capture webcam;
OscP5 oscP5;
NetAddress puredata;

AreaChecker[] areaCheckers; // AreaChecker instances
float[] areaActivities;     // frame per frame comparisons
float[] areaDifferences;    // frame to calibration comparisons

/* ==== ==== ==== SETUP ==== ==== ==== */

void setup() 
{  
  size(640, 480);
  frameRate(fps);

  halfWidth = int(width * 0.5);
  halfHeight = int(height * 0.5);

  webcam = new Capture(this, 640, 480);
  //webcam = new Capture(this, "name=HD Pro Webcam C920,size=640x480,fps=5");
  webcam.start();  

  // Listen to 12001, send on 12000
  oscP5 = new OscP5(this, 12001);
  puredata = new NetAddress("localhost", 12000);

  // Create AreaCheckers for the 4 area's of a screen, orientation:
  // 0 1
  // 2 3
  /*
  areaCheckers = new AreaChecker[4];
   areaCheckers[0] = new AreaChecker(0, 0, halfWidth, halfHeight);
   areaCheckers[1] = new AreaChecker(halfWidth, 0, halfWidth, halfHeight);
   areaCheckers[2] = new AreaChecker(0, halfHeight, halfWidth, halfHeight);
   areaCheckers[3] = new AreaChecker(halfWidth, halfHeight, halfWidth, halfHeight);
   */
  areaCheckers = new AreaChecker[2];
  areaCheckers[1] = new AreaChecker(0, 0, halfWidth, height);
  areaCheckers[0] = new AreaChecker(halfWidth, 0, halfWidth, height);

  areaActivities = new float[areaCheckers.length];
  areaDifferences = new float[areaCheckers.length];
  for (int i=0; i<areaCheckers.length; i++) {
    areaActivities[i] = 0;
    areaDifferences[i] = 0;
  }

  noFill();
  stroke(255, 0, 255);
  textAlign(LEFT, TOP);
  textSize(20);
}

/* ==== ==== ==== DRAW ==== ==== ==== */

void draw() 
{
  background(0);
  image(webcam, 0, 0);
  loadPixels();

  for (int i=0; i<areaCheckers.length; i++)
  {
    areaCheckers[i].check();

    // Store the absolute values to prevent positive and negative values from cancelling e
    areaActivities[i] += abs(areaCheckers[i].activity);
    areaDifferences[i] += abs(areaCheckers[i].difference);
  }

  // Only send an OSC message once per ... frames
  if (frameCount % 5 == 0) 
  {
    OscMessage msgDifference = new OscMessage("/difference");

    for (int i=0; i<areaCheckers.length; i++)
    {
      msgDifference.add(areaActivities[i] * gain);
      msgDifference.add(areaDifferences[i] * 2);
      areaActivities[i] = 0;
      areaDifferences[i] = 0;
    }

    oscP5.send(msgDifference, puredata);
  }
}  

void captureEvent(Capture webcam) {
  webcam.read();
}

void keyPressed() {
  if (key == ' ') {
    calibrate();
  }
}

void calibrate() {
  println("calibrate");
  for (int i=0; i<areaCheckers.length; i++) {
    areaCheckers[i].calibrate();
  }
}

void oscEvent(OscMessage theOscMessage) {
  // Event message boeit niet eens, als er maar iets is
  println(millis() + " >> OSC received");
  calibrate();
}