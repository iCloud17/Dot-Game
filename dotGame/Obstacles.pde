class Obstacles {
  int startx, starty, len, brd;
  
  Obstacles(int x, int y, int l, int b) {
     startx =x;
     starty = y;
     len = l;
     brd = b;
     fill(0,0,255);
     rect(x,y,l,b);
  }
  
}
