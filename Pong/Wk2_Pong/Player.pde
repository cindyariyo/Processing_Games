class Player {                                       //instance variables declared
  int xpos;
  int ypos;                                          //x/y position of paddle
  color paddlecolor = color(80, 100, 200);
  int lives = 3;
  int xspeed = 3;

  Player(int screen_y)
  {
    xpos = SCREENX/2;
    ypos = screen_y;
  }
  void move(int x) {
    if (x>SCREENX-PADDLEWIDTH) xpos = SCREENX-PADDLEWIDTH; //position of player
    else xpos = x;
  }
  void moveComputer() {
    xpos = xpos + 3;
    ypos = ypos + 3;
  }
  void draw() {
    fill(paddlecolor);                                 //draw the players paddle
    rect(xpos, ypos, PADDLEWIDTH, PADDLEHEIGHT);
  }
  void gameLives() {
    //if (lives == 0) {
    if (theComputer.lives == 0) {
      fill(255);
      textSize(40);
      text("You won!", 85, 200);
    } else if (thePlayer.lives == 0) {
      fill(255);
      textSize(20);
      text("You lost, try again!", 85, 200);
    }
    
  }
}
