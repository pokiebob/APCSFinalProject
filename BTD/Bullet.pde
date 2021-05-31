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
    rect(curX, curY, 10, 20);
    rectMode(CORNER);
  }
  
  void move(){
    curY += speed;
    //print(curY);
  }
 
  //hitsBalloon();
  
}
