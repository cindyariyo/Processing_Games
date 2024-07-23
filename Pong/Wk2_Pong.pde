final int SCREENX = 550;    //width of screen
final int SCREENY = 400;    //height of screen
final int PADDLEHEIGHT = 30;
final int PADDLEWIDTH = 100;
final int MARGIN = 10;
PFont myFont;
int count = 1;
int gamesCount = 1;
static int check = 0;


Player thePlayer;
Player theComputer;
Ball theBall;
int i = SCREENX/2;

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
      text("You won!", 100, 300);
    } else if (thePlayer.lives == 0) {
      fill(255);
      textSize(20);
      text("You lost, try again!", 150, 300);
    }
    
  }
}

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
    dx = random(2, 3);
    dy = random(2, 3);
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
void settings () {
  size(SCREENX, SCREENY);   // width, height
}
void setup() {
  thePlayer = new Player(SCREENY-MARGIN-PADDLEHEIGHT);
  theBall = new Ball();
  theComputer = new Player(0);
  ellipseMode(RADIUS);
  myFont = createFont("AgencyFB-Bold.vlw", 48);
}

void draw() {
  background(0);
  fill(120, 0, 240);
  textFont(myFont, 20);
  textAlign(CENTER);
  text("PONG", 300, 200);
  thePlayer.move(mouseX);            //calls move method on object thePlayer
  if (i > theBall.x) {           // if the ball is behind the i position, the computer moves backwards to catch up
    i-=2.5;                     //value for i determines speed of computer paddle in +/- direction
    theComputer.move(i--);
  } else {
    i+=2.5;
    theComputer.move(i++);
  }
  theBall.move();                    //calls move method on object theBall
  theBall.collide(thePlayer);
  theBall.collide(theComputer);
  thePlayer.gameLives();
  theComputer.gameLives();
  thePlayer.draw();
  theBall.edges();
  theBall.update();
  theBall.draw();
  theComputer.draw();
  if (count >=2 ) {
    println(gamesCount);
  }
  fill(255);
  textSize(20);
  text("Computer's lives: " + theComputer.lives, 85, 50);
  textSize(20);
  text("Your lives: " + thePlayer.lives, 60, 380);
  theBall.reset();
  if (gamesCount >=8) {
    theBall.update();
  }
}
void mousePressed() {
  theBall.dx = random(3, 2);
  theBall.dy = random(3, 2);
  if (theComputer.lives == 0 || thePlayer.lives ==0) {
      check = 1;
      thePlayer.lives =3;
      theComputer.lives =3;
    }
}
