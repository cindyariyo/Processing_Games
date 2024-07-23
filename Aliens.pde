class Alien {
  final int FORWARD = 3;
  final int BACKWARD = 1;
  final int DOWN = 2;
  final int WIDTH = 30;
  final int HEIGHT = 35;
  final int NOT_EXPLODING = 0;
  static final int EXPLODING = 1;
  boolean die = false;
  
  
    int x, y, direction, backwards, down, status;
    int xs = 0;
    int ys = 0;
    int death=0;
    PImage myImage;
    PImage explodeImg;
    boolean dead = false;
    boolean alive = true;
    boolean shoot = false;
    Bomb theBombs;
  
    Alien(int xs, int ys, PImage myImage, PImage exImg) {
      this.xs = xs;
      this.ys = ys;
      this.myImage = myImage;
      explodeImg = exImg;
      direction = FORWARD;
      down= 1;
      backwards = 1;
      this.status = NOT_EXPLODING;
      theBombs = new Bomb(xs,ys);
    }
  
    void move() {
      if (die) {
        direction = 0;  //aliens stop moving
      }
      if (ys >= SCREENY - WIDTH) {
        //xs = 0; ys = 0;               //stop when reach end of screen
        direction = 0;
      } else if (direction == FORWARD ) {    //if move is set to forward, xpos is incremented
        xs++;
        if ( xs >= SCREENX - WIDTH) {  //once aliens are outside the screen, move is set to down
          direction = DOWN;
        }
      } else if (direction == DOWN ) {  //if move is set to down, aliens move down the ypos
        ys++;
        ys++;
        down++;
        if (down == HEIGHT) {
          x--;
          down = 0;            //reset down
          if (xs == 0) {       //if xpos returns to start of screen, reset move to forward(across)
            direction = FORWARD;
          } else {
            direction = backwards;
          }
        }
      } 
      else if (direction != 0) {      //if move = backwards(!down/forwards) xpos reverses
        xs--;
        if (xs == 0) {
          direction = DOWN;   //move is set back to down
        }
      }
    }
    void draw() {
      image(myImage, xs, ys);
    }
  
    void explode() {
      status = EXPLODING;
      myImage = explodeImg;
    }
  
    void die() {
      direction = 0;
      dead = true;
      status = EXPLODING;
       
    }
    
    Bomb getBomb() {
      return theBombs; 
    }
    void alienBomb() {
      if(alive && theBombs.ypos > SCREENY + 10 ){
        theBombs = new Bomb(xs, ys);
      }
      
    }
}
