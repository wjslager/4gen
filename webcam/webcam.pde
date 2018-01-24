import processing.video.*;
import oscP5.*;
import netP5.*;

Capture video;
OscP5 oscP5;
NetAddress puredata;

AreaChecker[] areaCheckers;

void setup() {  
  size(640, 480);

  video = new Capture(this, 640, 480);
  video.start();  

  // OSC
  oscP5 = new OscP5(this, 12000);
  puredata = new NetAddress("localhost", 12000);

  // Construct objects
  areaCheckers = new AreaChecker[4];

  int halfWidth = int(width * 0.5);
  int halfHeight = int(height * 0.5);
  areaCheckers[0] = new AreaChecker(0, 0, halfWidth, halfHeight);
  areaCheckers[1] = new AreaChecker(halfWidth, 0, halfWidth, halfHeight);
  areaCheckers[2] = new AreaChecker(0, halfHeight, halfWidth, halfHeight);
  areaCheckers[3] = new AreaChecker(halfWidth, halfHeight, halfWidth, halfHeight);

  noFill();
  textAlign(CENTER, CENTER);
  textSize(20);

  frameRate(10);
}

void draw() {
  image(video, 0, 0);

  /*
   Start an OSC message
   
   For each area:
   - Check for activity
   - Add activity to OSC message
   
   Send OSC message
   */
  OscMessage msgDifference = new OscMessage("/difference");


  for (int i=0; i<4; i++)
  {
    areaCheckers[i].check();
    msgDifference.add(areaCheckers[i].difference);
  }
  oscP5.send(msgDifference, puredata);

  line(width*0.5, 0, width*0.5, height);
  line(0, height*0.5, width, height*0.5);
}  