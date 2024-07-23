final int PADDLEHEIGHT = 30;
final int PADDLEWIDTH = 100;

class Player {
  int xpos, ypos;
  //int x = 0;
  
  Player (int SCREENX, int SCREENY) {
    xpos = SCREENX/2;
    ypos = SCREENY-PADDLEHEIGHT;
    
  }
  
  void move(int x) {
    if(x>SCREENX-PADDLEHEIGHT) {   
      xpos = SCREENX-PADDLEWIDTH; //if reach screen, reset xpos
    }
    else xpos=x;  //reset xpos -> 0
    
  }
  void draw() {
    fill(255, 0,50);
    stroke(255);
    rect(xpos, ypos, 100, 30);
  }
  
}
