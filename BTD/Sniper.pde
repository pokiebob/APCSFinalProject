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
  }
  
}
