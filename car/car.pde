class Car
{
  int xpos;
  int ypos;
  int xspeed;
  int yspeed;
  PImage carImg = loadImage("carImg.png");
  boolean visible = false;
  
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
}

class MyCar extends Car {
  MyCar()
  {
    super();
  }
  void init()
  {
    xpos = mouseX;
    ypos = mouseY;
    xspeed = (int)random(-5, 5);
    yspeed = (int)random(-5, 5);
    visible = true;
  }
}

MyCar []mycar;
int num=10;

void setup()
{
  size(400, 400);
  frameRate(30);
  mycar = new MyCar[num];
  for (int i=0; i<num; i++) {
      mycar[i] = new MyCar();
  }
}

void draw()
{
  if(mousePressed){
    for (int i=0; i<num; i++) {
      mycar[i].init();
    }
  }
  background(255);
  for (int i=0; i<num; i++) {
      mycar[i].move();
      mycar[i].output();
  }
}

