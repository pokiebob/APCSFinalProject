public class Bullet {
  
  int damage;
  int speed;
  int range;
  int curX;
  int curY;
  int direction;
  
  Bullet(int damage, int speed, int range, int curX, int curY, int direction){
    this.damage = damage;
    this.speed = speed;
    this.range = range;
    this.curX = curX;
    this.curY = curY;
    this.direction = direction;
  }
  
  void display(){
    fill(0,0,255);
    rectMode(CENTER);
    pushMatrix();
    translate(curX, curY);
    rotate(radians(direction));
    rect(0, 0, 10, 20);
    popMatrix();
    rectMode(CORNER);
  }
  
  void move(){
    curY -= sin(radians(direction)) * speed;
    curX += cos(radians(direction)) * speed;
    range -= speed;
    //print(curY);
  }
 
  //hitsBalloon();
  
}
