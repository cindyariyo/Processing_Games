


class Bomb {
  int xpos, ypos;
  
Bomb(int x, int y) {
    xpos = x;
    ypos = y;
  }
  void move() {
    //if(collide(thePlayer)) {}
    //if (offScreen()) {}
     ypos++;
  }
  
  void draw() {   
    fill(50, 300, 200);
    ellipse(int(xpos), int(ypos), 15, 15);
  }
  
  boolean offScreen() {
    if(ypos>SCREENX) {    //if bomb has went off the screen
     return true;
    }
    return false;
  } 
  
  boolean collide(Player thePlayer) {    //if bomb has touched player 
    if(xpos >= thePlayer.xpos && xpos <= thePlayer.xpos + PADDLEWIDTH && 
    ypos >= thePlayer.ypos && ypos <= thePlayer.ypos + PADDLEHEIGHT) {
      return true;
    }
    else return false;
  }
}
