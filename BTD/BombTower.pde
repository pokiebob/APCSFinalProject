public class BombTower extends Tower {
  
  BombTower(int x, int y) {
    super(x, y);
    cost = 750;
    damage = 1;
    range = 250;
    speed = 1.4;
    timer = speed;
    //bulletVelocity = 50;
    c = color(105);
    name = "Bomb Tower";
    splashRadius = 40;
  }
  
  void upgrade(){
    if (level == 1) {
      level = 2;
      range = 275;
      speed -= 0.1;
      damage = 2;
      splashRadius = 60;
      bulletVelocity = 20;
    }
    else if (level == 2) {
      level = 3;
      range = 300;
      speed -= 0.1;
      damage = 3;
      splashRadius = 80;
      bulletVelocity = 25; 
    }
    else if (level == 3) {
      level = 4;
      speed -= 0.2;
      damage = 5;
    }
  }
  
}
