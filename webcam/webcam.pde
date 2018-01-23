import processing.video.*;

Capture video;



void setup() {  
  size(640, 480);

  video = new Capture(this, 640, 480);
  video.start();  

  frameRate(10);

  strokeWeight(2);
}

void draw() {
  image(video, 0, 0);
  loadPixels();

  // Do stuff for each of the 4 area's
  for (int area=0; area<4; area++){

    // Do stuff for the pixels in this area
    for (int px=0; px < (pixels.length*0.25); px++) {
      //pixels[px % int(width*0.5) + int(px / (width * 0.5)) * width] = color(255);
      pixels[px % int(width*0.5) + int(px / (width * 0.5)) * width] = color(255);
      //pixels[px + area*int(pixels.length*0.25)] = color(64*area, 0, 0);
    }
  }
  
  updatePixels();

  line(width*0.5, 0, width*0.5, height);
  line(0, height*0.5, width, height*0.5);
}