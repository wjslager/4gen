class AreaChecker {  
  int x1, y1, x2, y2;
  int xLength, yLength;
  int totalPixels;
  int px;

  AreaChecker(int x1in, int y1in, int x2in, int y2in) 
  {
    x1 = x1in;
    y1 = y1in;
    x2 = x2in;
    y2 = y2in;
    totalPixels = x2 * y2;
    println("New areachecker " + x1 + " " + y1 + " "  + x2 + " "  + y2);
  } 

  void check() 
  {
    loadPixels();

    for (int i=0; i<totalPixels; i++)
    {
      /*   horiz.     vert.                   x  &  y   offset    */
      px = (i % x2) + (int(i / x2) * width) + x1 + (y1 * width);
      
      pixels[px] = color(255, 0, 255);
    }
    updatePixels();
    
    rect(x1, y1, x2, y2);
  }
} 