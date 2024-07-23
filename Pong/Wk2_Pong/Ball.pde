
class Ball {
  float x;
  float y;             //declaring variables
  float dx;
  float dy;           // speed in x and y direction
  int radius;
  color ballColor = color(220, 200, 80);

  Ball() {                                   //assigning variables to randm positions on screen
    x = random(SCREENX/4, SCREENX/2);
    y = random(SCREENY/4, SCREENY/2);
    dx = random(1, 2);
    dy = random(1, 2);
    radius = 15;
  }
  void update() {
    x = x + dx;
    y = y + dy;
  }
  void move() {
    x = x+dx;
    y = y+dy;                              //moves ball from x or y position by set speed
  }
  void draw() {
    fill(ballColor);
    ellipse(int(x), int(y), radius, radius );  //draws circle - (position in x direction, position in y direction, width, height)
  }
  void collide(Player tp) {
    if (x-radius <=0 && dx < 0 ) dx =-dx; //reverse ball speed
    // else  if x > width of screen , revrse xspeed of ball
    else if (x + radius>= SCREENX && dx > 0/* added dx > 0 */) dx=-dx;
    //if y position + radius of ball(size pf ball) >=
    if (y+radius >= tp.ypos && y-radius < tp.ypos + PADDLEHEIGHT
      && x >= tp.xpos && x <= tp.xpos + PADDLEWIDTH) {
      println("collided!");
      dy = -dy;
    }
  }
  void reset() {
    if (y - radius >= SCREENY) {              //if the ball is below screen - player looses
      thePlayer.lives--;
    }
    if (y + radius <= 0) {                     //if the ball is above screen - computer looes
      theComputer.lives--;
    }
    if (y - radius >= SCREENY
      || y + radius <= 0) {
      x = random(SCREENX/4, SCREENX/2);       //put ball back at random position
      y = random(SCREENY/4, SCREENY/2);
      dx = 0;                                 //resetting sppeds
      dy = 0;
      count++;
      gamesCount++;
    }
  }
  void edges() {                       // deals with ball hitting top or bottom of screen
    if ( x < 0 || x > SCREENX) {      //if x is behind screen x < 0, or outside screen, x > width
      dx *= -1;                       //reverse x speed - move backwards
    }
  }
  void check() {
    if (y - radius >= SCREENY || y + radius <= 0) {
      check = 1;
      thePlayer.lives--;
      theComputer.lives++;
    }
  }
}
