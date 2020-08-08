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
        }
        else {
            elapsed = (stopTime - startTime);
        }
        return elapsed;
    }
    int millisecond(){
      return getElapsedTime()%1000;
    }
      
    int second(){
      return (getElapsedTime() / 1000) % 60;
    }
    int millisecond(int ct){
      return ct%1000;
    }
      
    int second(int ct){
      return ct/1000;
    }
    String tLim(){
      int x = 30000-getElapsedTime();
      return Integer.toString(second(x))+"."+Integer.toString(millisecond(x)/10);
    }
}

class Boudaisei {
  int x;
  int y;
  int speedX;
  int speedY;

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
      image(gakuseiImage, x-25, y-25, 50, 50);
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

  void move() {
    x=x+speedX;
    y=y+speedY;
    if (x<0)speedX=speedX*-1;
    if (y<0)speedY=speedY*-1;
    if (x>750)speedX=speedX*-1;
    if (y>750)speedY=speedY*-1;
  }

  boolean isHit(Boudaisei tanin) {
    if ((this.x-25<tanin.x) && (this.x+25>tanin.x) && (this.y-25<tanin.y) && (this.y+25>tanin.y)) {
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
    image(gakuseiImage, mouseX-25, mouseY-25, 50, 50);
    stroke(255,0,0);
    line(x,0, x, y-25);
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
    stroke(0);
    fill(255,0,0);
    ellipse(x, y, 10, 20);
  }

  boolean isHit(Rope r1) {
    if ((this.x-25<r1.x) && (this.x+25>r1.x) && (this.y-25<r1.y) && (this.y+25>r1.y)) {
      return true;
    } else {
      return false;
    }
  }
}

class Cloud extends Boudaisei{
  Cloud(int ix, int iy) {
    super(ix, iy);
  }
  void output(){
    fill(255);
    stroke(255);
    ellipse(x, y, 126, 97);
    ellipse(x+62, y, 70, 60);
    ellipse(x-62, y, 70, 60);
  }
}

Timer t;
Rope r1;
Akawan kimura;
Boudaisei []mob;
Cloud []clouds;
int num=50;
void setup() {
  size(800, 800);
  r1=new Rope(400, 800);
  mob=new Boudaisei[num];
  clouds=new Cloud[10];
  kimura=new Akawan();
  t = new Timer();
  if(tReset) t.start();
}

int count1=0;
int state=1;
boolean tReset = true;
boolean objConfig = true;

void draw() {
  switch(state){
   case 1:
     if(objConfig){
       for (int i=0; i<num; i++) {
        mob[i]=new Boudaisei((int)random(0, 400), (int)random(0, 400), (int)random(1, 5), (int)random(1, 5));
        mob[i].visible=true;
      }
      for (int i=0; i<10; i++) {
        clouds[i]=new Cloud((int)random(-width,0),(int)random(0, height));
      }
     }
     objConfig = false;
     count1=0;
     tReset = true;
     background(0,120,215);
     fill(255);
     
     for (int i=0; i<10; i++) {
      clouds[i].move_right(1);
      clouds[i].output();
      if(clouds[i].x==width+100){
        clouds[i]=new Cloud((int)random(-200, -100),(int)random(0, height));
      }
    }
     
     textSize(50);
     textAlign(CENTER, CENTER);
     text("Press the space key", width/2, height/2);
     text("to start game", width/2, height/2+50);
     textSize(25);
     text("Let's attack enemies with the space key!", width/2, height/2+120);
     text("", width/2, height/2+100);
     if(keyPressed){
       if(key==' ' && t.getElapsedTime()>2000) state=2;
     }
     break;
  case 2:
    background(0,120,215);
    if(tReset) t.start();
    tReset = false;
    r1.move_up(30);
    r1.output();
    for (int i=0; i<num; i++) {
      mob[i].move();
      mob[i].output();
    }
    
    for (int i=0; i<num; i++) {
      if (r1.isHit(mob[i])==true && mob[i].visible==true) {
        mob[i].speedX=0;
        mob[i].speedY=0;
        mob[i].visible=false;
        stroke(255,0,0);
        fill(255,0,0);
        ellipse(mob[i].x, mob[i].y, 50, 50);
        count1++;
      }
    }
    for (int i=0; i<10; i++) {
      clouds[i].move_right(1);
      clouds[i].output();
      if(clouds[i].x==width+100){
        clouds[i]=new Cloud((int)random(-200, -100),(int)random(0, height));
      }
    }
    for (int i=0; i<num; i++) {
      if(mob[i].visible==true && mob[i].x<25+mouseX && mob[i].x>-25+mouseX){
        stroke(255,0,0);
        noFill();
        ellipse(mob[i].x, mob[i].y, 50, 50);
      }
    }
    kimura.outputMouse();
    r1.output();
    
    if (keyPressed) {
      if(key==' ' && r1.y<0) r1=new Rope(mouseX, mouseY);
    }
    textSize(50);
    if(t.getElapsedTime()<20000){
      fill(0,255,0);
    }else{
      fill(255,0,0);
    }
    textAlign(LEFT, TOP);
    textSize(40);
    text((num-count1)+" Enemies Left | Time limit:"+t.tLim(), 0, 0);
    if(t.getElapsedTime()>30000 || count1==50){
      state=3;
      t.start();
    }
    break;
  case 3:
     background(0,120,215);
     fill(255);
     textAlign(CENTER, CENTER);
     if(count1==50){
       textSize(100);
       text("Succeeded!", width/2, height/2);
       textSize(150);
       text(":)", width/4, height/3);
     }else{
       textSize(100);
       text("Failed!", width/2, height/2);
       textSize(150);
       text(":(", width/4, height/3);
     }
     textSize(50);
     text("End with space bar", width/2, height * 0.7);
     if(keyPressed){
       if(key==' ' && t.getElapsedTime()>2000){
         objConfig = true;
         state=1;
         t.start();
       }
     }
    break;
  default:
    
  }
}
