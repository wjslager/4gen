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
    areaCheckers[i] = new AreaChecker(10, 10, 50, 50);
  }
  noFill();
}

void draw() {
  image(video, 0, 0);

  // Do stuff for each of the 4 area's
  for (int area=0; area<4; area++)
  {
    areaCheckers[area].check();


    /*
    loadPixels();
     int areaOffsetX = int((area % 2) * width * 0.5);
     int areaOffsetY = int(area * 0.5) * int(width * height * 0.5);
     color[] last = new color[int(width * height * 0.25)];
     
     for (int px=0; px < (pixels.length*0.25); px++) 
     {
     areaPixels[px] = pixels[(px % int(width*0.5) + int(px / (width * 0.5)) * width) + areaOffsetX + areaOffsetY];
     
     // Acces all pixels in this area using:
     // pixels[(px % int(width*0.5) + int(px / (width * 0.5)) * width) + areaOffsetX + areaOffsetY]
     
     }
     updatePixels();
     */
  }

  //line(width*0.5, 0, width*0.5, height);
  //line(0, height*0.5, width, height*0.5);
}  