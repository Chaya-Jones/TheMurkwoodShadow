class Ball { 
  /*
  Class variables
   */
  int x; // x pos of the ball
  int y; // y pos of the ball
  int d; // diameter of the ball
  color fillColor; // color of the ball's fill

  int xSpeed; // the speed the ball moves in the x direction
  int ySpeed; // the speed the ball moves in the y direction

  //hit box vars
  float top;
  float bottom;
  float left;
  float right;

  /*
  Constructor
  */

  Ball() {
    // initial values of all the variables
    int speedMag = 10;

    xSpeed = int(random(-speedMag, speedMag));
    ySpeed = int(random(-speedMag, speedMag));

    if (xSpeed == 0) {
      xSpeed = speedMag;
    }
    if (ySpeed == 0) {
      ySpeed = speedMag;
    }


    x = int(random(width/4, 3*width/4));
    y = height/2;
    d = int(random(20, 40));
    fillColor = color(int(random(42, 255)));
 
  //initialize hitbox vars 
  top = y - d/2;
  bottom = y + d/2; 
  left = x - d/2;
  right = x + d/2; 
}

/*
draws the ball
*/
  void render() {
   shadowAnimation.display(x, y);
    //fill(fillColor);
    //circle(x, y, d);
  }

  /*
This function takes updates the position the ball according to its speed.
   */
  void move() {
    x += xSpeed;
    y += ySpeed;
    
  top = y - d/2;
  bottom = y + d/2; 
  left = x - d/2;
  right = x + d/2; 
  
  }

  /*
This function checks if the ball is touching an edge. If it is, the speed flips
   */
  void wallDetect() {
    // detects wall detection for the right wall
    if (x+d/2 >= width) {
      xSpeed = -abs(xSpeed);
    }
    // wall detection for left wall
    if (x-d/2 <= 0) {
      xSpeed = abs(xSpeed);
    }

    // wall detection for the bottom wall
    if (y+d/2 >= height) {
      ySpeed = -abs(ySpeed);
    }
    // wall detection for left wall
    if (y-d/2 <= 0) {
      ySpeed = abs(ySpeed);
      //println(ySpeed);
    }
  }
  
  
  
  void collision(Ball otherBall) {
    if (top < otherBall.bottom) {
      if (bottom > otherBall.top) {
        if (left < otherBall.right) {
          if (right > otherBall.left) {
            // if the current ball is to the left of otherBall
            if (x < otherBall.x) {
              xSpeed = -abs(xSpeed); // make current ball xSpeed negative
              otherBall.xSpeed = abs(otherBall.xSpeed); // make other ball xSpeed positive
            } else if (x >= otherBall.x) { // if current ball is to the right of otherBall
              xSpeed = abs(xSpeed); // make current ball xSpeed positive
              otherBall.xSpeed = -abs(otherBall.xSpeed); // make other ball xSpeed negative
            }

            // if the current ball is to the above the otherBall
            if (y < otherBall.y) {
              ySpeed = -abs(ySpeed); // make current ball ySpeed negative
              otherBall.ySpeed = abs(otherBall.ySpeed); // make other ball ySpeed positive
            } else if (y >= otherBall.y) { // if current ball is to the below of otherBall
              ySpeed = abs(ySpeed); // make current ball ySpeed positive
              otherBall.ySpeed = -abs(otherBall.ySpeed); // make other ball xSpeed negative
            }
          }
        }
      }
    }
  }
}
