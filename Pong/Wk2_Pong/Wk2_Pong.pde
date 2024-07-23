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
