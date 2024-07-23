final int SCREENX = 600;
final int SCREENY = 600;
final int ALIENWIDTH = 60; // Size
int aliens = 10; // Initial number of aliens
boolean lose = false;
int j = 0;
Alien theAliens[];
Player thePlayer;
Bullet theBullets[];
Bomb theBombs;
PImage myImage, exImg;
PFont font;
boolean play = true;

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  font = createFont("Arial", 28, true);
  myImage = loadImage("invader.gif");
  exImg = loadImage("exploding.GIF");
  theAliens = new Alien[10];
  thePlayer = new Player(SCREENX, SCREENY);
  theBullets = new Bullet[55];
  init_array(theAliens, myImage, exImg);
}

void draw() {
  background(0);
  textFont(font, 28);
  fill(255);
  
  // Display title text centered
  textAlign(CENTER);
  text("S P A C E   I N V A D E R S", SCREENX / 2, 30);

  if (play) {
    for (int i = 0; i < theAliens.length; i++) {
      if (theAliens[i] != null) { // Check if the alien is not null
        theAliens[i].move();
        theAliens[i].draw();

        if (theAliens[i].death <= 1 && theAliens[i].alive) { // Bomb disappears if alien is shot
          // Starts bombs once an alien dies
          theBombs = theAliens[i].getBomb();

          if (theBombs != null) {
            if (theBombs.collide(thePlayer)) {
              lose = true;
              play = false;
              break; // Exit the loop once the game is over
            } else {
              theBombs.move();
              theBombs.draw();
              theAliens[i].alienBomb();
            }
          }
        }

        if (theAliens[i].dead) {
          theAliens[i] = null; // Remove the dead alien
          aliens--;
        }
      }
    }

    if (aliens == 0) {
      play = false;
    }

    thePlayer.move(mouseX);
    thePlayer.draw();

    for (int i = 0; i < j; i++) {
      if (theBullets[i] != null) {
        theBullets[i].move();
        theBullets[i].draw(); // One bullet drawn for every bullet made
        theBullets[i].collide(theAliens);
      }
    }

    if (lose && j >= 50) {
      play = false;
    }

  } else {
    textAlign(CENTER, CENTER); // Center both horizontally and vertically
    
    textSize(30);
    if (lose) {
      text("Game Over", SCREENX / 2, SCREENY / 2 - 20);
      text("You ran out of bullets", SCREENX / 2, SCREENY / 2 + 20);
    } else {
      text("You win", SCREENX / 2, SCREENY / 2 - 20);
    }

    textSize(20);
    text("Click to restart", SCREENX / 2, SCREENY / 2 + 80);
  }
}

void init_array(Alien[] theAliens, PImage myImage, PImage exImg) {
  for (int i = 0; i < theAliens.length; i++) {
    theAliens[i] = new Alien(0 + i * ALIENWIDTH, 80, myImage, exImg); // (XPOS + WIDTH OF ALIEN, YPOS, IMAGE)
  }
}

void mousePressed() {
  if (play) {
    try {
      theBullets[j] = new Bullet(thePlayer.xpos + PADDLEWIDTH / 2, SCREENY - PADDLEHEIGHT);
      // Bullet created at player's position when mouse is pressed
      theBullets[j].bullet = true;
      j++;
    } catch (ArrayIndexOutOfBoundsException e) {
      if (j >= 50) {
        lose = true;
      }
    }
  } else {
    // Restart the game
    resetGame();
  }
}

void resetGame() {
  play = true;
  lose = false;
  j = 0;
  aliens = 10;
  theAliens = new Alien[10];
  theBullets = new Bullet[55];
  thePlayer = new Player(SCREENX, SCREENY);
  init_array(theAliens, myImage, exImg);
}
