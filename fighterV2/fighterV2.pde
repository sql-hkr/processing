Timer t;
Rope r1;
Akawan kimura;
Boudaisei []mob;
int num=50;
int count1;
int state=0;
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
      state=1;
      count1=0;
      for (int i=0; i<num; i++) {
        mob[i]=new Boudaisei((int)random(0, 400), (int)random(0, 400), (int)random(-5, 5), (int)random(-5, 5));
        mob[i].visible=true;
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
    text("Point:"+count1, 0, 0);
    
    if (count1>=num) {
      state=3;
      t.start();
    }
    
    if(t.getElapsedTime()>20000){
      state=2;
      t.start();
    }
    break;
    
  case 2:
    background(0);
    textAlign(CENTER, CENTER);
    text("Game Over", width/2, height/2);
    if (mousePressed) {
      state=0;
      t.start();
    }
    break;
  case 3:
    background(0);
    textAlign(CENTER, CENTER);
    text("Success!", width/2, height/2);
    if (mousePressed) {
      state=0;
      t.start();
    }
    break;
    
  default:
  }
}

