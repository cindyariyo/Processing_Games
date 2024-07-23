class Bullet {
  int xpos, ypos;
  boolean bullet = false;
  int deathToll = 0;

  Bullet(int xpos, int ypos) {
    this.xpos = xpos;
    this.ypos = ypos;    
  }

  void move() {
    if (mousePressed) bullet = true;
    ypos -= 3;
  }

  void collide(Alien theAliens[]) {
    for (int i = 0; i < theAliens.length; i++) {
      if (theAliens[i] != null) { // Check if the alien is not null
        // If alien width < bullet xpos > alienxpos && alien height < bullet ypos > alienypos
        if (xpos >= theAliens[i].xs && xpos <= theAliens[i].xs + ALIENWIDTH
            && ypos >= theAliens[i].ys && ypos <= theAliens[i].ys + ALIENWIDTH) {
          theAliens[i].status = Alien.EXPLODING;
          theAliens[i].myImage = exImg;
          theAliens[i].die();
          theAliens[i].dead = true;
          theAliens[i].alive = false;
          deathToll++;
        }
      }
    }
  }

  void draw() {
    if (mousePressed) {
      bullet = true;
    }
    fill(400, 300, 70);
    noStroke();
    ellipse(xpos, ypos, 10, 10);
  }  
}
