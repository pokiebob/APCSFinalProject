public class Balloon {
  
  int health;
  int curX, curY;
  double speed;
  color c;
  //ArrayList<int[]> visitedPatches = new ArrayList<int[]>();
  
  Balloon(int health, double curX, double curY){
    this.health = health;
    this.curX = (int) (curX * 50);
    this.curY = (int) (curY * 50);
  }
  
  void move(int x, int y){
    curX += x * speed;
    curY += y * speed;
  }
  
  //void patchVisited(int[] arr) {
  //  visitedPatches.add(arr);
  //}
  
  void decreaseHealth(int towerDamage){
     health -= towerDamage;
  }
  
  void display(){
    //Red
    if (health==1){
      c = color(255,0,0);
      speed = 1;
    }
    //Blue
    else if (health==2){
      c = color(0,0,255); 
      speed = 2;
    }
    //Green
    else if (health==3){
      c = color(0,255,0); 
      speed = 2;
    }
    //Yellow
    else if (health==4){
      c = color(255,255,0); 
      speed = 3;
    }
    //Pink
    else if (health==5){
      c = color(255,100,180); 
      speed = 5;
    }
    smooth();
    stroke(0);
    fill(c);
    ellipse(curX, curY, 30, 40);
    noStroke();
  }
  
}
