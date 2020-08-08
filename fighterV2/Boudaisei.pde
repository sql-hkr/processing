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
