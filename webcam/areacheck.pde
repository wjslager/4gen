class AreaChecker {  
  int x1, y1, x2, y2, totalPixels, px;
  float r = 0, g = 0, b = 0;
  float lastR, lastG, lastB;
  float difference;

  AreaChecker(int x1in, int y1in, int x2in, int y2in) 
  {
    x1 = x1in;
    y1 = y1in;
    x2 = x2in;
    y2 = y2in;
    totalPixels = x2 * y2;
    //println("New areachecker " + x1 + " " + y1 + " "  + x2 + " "  + y2);
  } 

  void check() 
  {
    loadPixels();

    // Execute actions for each pixels
    for (int i=0; i<totalPixels; i++)
    {
      //   horiz.     vert.                   x  &  y   offset
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

    // Difference since last check
    difference = (r - lastR) + (g - lastG) + (b - lastB);

    lastR = r;
    lastG = g;
    lastB = b;
    
    text(difference, x1 + x2*0.5, y1 + y2*0.5);

    //fill(r, g, b, 255);
    //rect(x1, y1, x2, y2);
  }
} 