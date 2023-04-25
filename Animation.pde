class Animation {
  // variables
  PImage[] images; //array that holds all the images 
  float speed; //how fast animation goes
  float scale; //multiplier 

  float index;
  boolean isAnimating; //true= plays animation and vice versa

  // constructor
  Animation(PImage[] tempImages, float tempSpeed, float tempScale) {
    images = tempImages;
    speed = tempSpeed;
    scale = tempScale;

    index = 0;
    isAnimating = false;
  }

  // updates the index which image to display for
  // the animation
  void next() {
    println(index);
    index += speed;

    // resets the index if it is too big
    if (index >= images.length) {
      index=0;
      isAnimating=false;
    }
  }

  // display an image of the animation
  void display(int x, int y) { //like render
    imageMode(CENTER);
    if (isAnimating) {
      int imageIndex = int(index);
      PImage img = images[imageIndex];
      image(img, x, y, img.width*scale, img.height*scale);

      // increment the index of the images to display
      next();
    } else {
      PImage img = images[0];
      image(img, x, y, img.width*scale, img.height*scale);
    }
  }
  
  void displayBackground(int x, int y) { //like render
    imageMode(CENTER);
    if (isAnimating) {
      int imageIndex = int(index);
      PImage img = images[imageIndex];
      image(img, x, y, width, height);

      // increment the index of the images to display
      next();
    } else {
      PImage img = images[0];
      image(img, x, y, img.width*scale, img.height*scale);
    }
  }
}
