import processing.video.*;

Capture video;

AreaChecker[] areaCheckers;

void setup() {  
  size(640, 480);

  video = new Capture(this, 640, 480);
  video.start();  

  //frameRate(1);

  // Create objects
  areaCheckers = new AreaChecker[4];
  // Construct objects
  for (int i=0; i<areaCheckers.length; i++) {
    areaCheckers[i] = new AreaChecker(i*50, 50, 50, 50);
  }
  noFill();
}

void draw() {
  image(video, 0, 0);
  

  // Do stuff for each of the 4 area's
  for (int area=0; area<4; area++)
  {
    areaCheckers[area].check();
  }
  
  //line(width*0.5, 0, width*0.5, height);
  //line(0, height*0.5, width, height*0.5);
}  