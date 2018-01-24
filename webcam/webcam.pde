import processing.video.*;

Capture video;

AreaChecker[] areaCheckers;

void setup() {  
  size(640, 480);

  video = new Capture(this, 640, 480);
  video.start();  

  // Create objects
  areaCheckers = new AreaChecker[4];
  
  // Construct objects
  int halfWidth = int(width * 0.5);
  int halfHeight = int(height * 0.5);
  areaCheckers[0] = new AreaChecker(0, 0, halfWidth, halfHeight);
  areaCheckers[1] = new AreaChecker(halfWidth, 0, halfWidth, halfHeight);
  areaCheckers[2] = new AreaChecker(0, halfHeight, halfWidth, halfHeight);
  areaCheckers[3] = new AreaChecker(halfWidth, halfHeight, halfWidth, halfHeight);
    
  //for (int i=0; i<areaCheckers.length; i++) {
  //  areaCheckers[i] = new AreaChecker(i*50, 50, 50, 50);
  //}

  noFill();
  textAlign(CENTER, CENTER);
  textSize(20);
  
  frameRate(10);
}

void draw() {
  image(video, 0, 0);
  
  // Do stuff for each of the 4 area's
  for (int area=0; area<4; area++)
  {
    areaCheckers[area].check();
  }
  
  line(width*0.5, 0, width*0.5, height);
  line(0, height*0.5, width, height*0.5);
}  