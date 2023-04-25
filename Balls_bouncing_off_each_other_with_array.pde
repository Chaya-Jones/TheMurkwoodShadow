

///////////////// VARIABLE DECLARATION
import processing.sound.*;

PImage  jumpScareImg;

PImage  titleImg;

PImage  deadPlayerImg;

PImage  playerImg;

PImage story1Img;

PImage story2Img;

PImage story3Img;

PImage story4Img;

PImage helpScreenImg;

PImage keepGoingImg;

PImage winScreenImg;

Animation shadowAnimation; 
PImage [] shadowImages = new PImage [8];

Animation homeAnimation; 
PImage [] homeImages = new PImage [6];

Animation fogAnimation; 
PImage [] fogImages = new PImage [8];


Button storyBut;
Button helpBut;
Button startBut;
Button homeBut;

SoundFile backgroundMusic;
SoundFile jumpScare;

ArrayList<Ball> ballList;

Player p1;

int state = 0;

int startTime;
int currentTime;
int interval = 30000;

int spawnTime = 6000;

int butD = 70;

int storyButX  ;
int storyButY;
int helpButX ;
int helpButY;
int startButX ;
int startButY;
int homeButX;
int homeButY;



void setup() {
  ///////////////// SETTINGS
  size(800, 600);
     textAlign(CENTER);
    rectMode(CENTER);
   
    //animation init vars 
     for (int index=0; index<6; index++){ //index is the number of file name
    homeImages[index] = loadImage("home" + index + ".png");
  }

  
   for (int index=0; index<8; index++){ //index is the number of file name
    shadowImages[index] = loadImage("shadow" + index + ".png");
  }
 
  for (int index=0; index<8; index++){ //index is the number of file name
    fogImages[index] = loadImage("fog" + index + ".png");
  }
  
    playerImg = loadImage("player3.png");
  imageMode(CENTER);
  
   jumpScareImg = loadImage("jumpScare0.png");
  imageMode(CENTER);
 
    story1Img = loadImage("story1.jpg");
  imageMode(CENTER);
  
    story2Img = loadImage("story2.jpg");
  imageMode(CENTER);
  
    story3Img = loadImage("story3.jpg");
  imageMode(CENTER);
  
    story4Img = loadImage("story4.jpg");
  imageMode(CENTER);
  
      helpScreenImg = loadImage("helpScreen.jpg");
  imageMode(CENTER);
  
      keepGoingImg = loadImage("keepGoing.jpg");
  imageMode(CENTER);
  
      winScreenImg = loadImage("winScreen.jpg");
  imageMode(CENTER);
 
  
 jumpScareImg.resize(int(width), int(height));
 
   deadPlayerImg = loadImage("deadPlayer0.png");
  imageMode(CENTER);
 
   titleImg = loadImage("title0.png");
  imageMode(CENTER);
 
  
  float titleScale = .8;
  
  titleImg.resize(int(titleImg.width* titleScale), 
                 int(titleImg.height * titleScale));
                 
                 
                  
  playerImg.resize(int(playerImg.width* .08), 
                 int(playerImg.height * .08));             
                  
  deadPlayerImg.resize(int(deadPlayerImg.width* .085), 
                 int(deadPlayerImg.height * .085));
 
  homeAnimation = new Animation(homeImages, .01, .85);
    shadowAnimation = new Animation(shadowImages, .01, 1.2);
      fogAnimation = new Animation(fogImages, .01, .85);
 
    
     
   storyButX = width/4 ;
storyButY = height - butD;
 helpButX = 3*width/4;
 helpButY = height - butD;
 startButX = width/2;
 startButY = height - butD;
    
 

  
  backgroundMusic = new SoundFile(this, "backgroundMusic.wav");
  jumpScare = new SoundFile(this, "jumpScare.wav");
  
  storyBut = new Button(storyButX, storyButY, butD, color(166, 185, 203));
  helpBut = new Button(helpButX, helpButY, butD,  color(104, 116, 129));
  startBut = new Button(startButX, startButY, butD, color(144, 162, 180));

startTime = millis();

  p1 = new Player();
  // initialize the new ballList
  ballList = new ArrayList<Ball>();
}


