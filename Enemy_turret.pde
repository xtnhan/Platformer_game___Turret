class TargetTurret {
  PVector position;
  PVector gun;

  float s;
  float timer;

  float healthbar = 1;



  TargetTurret () {
    position = new PVector(width/2, height/2);
    gun = new PVector (0, 0);
  }


  TargetTurret (float xx, float yy) {

    position = new PVector(xx, yy);
    gun = new PVector (0, 0);
    timer = 0;

    s =30;
  }

  void draw () {
    for (EnemyBullet ebul : ebullets) {

      ebul.draw ();
      ebul.update();

      ebul.interaction();
    }

    fill(150, 0, 0);
    circle(position.x, position.y, s);

    strokeWeight(15);
    line(position.x, position.y, position.x + gun.x, position.y + gun.y);
    strokeWeight(1);



    //Turret healthbar
    rectMode(CORNER);
    fill(201, 0, 0);

    rect(position.x - 50, position.y - 50, 100, 10);
    fill(46, 201, 0);

    rect(position.x - 50, position.y - 50, healthbar, 10);

    rectMode(CENTER);
  }


  void update() {


    if (healthbar <=0) {
      healthbar =0;
      position.y += 5;
    }
  }




  void pointAtPlayer() {
    if (p.isAlive) {
      gun = new PVector (p.x - position.x, p.y - position.y);
      gun.normalize().mult(50);
    }
  }


  void move (float dx, float dy) {
    position.x = position.x + dx;
    position.y = position.y + dy;
  }

  void shoot () {


    gun = new PVector (p.x - position.x, p.y - position.y + random(-50, 50));
    gun.normalize().mult(3);

    ebullets.add(new EnemyBullet (position.copy(), gun)); //Vector - change Vector by changing mouseX, mouseY -- .DIV(NUMBER) - Divide method of PVector class
  }


  boolean PlayerDetected() {
    if (p.isAlive && p.x >= position.x - 1200 && p.x <= position.x + 1200) {
      pointAtPlayer();

      timer += 1;

      if (timer >= 60) {
        shoot ();


        if (healthbar <= 30) {
          if (timer >= 100) {
            resetTimer ();
          }
        } else {
          if (timer >= 70) {
            resetTimer ();
          }
        }
      }
      return true;
    }
    return false;
  }

  void resetTimer () {

    timer = random(-20, 0);
  }
}
