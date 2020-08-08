class Timer {
  int startTime = 0, stopTime = 0;
  boolean running = false;
  void start() {
    startTime = millis();
    running = true;
  }
  void stop() {
    stopTime = millis();
    running = false;
  }
  int getElapsedTime() {
    int elapsed;
    if (running) {
      elapsed = (millis() - startTime);
    } else {
      elapsed = (stopTime - startTime);
    }
    return elapsed;
  }
  int millisecond() {
    return getElapsedTime()%1000;
  }

  int second() {
    return (getElapsedTime() / 1000) % 60;
  }
  int millisecond(int ct) {
    return ct%1000;
  }

  int second(int ct) {
    return ct/1000;
  }
  
  String tLim(){
    int x = timeLimit-getElapsedTime();
    return Integer.toString(second(x))+"."+Integer.toString(millisecond(x)/10);
  }
}

class Boudaisei {
  int x;
  int y;

  boolean visible=true;
  PImage gakuseiImage;

  void move_right() {
    x=x+1;
  }

  void move_right(int speed) {
    x=x+speed;
  }

  void move_left() {
    x=x-1;
  }

  void move_left(int speed) {
    x=x-speed;
  }

  void move_up() {
    y=y-1;
  }

  void move_up(int speed) {
    y=y-speed;
  }

  void move_down() {
    y=y+1;
  }

  void move_down(int speed) {
    y=y+speed;
  }



  void output() {
    if (visible==true) {
      image(gakuseiImage, x, y, 50, 50);
    }
  }

  Boudaisei() {
    gakuseiImage=loadImage("sentouki 1.png");
  }

  Boudaisei(int ix, int iy) {
    x=ix;
    y=iy;
    gakuseiImage=loadImage("sentouki 1.png");
  }



  Boudaisei(int ix, int iy, int isx, int isy) {
    x=ix;
    y=iy;
    speedX=isx;
    speedY=isy;
    gakuseiImage=loadImage("sentouki 1.png");
  }



  int speedX;
  int speedY;

  void move() {
    x=x+speedX;
    y=y+speedY;
    if (x<0)speedX=speedX*-1;
    if (y<0)speedY=speedY*-1;
    if (x>750)speedX=speedX*-1;
    if (y>750)speedY=speedY*-1;
  }

  boolean isHit(Boudaisei tanin) {
    if ((this.x-50<tanin.x) && (this.x+50>tanin.x) && (this.y-50<tanin.y) && (this.y+50>tanin.y)) {
      return true;
    } else {
      return false;
    }
  }
}

class Akawan extends Boudaisei {
  void outputMouse() {
    x=mouseX;
    y=mouseY;
    image(gakuseiImage, mouseX, mouseY, 50, 50);
  }
  Akawan() {
    super();
  }
}

class Rope extends Boudaisei {
  Rope(int ix, int iy) {
    super(ix, iy);
  }

  Rope(int ix, int iy, int isx, int isy) {
    super(ix, iy, isx, isy);
  }

  void output() {
    fill(random(0, 255), random(0, 255), random(0, 255));
    ellipse(x, y, 10, 20);
  }

  boolean isHit(Rope r1) {
    if ((this.x-50<r1.x) && (this.x+50>r1.x) && (this.y-50<r1.y) && (this.y+50>r1.y)) {
      return true;
    } else {
      return false;
    }
  }
}

Timer t;
Rope r1;
Akawan kimura;
Boudaisei []mob;
int num=50;
int count1;
int state=0;
int timeLimit = 20000; //ms
boolean tReset = true;

void setup() {
  size(800, 800);
  r1=new Rope(400, 800, 0, 100);
  mob=new Boudaisei[num];
  kimura=new Akawan();
  t = new Timer();
  t.start();
}

void draw() {
  switch(state) {
  case 0:
    background(255);
    textSize(50);
    textAlign(CENTER, CENTER);
    fill(0);
    text("Please click mouse", width/2, height/2);
    if (mousePressed)
    {
      if(t.getElapsedTime()>2000){
        state=1;
        count1=0;
        for (int i=0; i<num; i++) {
          mob[i]=new Boudaisei((int)random(0, 400), (int)random(0, 400), (int)random(-5, 5), (int)random(-5, 5));
          mob[i].visible=true;
        }
      }
    }
    break;
    
  case 1:
    background(255);
    r1.move_up(10);
    r1.output();
    kimura.outputMouse();
    
    for (int i=0; i<num; i++) {
      mob[i].move();
      mob[i].output();
    }

    for (int i=0; i<num; i++) {
      if (r1.isHit(mob[i])==true && mob[i].visible==true) {
        mob[i].speedX=0;
        mob[i].speedY=0;
        mob[i].visible=false;
        count1++;
      }
    }

    if (mousePressed) {
      r1=new Rope(mouseX, mouseY);
    }
    
    textAlign(LEFT, TOP);
    textSize(50);
    text("Point:"+count1+"/"+num+" "+t.tLim(), 0, 0);
    
    if (count1>=num) {
      state=3;
      t.start();
    }
    
    if(t.getElapsedTime()>timeLimit){
      state=2;
      t.start();
    }
    break;
    
  case 2:
    background(0);
    textAlign(CENTER, CENTER);
    text("Game Over", width/2, height/2);
    if (mousePressed) {
      if(t.getElapsedTime()>2000){
        state=0;
        t.start();
      }
    }
    break;
  case 3:
    background(0);
    textAlign(CENTER, CENTER);
    text("Success!", width/2, height/2);
    if (mousePressed) {
      if(t.getElapsedTime()>2000){
        state=0;
        t.start();
      }
    }
    break;
    
  default:
  }
}

