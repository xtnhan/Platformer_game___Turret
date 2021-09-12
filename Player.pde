class Player {
  Turret turr;

  float x;
  float y;
  float r;
  float speedX;
  float speedY;


  float timer = 0;

  float Offset =1;


  boolean isGround;
  boolean hasTurret;
  boolean isAlive;
  float healthbar = 100;

  Player (float xx, float yy) {
    x =xx;
    y = yy;
    r = 20;
    speedX = 1;
    isGround = false;
    hasTurret = false;
    turr = null;
    isAlive = true;
  }

  void draw() {
    fill(0, 0, 0);
    strokeWeight(1);
    circle(x, y, r);

    for (Bullet bul : bullets) {
      bul.interaction();

      bul.draw ();
      bul.update();
    }

    if (turr != null) {
      turr.draw();
    }

    //Healthbar
    rectMode(CORNER);
    fill(201, 0, 0);

    rect(x - 50, y - 50, 100, 10);
    fill(46, 201, 0);

    rect(x - 50, y - 50, healthbar, 10);

    rectMode(CENTER);

    if (healthbar > 100 ) {
      healthbar = 100;
    }
  }

  void update() {

    y += speedY;
    speedY += gravity;

    if (isAlive && y >= height - r - 100) {
      speedY = 0;
      y = height -r - 100;
      isGround = true;
    } else {
      isGround = false;
    }

    if (healthbar <=0) {
      healthbar = 0;
      isAlive = false;
    }

    for (Mushroom mr : mushrooms) {
      if (mr.isTaken) {
        healthbar += 2;
      }
    }
  }

  void updateTurret () {
    for (Block b : blocks) {
      if (b.turr != null && x >= b.x-b.w/2 && x <= b.x + b.w/2 && y <= b.y && y >= b.y - b.h ) {
        hasTurret = true;
      }

      if (hasTurret && b.hasTurret) {
        b.turr.position.x = 999999;

        turr = new Turret (x, y);
      }
    }
  }


  boolean checkWalls () {


    if (x >= width/3 + Offset) {
      x = width/3;
      c.move(-obspeedX, 0);
      triggerL.move(-obspeedX, 0);
      triggerR.move(-obspeedX, 0);

      //Background moving
      for (BG1 bgr1 : bgr1) {
        bgr1.move(-obspeedX, 0);
      }

      for (BG1 bgrL : bgrL) {
        bgrL.move(-obspeedX, 0);
      }
      for (BG1 bgrR : bgrR) {
        bgrR.move(-obspeedX, 0);
      }
      for (Mushroom mr : mushrooms) {
        mr.move(-obspeedX, 0);
      }

      for (Mushroom mrL : mushroomsL) {
        mrL.move(-obspeedX, 0);
      }
      for (Mushroom mrR : mushroomsR) {
        mrR.move(-obspeedX, 0);
      }

      //Blocks moving
      for (Block b : blocks) {
        b.move(-obspeedX, 0);
      }


      //Turrets moving
      for (TargetTurret tt : tt1) {

        tt.move(-obspeedX, 0);
      }
      //Turrets' bullets moving

      for (EnemyBullet ebul : ebullets) {
        ebul.move(-obspeedX, 0);
      }

      //      for (Bullet bul : bullets) {
      //        bul.move(-obspeedX, 0);
      //      }


      return true;
    }

    if (x <= width/3 - Offset) {
      x = width/3;
      triggerL.move(obspeedX, 0);
      triggerR.move(obspeedX, 0);

      c.move(obspeedX, 0);
      //Background moving
      for (BG1 bgr1 : bgr1) {
        bgr1.move(obspeedX, 0);
      }

      for (BG1 bgrL : bgrL) {
        bgrL.move(obspeedX, 0);
      }

      for (BG1 bgrR : bgrR) {
        bgrR.move(obspeedX, 0);
      }
      for (Mushroom mr : mushrooms) {
        mr.move(obspeedX, 0);
      }

      for (Mushroom mrL : mushroomsL) {
        mrL.move(obspeedX, 0);
      }
      for (Mushroom mrR : mushroomsR) {
        mrR.move(obspeedX, 0);
      }


      for (Block b : blocks) {

        b.move(obspeedX, 0);
      }
      //for (Bullet bul : bullets) {
      //  bul.move(obspeedX, 0);
      //}

      for (TargetTurret tt : tt1) {
        tt.move(obspeedX, 0);
      }

      for (EnemyBullet ebul : ebullets) {
        ebul.move(obspeedX, 0);
      }

      //for (Bullet bul : bullets) {
      //  bul.move(-obspeedX, 0);
      //}
      return true;
    }

    return false;
  }

  void moveLeft() {
    x -= speedX;
  }
  void moveRight() {
    x += speedX;
  }

  void jumpUp () {
    speedY -= 10d;
  }


  void shoot () {
    PVector speedY = new PVector (0, 0);
    PVector gun = new PVector (mouseX - p.x, mouseY - p.y+ random(-2, 2));
    gun.normalize().mult(17);
    bullets.add(new Bullet (turr.position.copy(), gun, speedY)); //Vector - change Vector by changing mouseX, mouseY -- .DIV(NUMBER) - Divide method of PVector class
  }
}
