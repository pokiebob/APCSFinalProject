public class Bullet {
  
  int damage;
  int speed;
  int range;
  int curX;
  int curY;
  int direction;
  int splashRadius;
  int sharpness;
  boolean hitBalloon;
  String name;
  
  Bullet(int damage, int speed, int range, int curX, int curY, int direction, int sharpness){
    this.damage = damage;
    this.speed = speed;
    this.range = range;
    this.curX = curX;
    this.curY = curY;
    this.direction = direction;
    this.splashRadius = 1;
    this.sharpness = sharpness;
    hitBalloon = false;
    name = "dart";
  }
  
  void display(){
    //fill(0,0,255);
    //rectMode(CENTER);
    //pushMatrix();
    //translate(curX, curY);
    //rotate(radians(direction));
    //rect(0, 0, 10, 20);
    //popMatrix();
    //rectMode(CORNER);
    fill(0, 0, 255);
    ellipse(curX, curY, 15, 15);
  }
  
  void move(){
    curY -= sin(radians(direction)) * speed;
    curX += cos(radians(direction)) * speed;
    range -= speed;
    //print(curY);
  }
 
  //hitsBalloon();
  
}
