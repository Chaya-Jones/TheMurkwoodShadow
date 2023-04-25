class Button {
 


///////////////////////////////////////////////////////
        //////global vars///////
///////////////////////////////////////////////////////
  int buttonSize; // the length/width of the button
  int x; // the x position 
  int y; // the y position
  int c; 


 
  boolean isPressed;


///////////////////////////////////////////////////////
        //////setup and draw//////
///////////////////////////////////////////////////////

Button (int butX, int butY, int butSize, color butC){

  x = butX;
  y = butY;
  buttonSize = butSize;
  c = butC;

}



void render(){
  //textMode(CENTER);
  rectMode(CENTER);
  fill(c);
  square(x, y, buttonSize);
  
}



///////////////////////////////////////////////////////
        //////button if statements//////
///////////////////////////////////////////////////////

boolean isBetween(int num, int min, int max){
  //if num is between min and max
  //then return true
  if (num > min && num < max){
    return true;
  }
  //if num is not btw min and max
  //then return false
    else {
      return false;
    }
}

boolean isMouseInButton(int x, int y, int w){
  int left = x-w/2;
  int right = x+w/2;
  int top = y-w/2;
  int bottom = y+w/2;
  
  if (isBetween(mouseX, left, right) == true 
  && isBetween(mouseY, top, bottom) == true){ 
    return true;
  }
    else{
      return false; 
     }
  }



/////////////////////////////////////////////////////
        ////mousePressed//////
/////////////////////////////////////////////////////

boolean click(){
 if (mousePressed && isMouseInButton(x, y, buttonSize)){
      println("true");
    return true;
    
}

    
 else { //(!mousePressed && isMouseInButton(x, y, buttonSize))??
   println("flase");
   return false;
   
  }
  

  
}
}
