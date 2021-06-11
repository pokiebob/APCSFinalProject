public class BombTower extends Tower {
  
  BombTower(int x, int y) {
    super(x, y);
    cost = 750;
    damage = 1;
    range = 200;
    speed = 1.4;
    timer = speed;
    upgradeCost = 400;
    //bulletVelocity = 50;
    c = color(105);
    name = "Bomb Tower";
    splashRadius = 40;
  }
  
  void upgrade(){
    if (level == 1) {
      level = 2;
      range = 225;
      splashRadius = 50;
      bulletVelocity = 20;
      upgradeCost = 600;
    }
    else if (level == 2) {
      level = 3;
      range = 250;
      damage = 2;
      splashRadius = 65;
      bulletVelocity = 25;
      upgradeCost = 800;
      
    }
    else if (level == 3) {
      level = 4;
      speed -= 0.3;
      damage = 3;
    }
  }
  
}
