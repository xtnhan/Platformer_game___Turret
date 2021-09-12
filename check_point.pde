class checkPoint {
  float x;
  float y;

  checkPoint (float xx, float yy) {
    x = xx;
    y = yy;
  }

  void draw () {
    fill(255, 255, 255);
    circle(x, y, 10);
  }
  void move (float dx, float dy) {
    x = x + dx;
    y = y + dy;
  }
}

class loadBGTrigger {
  float x;
  float y;
  float r;
  float g;
  float b;

  loadBGTrigger (float xx, float yy, float rr, float gg, float bb) {
    x = xx;
    y = yy;
    r = rr;
    g = gg;
    b = bb;
  }

  void draw () {
    fill(r, g, b);
    circle(x, y, 10);
  }

  void move (float dx, float dy) {
    x = x + dx;
    y = y + dy;
  }
}
