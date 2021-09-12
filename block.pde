


class Block {
  PVector position;
  PVector velocity;
  float healthbar = 50;

  float x;
  float y;
  float w;
  float h;
  boolean hitTop;
  boolean hitRight;
  boolean hitLeft;
  boolean hitBottom;

  boolean isDestroyed;

  boolean hasTurret = false;

  float dy;


  float animateY;
  Turret turr;

  Block (float xx, float yy, float ww, float hh, boolean hasTurrett) {
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    hitTop = false;
    hitRight =false;
    hitLeft = false;
    hitRight = false;
    isDestroyed = false;
    hasTurret = hasTurrett;
    turr = null;
  }

  void draw() {
    y += dy;
    if (turr!=null) {
      turr.draw();
    }

    imageMode(CENTER);
    image(bl, x, y);

    if (hasTurret  == false) {
      rectMode(CORNER);
      fill(201, 0, 0);

      rect(x + 30, y - 25, 5, 50);
      fill(46, 201, 0);

      rect(x + 30, y - 25, 5, healthbar);

      rectMode(CENTER);
    }
  }
  void update() {

    y += animateY;

    if (hitBottom && hasTurret) {
      turr = new Turret (100, 100);
      showTurret(turr);
    }

    if (healthbar <=0) {
      dy =1;
      dy+= gravity;
      healthbar = 0;
      isDestroyed = true;
    }
  }

  boolean interaction () { //Interact with player

    if (p.x + p.r >= x - w/2 && p.x - p.r <= x + w/2 && p.y + p.r >= y - h/2 && p.y - p.r <= y + h/2) {//HIT BLOCk

      if (p.isAlive && p.y - p.r <= y - h/2 - p.r) {//Hit Top
        //println("Hit top");
        hitTop = true;
        p.speedY=0;
        p.y = y - p.r - h/2;

        if (key == ' ' && keyPressed) {
          p.jumpUp();
        }
        return true;
      }

      if (isDestroyed == false && p.y + p.r >= y + h/2 + p.r) {// Hit Bottom
        //println("Hit Bottom");
        p.speedY =0;
        p.y = y + h/2 + p.r;
        y = y - 10;
        hitBottom = true;
        return true;
      }

      if (p.x + p.r >= x - w/2 && p.x + p.r <= x) {//Hit Left
        //println("Hit left");
        hitLeft = true;
        //p.x = x - w/2 - p.r/2;

        if (hasTurret ==false) {
          x += obspeedX;
        }

        return true;
      }

      if (p.x - p.r <= x + w/2 && p.x + p.r >= x) {//Hit Right
        //println("Hit right");
        //p.x = x + w/2 + p.r/2;
        hitRight = true;


        if (hasTurret ==false) {
          x -=obspeedX;
        }
        return true;
      }
    }

    hitTop = false;
    hitLeft = false;
    hitRight = false;

    return false;
  }



  void showTurret(Turret turr) { //Show Grun when player hits block - bottom
    if (turr != null) {
      turr.position.x = x;
      turr.position.y = y - turr.r - w/2 - 5;
    }
  }



  void move (float dx, float dy) {
    x = x + dx;
    y = y + dy;
  }
}
