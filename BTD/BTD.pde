//Balloon Tower Defense
import java.util.Arrays;
     
int colPatch = 16;
int rowPatch = 15;
ArrayList<Tower> towers = new ArrayList<Tower>();
ArrayList<Balloon> balloons = new ArrayList<Balloon>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>(); 
int[][] background = pumpkinPatch();
int ticks = 0;
int lives = 150;

boolean towerSelected = false;
Tower curTower;

void setup(){
  size(1200,750);
  setBackground(); 
}

void setBackground() {
  background(200);
  /* Creates 15 x 16 (grid) */
  for(int i = 0; i < rowPatch; i++){
    for(int j = 0; j < colPatch; j++){
      if (background[i][j]==1){
        fill(255);
        rect(j*50,i*50,50,50);
      }
      else{
        fill(0);
        rect(j*50,i*50,50,50);
      }
    }
  }
}

void draw(){

  setBackground();
  lifeBar();
  Tower dartMonkey = new Tower(20, 4);
  dartMonkey.display();
  
  
  spawnBalloon();
  moveBalloons();
  moveBullets();
  detectBalloon();
  reloadTowers();
  
  for (Tower t : towers) {
    t.display();
  }
  
  dragTower();
  
  ticks++;
 
}

void reloadTowers() {
  for (Tower t : towers) {
    if (! t.canShoot) {
      if (t.timer <= 0) {
        t.canShoot = true;
        t.timer = t.speed;
      }
      t.timer -= 1.0 / 60;
    }
  }
}

void detectBalloon() {
  for (Tower t : towers) {
    int i = 0;
    while (t.canShoot && i < balloons.size()) {
      Balloon balloon = balloons.get(i);
        if (isInRange(balloon, t)) {
          //int direction = (t.y - balloon.curY) / (t.x - balloon.curX) * 360;
          int direction = 180 - (int) degrees(atan2((float) (t.y - balloon.curY), (float) (t.x - balloon.curX)));
          Bullet b = new Bullet(t.damage, 5, t.range, t.x, t.y, direction); 
          b.display();
          bullets.add(b);
          t.canShoot = false;
      }
      i++;
    }
  }
}

boolean isInRange(Balloon b, Tower t) {
  return (dist(b.curX, b.curY, t.x, t.y) <= t.range);
}

void moveBullets(){
  for (int i = 0; i < bullets.size(); i++){
    Bullet b = bullets.get(i);
    if (b.range <= 0){
      bullets.remove(i); 
    }
    else {
      b.display();
      b.move();
    }
    
  }
}

void lifeBar() {
  fill(255, 0, 0);
  rect(0, 0, 800, 25);
  fill(0,255,0);
  rect(0, 0, lives * 16 / 3, 25);
  
  fill(0);
  textSize(20);
  text("" + lives, 12.5, 20);
}

void spawnBalloon() {
  if (ticks <= 100) {
     if (ticks % 10 == 0) {
       makeBalloon();
     }
  }
  if (ticks >= 200 && ticks <= 300) {
    if (ticks % 10 == 0) {
      makeBalloon();
    }
  }
  
}

void dragTower() {
  if (towerSelected) {
     //System.out.println("towerSelected");
     if (mousePressed) {
       //System.out.print(" and mouse pressed \n");
       cursor(HAND);
       curTower.drag();
       curTower.display();
       //Range
       fill(255, 255, 255, 50);
       ellipse(curTower.x, curTower.y,curTower.range * 2, curTower.range * 2); 
     } else {
       cursor(ARROW);
       towerSelected = false;
       
       //if legal tower placement
       if (isLegalTowerPlacement()) {
         //System.out.println("legal tower placement");
         towers.add(curTower);
       }
       //System.out.println(locatePatch()[0] + " " + locatePatch()[1]);
     }
   }
   else if (dist(1000, 200, mouseX, mouseY) < 25) {
      //System.out.println("tower not selected");
      cursor(HAND);
      if (mousePressed) {
        Tower newDartMonkey = new Tower(20, 4);
        curTower = newDartMonkey;
        towerSelected = true;
      } else {
        strokeWeight(5);
      }
   } else {
     //System.out.println("tower not in range");
     cursor(ARROW);
     noStroke();
   } 
}

void makeBalloon(){
  Balloon bloon = new Balloon(1, 15.5, 1.5);
  balloons.add(bloon);  
}

void moveBalloons(){
  //
  for (int i = 0; i < balloons.size(); i++) {   
    Balloon b = balloons.get(i);
     b.display();
     //double[] patch = locatePatch(b.curX, b.curY);
     
     if(b.curX <= 75){
       if (b.curY < 275 || (b.curY >= 475 && b.curY < 675)) {
         //Move down (first move down)
         b.move(0,1);
       }
       else {
         //Move right
         b.move(1,0);
       }
     }
     else if (b.curY == 75 || b.curY == 475){
       //Moves left
       b.move(-1, 0);
     }
     else if (b.curX == 725 && b.curY < 525){
       //Move down (right side move down)
       b.move(0, 1);
     }
     else {
       //Move right (last row)
       //print(b.curX + "," + b.curY);
       b.move(1, 0);
     }
     
     if (b.curX >= 800 && b.curY >= 600) {
       lives -= b.health;
       balloons.remove(i);
     }
     
  }
  
}

//Bullets!
void keyPressed(){
  if (key == 32){
    //towers.clear(); 
    for (Tower t: towers){
      Bullet b = new Bullet(t.damage, 5, t.range, t.x, t.y, 135); 
      b.display();
      bullets.add(b);
    }
  }
}

int[] locatePatch() {
  return new int[] { (int) mouseX / 50, (int) mouseY / 50 };
}

double[] locatePatch(int x, int y) {
  return new double[] { x / 50, y / 50};
}

boolean isLegalTowerPlacement() {
  if (mouseX > 800) {
    return false;
  }
  double[] patch;
  int value;
  for (Tower t : towers) {
    patch = locatePatch(mouseX + 25, mouseY);
    value = background[(int) patch[1]][(int) patch[0]];
    if (value == 1 || Arrays.equals(patch, locatePatch(t.x + 25, t.y))) {
      return false;
    }
    patch = locatePatch(mouseX - 25, mouseY);
    value = background[(int) patch[1]][(int) patch[0]];
    if (value == 1 || Arrays.equals(patch, locatePatch(t.x -  25, t.y))) {
      return false;
    }
    patch = locatePatch(mouseX, mouseY + 25);
    value = background[(int) patch[1]][(int) patch[0]];
    if (value == 1 || Arrays.equals(patch, locatePatch(t.x, t.y + 25))) {
      return false;
    }
    patch = locatePatch(mouseX, mouseY - 25);
    value = background[(int) patch[1]][(int) patch[0]];
    if (value == 1 || Arrays.equals(patch, locatePatch(t.x, t.y - 25))) {
      return false;
    }
  }
  return true;
}

int[][] pumpkinPatch(){
    return new int[][] { 
     {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
     {0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}, 
     {0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, 
     {0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, 
     {0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, 
     {0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0},  
     {0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0}, 
     {0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0}, 
     {0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0}, 
     {0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0}, 
     {0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
     {0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, 
     {0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
     {0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
     {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}};
}
