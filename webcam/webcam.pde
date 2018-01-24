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

Capture video;
OscP5 oscP5;
NetAddress puredata;

AreaChecker[] areaCheckers;
int[] areaDiffs;

/* ==== ==== ==== SETUP ==== ==== ==== */

void setup() 
{  
  size(640, 480);
  frameRate(fps);

  int halfWidth = int(width * 0.5);
  int halfHeight = int(height * 0.5);

  video = new Capture(this, 640, 480);
  video.start();  

  // Listen to port 12001, send on 12000
  oscP5 = new OscP5(this, 12001);
  puredata = new NetAddress("localhost", 12000);

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
  image(video, 0, 0);

  for (int i=0; i<4; i++) {
    areaCheckers[i].check();
    
    // Store the activity to be sent later
    // Using abs() to prevent positive and negative activity to cancel each other
    areaDiffs[i] += abs(areaCheckers[i].difference);
  }

  // Only send a message once per second
  if (frameCount % fps == 0) {
    // Start a new message
    OscMessage msgDifference = new OscMessage("/difference");
    
    // Do stuff for each area
    for (int i=0; i<areaCheckers.length; i++) 
    {
      // Send all the stored activity data
      msgDifference.add(areaDiffs[i]);
      
      // Clear the stored activity data
      areaDiffs[i] = 0;
    }
    // Send the message
    oscP5.send(msgDifference, puredata);
    println("OSC message sent @" + millis() + "ms");
  }

  line(width*0.5, 0, width*0.5, height);
  line(0, height*0.5, width, height*0.5);
}  