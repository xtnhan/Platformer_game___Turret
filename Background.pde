class BG1 {
  float x;


  BG1 (float xx) {
    x =xx;
  }

  void draw() {

    imageMode(CORNER);
    image(bg, x, 0);
  }

  void move (float dx, float dy) {
    x = x + dx;
  }
}
