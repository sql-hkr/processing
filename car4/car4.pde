class Car
{
  int xpos;
  int ypos;
  int xspeed;
  int yspeed;
  PImage carImg = loadImage("carImg.png");
  boolean visible = true;
  
  Car()
  {
    xpos = 0;
    ypos = 0;
    xspeed = 0;
    xspeed = 0;
  }
  
  Car(int xpos, int ypos, int xspeed, int yspeed)
  {
    this.xpos = xpos;
    this.ypos = ypos;
    this.xspeed = xspeed;
    this.yspeed = yspeed;
  }
  
  void move()
  {
    xpos += xspeed;
    ypos += yspeed;
    if (xpos<0)xspeed=xspeed*-1;
    if (ypos<0)yspeed=yspeed*-1;
    if (xpos>width-50)xspeed=xspeed*-1;
    if (ypos>width-50)yspeed=yspeed*-1;
  }
  
  void output()
  {
    if(visible) image(carImg, xpos, ypos, 50, 50);
  }
  
  boolean isHit(Car car[]) {
    int b = 0;
    for(int i=0; i<num; i++){
      if ((xpos-50>car[i].xpos) && (xpos+50<car[i].xpos) && (ypos-50>car[i].ypos) && (ypos+50<car[i].ypos)) {
        b++;
      }
    }
    if(b == 0){
      return false;
    }else{
      return true;
    }
  }
}

Car []car;
int num=10;

void setup()
{
  size(400, 400);
  frameRate(30);
  car = new Car[num];
  for (int i=0; i<num; i++) {
      car[i] = new Car((int)random(0,width-50), (int)random(0,width-50), (int)random(-5,5), (int)random(-5,5));
  }
}

void draw()
{
  background(255);
  for (int i=0; i<num; i++) {
      car[i].move();
      car[i].output();
      if (car[i].isHit(car)==true && car[i].visible==true){
        car[i].visible = false;
        car[i].xpos = 1000;
      }
  }
}

