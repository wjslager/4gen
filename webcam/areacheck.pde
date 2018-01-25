class AreaChecker 
{  
  int x1, y1, x2, y2, totalPixels, px;
  float r, g, b;
  float rCalibration, gCalibration, bCalibration;
  float lastR, lastG, lastB;
  float activity;   // difference with last check
  float difference; // difference from calibration

  AreaChecker(int x1in, int y1in, int x2in, int y2in) 
  {
    x1 = x1in;
    y1 = y1in;
    x2 = x2in;
    y2 = y2in;
    totalPixels = x2 * y2;
  } 

  void check() 
  {
    r = 0; 
    g = 0; 
    b = 0;

    for (int i=0; i<totalPixels; i++)
    {
      // Convert i to the pixel coordinates of pixels within this AreaChecker
      //   horiz.     vert.   wrap            x  &  y    offset
      px = (i % x2) + (int(i / x2) * width) + x1 + (y1 * width);

      // Retrieve RGB values using bitshifting (magic)
      r += (pixels[px] >> 16) & 0xFF;
      g += (pixels[px] >> 8)  & 0xFF;
      b +=  pixels[px]        & 0xFF;
    }

    // Average
    r = r / totalPixels;
    g = g / totalPixels;
    b = b / totalPixels;

    // Activity since last check
    activity   = (r - lastR)        + (g - lastG)        + (b - lastB);
    difference = (r - rCalibration) + (g - gCalibration) + (b - bCalibration);

    lastR = r;
    lastG = g;
    lastB = b;

    rect(x1, y1, x2 - 1, y2 - 1);
    text("Activity: " + activity, x1 + 10, y1 + 10);
    text("Difference: " + difference, x1 + 10, y1 + 35);
  }

  void calibrate()
  {
    rCalibration = 0; 
    gCalibration = 0; 
    bCalibration = 0;

    for (int i=0; i<totalPixels; i++)
    {
      // Convert i to the pixel coordinates of pixels within this AreaChecker
      //   horiz.     vert.   wrap            x  &  y    offset
      px = (i % x2) + (int(i / x2) * width) + x1 + (y1 * width);

      // Retrieve RGB values using bitshifting (magic)
      rCalibration += (pixels[px] >> 16) & 0xFF;
      gCalibration += (pixels[px] >> 8)  & 0xFF;
      bCalibration +=  pixels[px]        & 0xFF;
    }

    // Average
    rCalibration = rCalibration / totalPixels;
    gCalibration = gCalibration / totalPixels;
    bCalibration = bCalibration / totalPixels;
  }
} 