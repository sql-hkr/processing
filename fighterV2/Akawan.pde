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
