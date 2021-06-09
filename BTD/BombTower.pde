public class BombTower extends Tower {
  
  BombTower(int x, int y) {
    super(x, y);
    cost = 650;
    damage = 1;
    range = 250;
    speed = 0.63;
    timer = speed;
    //bulletVelocity = 50;
    c = color(105);
    name = "Bomb Tower";
  }
}
