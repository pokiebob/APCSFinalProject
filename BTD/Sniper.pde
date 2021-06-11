public class Sniper extends Tower {
  
  Sniper(int x, int y) {
    super(x, y);
    cost = 300;
    damage = 3;
    range = 9999;
    speed = 2.0;
    timer = speed;
    bulletVelocity = 50;
    c = color(0, 100, 0);
    name = "Sniper Monkey";
    upgradeCost = 150;
  }
  
  void upgrade(){
    if (level == 1) {
      level = 2;
      speed -= 0.3;
      damage = 5;
      upgradeCost = 300;
    }
    else if (level == 2) {
      level = 3;
      speed -= 0.3;
      damage = 7;
      upgradeCost = 400;
    }
    else if (level == 3) {
      level = 4;
      speed -= 0.3;
      damage = 9;
      sharpness = 2;
    }
  }
}
