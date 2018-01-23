class AreaChecker {  
  int x1, y1, x2, y2;
  
  AreaChecker(int x1in, int y1in, int x2in, int y2in) {
    this.x1 = x1in;
    this.y1 = y1in;
    this.x2 = x2in;
    this.y2 = y2in;
  } 

  void check() { 
    rect(x1, y1, x2, y2);
    
    // checking with last area pixels  blleegggg
  }
} 