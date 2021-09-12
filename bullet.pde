class Bullet {
  float s;
  float turretDamage;
  PVector position;
  PVector velocity;
  PVector speedY;


  boolean isOut;

  Bullet (PVector pos, PVector vel, PVector speedYY) {
    position = pos;
    velocity = vel;
    speedY = speedYY;

    s = 5;
    turretDamage = 0.3;
    isOut = false;
  }


  void draw () {
    fill(255, 255, 136);
    circle(position.x, position.y, s);
  }

  void update () {
    position.add(velocity);

    //Add gravity
    speedY.add(grav);
    position.add(speedY);


    if (position.y > height) {
      isOut = true;
    }
  }




  void interaction () {
    //Bounce back - left
    for (Block bl : blocks) {

      if (position.x + s >= bl.x - bl.w/2 && position.x - s <= bl.x + bl.w/2 && position.y + s >= bl.y - bl.h/2 && position.y - s <= bl.y + bl.h/2) {//HIT BLOCk


        if (position.y - s <= bl.y - bl.h/2 - s) {//Hit Top
          position.y = bl.y - s - bl.h/2;
          velocity.y = -velocity.y/1.5;
        }

        if (position.y + s >= bl.y + bl.h/2 + s) {//Hit Bottom
          position.y = bl.y + s + bl.h/2;
          velocity.y = -velocity.y/1.5;
        }

        if (position.x + s >= bl.x + bl.w/2 && position.y - s >= bl.y - bl.h/2 - s) {//Hit Right
          position.x = bl.x + bl.w/2 + s;
          velocity.x = -velocity.x/1.5;
        }

        if ( position.x - s <= bl.x - bl.w/2 && position.y - s >= bl.y - bl.h/2 - s) {//Hit Left
          position.x = bl.x - bl.w/2 - s;
          velocity.x = -velocity.x/1.5;
        }
      }
    }

    //Shoot Enemy
    for (TargetTurret tt : tt1) {
      if (dist(position.x, position.y, tt.position.x, tt.position.y)<=tt.s) {

        tt.healthbar -= turretDamage;

        position.x = 99999999; //Hide bullet when hitting target
      }
    }
  }
}
