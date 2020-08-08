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