void draw() {
    if (backgroundMusic.isPlaying() == false){
  backgroundMusic.play();
  }
  
  switch(state){
    case 0:
    
   homeAnimation.displayBackground(width/2, height/2);
    homeAnimation.isAnimating = true;
    
    image(titleImg, width/2, height/3);
    
   storyBut.render();
  storyBut.click();
   helpBut.render();
  helpBut.click();
   startBut.render();
  startBut.click();
   textSize(30);
   
   fill(255);
     text("Story",  storyButX, storyButY );
     text("How to play",  helpButX, helpButY);
      text("Start",  startButX,startButY );
     //text("Warning: jumpscare if you lose", 100, height/2);
     // text("press 'r' to start", 100, height/4);
      
      if(startBut.click() == true){
        state = 1;
          startTime = 0;
         startTime = millis();
      }
      
        else if (helpBut.click() == true){
        state = 8;
      }
      
        else if(storyBut.click() == true){
        state = 9;
      }
      
      break;
    case 1:
   fogAnimation.displayBackground(width/2, height/2);
    fogAnimation.isAnimating = true;
     
  
  currentTime = millis();
  println(currentTime);


    

  p1.render();
  p1.move();

  p1.collision(ballList);

  shadowAnimation.isAnimating = true;

  // this loops through all of the balls in ballList and draws and moves them
  for (Ball aBall : ballList) {
    aBall.render();
    aBall.move();
    aBall.wallDetect();
    
    loose();
    moveOnTwo();

    for (Ball otherBall : ballList) {
      if (aBall != otherBall) {
        aBall.collision(otherBall);
      }
    }
  }
  
  if (currentTime % spawnTime >= 0 && currentTime % spawnTime <= 20 ){ //26 spawns 2?? 50 spawns 3?
    ballList.add(new Ball());
  }
  
  break;
  
   case 2:
   background(42);
         background(0);
         image(keepGoingImg, 3*width/5, height/2);
       ballList = new ArrayList();
       startTime = millis();
      break;
 
     
      case 3:
    currentTime = millis();
  println(currentTime);

   fogAnimation.displayBackground(width/2, height/2);
    fogAnimation.isAnimating = true;
    
  
 

  p1.render();
  p1.move();

  p1.collision(ballList);



  // this loops through all of the balls in ballList and draws and moves them
  for (Ball aBall : ballList) {
    aBall.render();
    aBall.move();
    aBall.wallDetect();
    
    loose();
    moveOnThree();

    for (Ball otherBall : ballList) {
      if (aBall != otherBall) {
        aBall.collision(otherBall);
      }
    }
  }
  if (currentTime % spawnTime >= 0 && currentTime % spawnTime <= 50 ){ //26 spawns 2?? 50 spawns 3?
    ballList.add(new Ball());
  }
 
  
  break;
     case 4:
 
         background(0);
         image(keepGoingImg, 3*width/5, height/2);
        ballList = new ArrayList();
        startTime = millis();
        println(startTime);
      break;
  
  case 5:
    fogAnimation.displayBackground(width/2, height/2);
    fogAnimation.isAnimating = true;
   
  currentTime = millis();
  println(currentTime);
 

  p1.render();
  p1.move();

  p1.collision(ballList);
  

  // this loops through all of the balls in ballList and draws and moves them
  for (Ball aBall : ballList) {
    aBall.render();
    aBall.move();
    aBall.wallDetect();
    
    loose();
    win();

    for (Ball otherBall : ballList) {
      if (aBall != otherBall) {
        aBall.collision(otherBall);
      }
    }
  }

  
  if (currentTime % spawnTime >= 0 && currentTime % spawnTime <= 70 ){ //26 spawns 2?? 50 spawns 3?
    ballList.add(new Ball());
  }
  
  break;
  
    
  case 6:
  background(0);
         image(winScreenImg, 3*width/5, height/2);
      startTime = millis();
        ballList = new ArrayList();
      break;
      
      //jumpScare screen
  case 7:
  image(jumpScareImg, width/2, height/2);
     ballList = new ArrayList();
   backgroundMusic.stop();
  jumpScare.play();
  noLoop();
      textSize(100);
      stroke(255);
      //text("Jump Scare :0", width/2, height/2);
      break;
      
     //'how to play' screen 
     case 8:
      background(0);
         image(helpScreenImg, 3*width/5, height/2);
    
     homeButX = width-50;
     homeButY = height-height+ 50;
      homeBut = new Button(homeButX, homeButY, 50, color(166, 185, 203));
        homeBut.render();
    homeBut.click();
      fill(255);
    textSize(15);
    text("Home",  homeButX,homeButY );
        
     
      if(homeBut.click() == true){
        state = 0;
      }
     break;
     
     
     case 9:
     background(0);
         image(story1Img, 3*width/5, height/2);
     
       homeButX = width-50;
     homeButY = height-height+ 50;
      homeBut = new Button(homeButX, homeButY, 50, color(166, 185, 203));
        homeBut.render();
    homeBut.click();
           fill(255);
    textSize(15);
    text("Home",  homeButX,homeButY );
     
      if(homeBut.click() == true){
        state = 0;
      }
     break;
     
       case 10:
     background(0);
         image(story2Img, 3*width/5, height/2);
     
       homeButX = width-50;
     homeButY = height-height+ 50;
      homeBut = new Button(homeButX, homeButY, 50, color(166, 185, 203));
        homeBut.render();
    homeBut.click();
           fill(255);
    textSize(15);
    text("Home",  homeButX,homeButY );
     
      if(homeBut.click() == true){
        state = 0;
      }
     break;
  
  case 11:
     background(0);
         image(story3Img, 3*width/5, height/2);
     
       homeButX = width-50;
     homeButY = height-height+ 50;
      homeBut = new Button(homeButX, homeButY, 50, color(166, 185, 203));
        homeBut.render();
    homeBut.click();
           fill(255);
    textSize(15);
    text("Home",  homeButX,homeButY );
     
      if(homeBut.click() == true){
        state = 0;
      }
     break;
     
     case 12:
     background(0);
         image(story4Img, 3*width/5, height/2);
     
       homeButX = width-50;
     homeButY = height-height+ 50;
      homeBut = new Button(homeButX, homeButY, 50, color(166, 185, 203));
        homeBut.render();
    homeBut.click();
           fill(255);
    textSize(15);
    text("Home",  homeButX,homeButY );
     
      if(homeBut.click() == true){
        state = 0;
      }
     break;
}
}




// move forward if key pressed 
void keyPressed() {

  if (key == 'r' && state <= 11)
  state += 1;
}

  void loose(){
    if (p1.score == p1.looseScore){
  
      state = 7;
      startTime = 0;
         startTime = millis();
    }
  }
  
  void win(){
    if((currentTime - startTime >= interval)){
      state = 6;
      startTime = 0;
         startTime = millis();
    }
  }
    
    void moveOnTwo(){
     if((currentTime - startTime >= interval)){
      p1.score=0;
       state = 2;
       startTime = 0;
         startTime = millis();
      state= 2; 
    }
    }
    
    void moveOnThree(){
      if((currentTime - startTime >= interval)){
      p1.score=0;
        state = 4;
      startTime = 0;
         startTime = millis();
      state= 4;
    }
    
  }
