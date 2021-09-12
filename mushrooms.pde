class Mushroom {
  float x;
  float y;

  float r;
  float healthbar;

  boolean isHit;
  boolean isTaken;


  Mushroom (float xx, float yy) {
    x =xx;
    y = yy;
    r = 20;
    isHit = false;
    isTaken = false;

    healthbar = 40;
  }

  void draw() {


    imageMode(CENTER);
    image(mushroom, x, y);
    noFill();
    //circle(x, y, 50);

    for (Bullet b : bullets) {
      if (dist(b.position.x, b.position.y, x, y) < r) {
        isHit = true;
        healthbar -= 2;
        b.position.x = 99999;  //Hide bullet when hitting target
      }
    }




    if (isHit) {
      //healthbar
      rectMode(CORNER);
      fill(201, 0, 0);
      rect(x - r, y - r*1.5, 40, 5);
      fill(46, 201, 0);
      rect(x - r, y - r*1.5, healthbar, 5);
      rectMode(CENTER);
    }

    if (healthbar <=0 && y < height) {
      isTaken = true;
      healthbar = 0;
      y = 99999999;  //Hide objects when being killed
    } else {
      isTaken = false;
    }

    if (isTaken) {
      material += 30;
      ammo += 40;
      p.healthbar += 2;
    }
  }

  void move (float dx, float dy) {
    x = x + dx;
  }
}
