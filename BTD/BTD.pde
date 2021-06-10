//Balloon Tower Defense
import java.util.Arrays;
     
//title screen 
     
int[][] background = pumpkinPatch();

int colPatch = 16;
int rowPatch = 15;
int bank = 1000; 
int income = 100; 
int ticks = 0;
int lives = 150;
int level = 1;
int round = 0;

ArrayList<Tower> towers = new ArrayList<Tower>();
ArrayList<Balloon> balloons = new ArrayList<Balloon>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>(); 

boolean hasStarted = false;
boolean draggingTower = false;
boolean selectingTower = false;

Tower curTower, selectedTower;
Timer time;
Button start = new Button("Start", 600, 375, 100, 50);
PImage dmonkey, smonkey, btower;

void setup(){
  size(1200,750);
  //setBackground(); 
  start.display();
  time = new Timer(0);
  dmonkey = loadImage("DartMonkey.png");
  smonkey = loadImage("SniperMonkey.png");
  btower = loadImage("BombTower.png");
}

void draw(){
 
  if (hasStarted){ 
    noStroke();
    //time = millis() * 1000;
    //print(time + "\n");
    setBackground();
    //if (lives == 50){
    //  print(time.getTime() + "\n"); 
    //}
    
    Tower dartMonkey = new Tower(18, 6);
    dartMonkey.display();
    
    Tower sniperMonkey = new Sniper(20, 6);
    sniperMonkey.display();
    
    Tower bombTower = new BombTower(22, 6);
    bombTower.display();
    
    spawnBalloon();
    moveBalloons();
    moveBullets();
    detectBalloon();
    reloadTowers();
    
    for (Tower t : towers) {
      t.display();
    }
    
    dragTower();
    selectTower();
    lifeBar();
    displayStats();
    displayTowerStats();
    
    if (time.getTime() <= 0){
       //Display win message 
    }
    
    time.countUp();
    
    if (ticks <= 0 && balloons.size()==0){
      round++;
      setTicks();
    }
    ticks--;
  }
}

void spawnBalloon() {
  if (ticks >= 0) {
    
    if (round == 1) {
      if (ticks < 200) {
        if(ticks % 10 == 0) makeBalloon(1);
      }
    }
    
    else if (round == 2) {
      if (ticks < 350) {
        if(ticks % 10 == 0) makeBalloon(1);
      }
    }
    
    else if (round == 3) {
      if (ticks < 300){
        if(ticks >= 250) {
          if(ticks % 10 == 0) makeBalloon(2);
        } else {
          if (ticks % 10 == 0) makeBalloon(1);
        }
      }
    }
    
    else if (round == 4) {
      if (ticks < 530){ 
        if(ticks > 180) {
          if(ticks % 10 == 0) makeBalloon(2);
        } else {
          if (ticks % 10 == 0) makeBalloon(1);
        }
      }
    }
    
    else if (round == 5) {
      if (ticks < 320){ 
        if(ticks > 270) {
          if(ticks % 10 == 0) makeBalloon(2);
        } else {
          if (ticks % 10 == 0) makeBalloon(1);
        }
      }
    }
    
    else if (round == 6) {
      if (ticks < 340){
       if(ticks < 150) {
         if(ticks % 10 == 0) makeBalloon(2);
        } else if (ticks < 190) {
          if (ticks % 10 == 0) makeBalloon(3);
        }
        else {
          if (ticks % 10 == 0) makeBalloon(1);
        }
      }
    }
  
  }
  
  //if (round == 1) {
  //  for (int i = 199; i >= 0; i-=100){
  //    if ( (i/100 % 2 == 0) && ticks >= i && ticks <= i + 100){
  //      if(ticks % 10 == 0) makeBalloon(3);
  //    }
  //  }
  //}
  
}

void setTicks(){
  if (round == 1) {
    ticks = 200;
  }
  else if (round == 2){
    ticks = 350;
  }
  else if (round == 3){
    ticks = 300;
  }
  else if (round == 4){
    ticks = 530;
  }
  else if (round == 5){
    ticks = 320;
  }
  else if (round == 6){
    ticks = 340;
  }
  ticks += 200;
  if (round > 1) bank += income;
}

/*
round 1 = 20 red
round 2 = 35 red
round 3 = 25 red, 5 blue
round 4 = 35 red, 18 blue
round 5 = 5 red, 27 blue 
round 6 = 15 red, 4 green, 15 blue 
round 7 = 
round 8 =
round 9 = 
round 10 = 
*/

void displayTowerStats() {
  if (selectingTower) {
    stroke(0);
    fill(255);
    rect(850, 400, 300, 300);
    
    fill(0);
    textSize(20);
    textAlign(CENTER);
    text(selectedTower.name, 1000, 425);
    textSize(12);
    text("Level: " + selectedTower.level, 1000, 450);
    
    imageMode(CENTER);
    if (selectedTower.name.equals("Dart Monkey")) {
      dmonkey.resize(0, 125);
      image(dmonkey, 1000, 525);
    }
    else if (selectedTower.name.equals("Sniper Monkey")) {
      smonkey.resize(0, 125);
      image(smonkey, 1000, 525);
    }
    else if (selectedTower.name.equals("Bomb Tower")) {
      btower.resize(0, 125);
      image(btower, 1000, 525);
    }
    
    Button upgradeTower = new Button("Upgrade", 1075, 645, 100, 50);
    upgradeTower.display();
    textAlign(CORNER);
   
    text("Cost: " + selectedTower.cost, 875, 625);
    text("Damage: " + selectedTower.damage, 875, 645);
    text("Range: " + selectedTower.range, 875, 665);
    text("Reload: " + (double) (int) ((selectedTower.speed) * 10 + 0.5) / 10, 875, 685);
  }
}

void displayStats(){
  textSize(32);
  textAlign(CENTER);
  text("Round: " + round, 1000, 50);
  textSize(20);
  text("Bank: " + bank, 1000, 100); 
  text("Income: " + income, 1000, 125); 
  text("Time Elapsed: " + (int) time.getTime(), 1000, 150);
  textAlign(LEFT);
}

void setBackground() {
  background(200);
  /* Creates 15 x 16 (grid) */
  for(int i = 0; i < rowPatch; i++){
    for(int j = 0; j < colPatch; j++){
      if (background[i][j]==1){
        fill(215,140,65);
        rect(j*50,i*50,50,50);
      }
      else{
        fill(170,80,40);
        rect(j*50,i*50,50,50);
      }
    }
  }
}

void mousePressed(){
  if (!hasStarted) {
    if (start.mouseIsOver()){
      hasStarted = true; 
    }
  }
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
          Bullet b;
          if (t.name.equals("Dart Monkey")) {   
            b = new Bullet(t.damage, t.bulletVelocity, t.range, t.x, t.y, direction); 
          } else if (t.name.equals("Bomb Tower")) {
            b = new Bomb(t.damage, t.bulletVelocity, t.range, t.x, t.y, direction, t.splashRadius);
          } else {
            b = new Bullet(t.damage, t.bulletVelocity, t.range, t.x, t.y, direction); 
          }
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
    int j = 0;
    while (!b.hitBalloon && j < balloons.size()) {
      Balloon balloon = balloons.get(j);
      if (dist(b.curX, b.curY, balloon.curX, balloon.curY) <= 25) {
        if (b.name.equals("bomb")) {
          for (int k = balloons.size() - 1; k >= 0; k--) {
            Balloon surroundingBalloon = balloons.get(k);
            if (dist(b.curX, b.curY, surroundingBalloon.curX, surroundingBalloon.curY) <= b.splashRadius) {
              int initial = balloon.health;
              surroundingBalloon.decreaseHealth(b.damage);
              if (surroundingBalloon.health <= 0) {
                income += initial;
                balloons.remove(k);
              }
              else {
                income += b.damage;
              }
            }
          }
        }
        else {
          int initial = balloon.health;
          balloon.decreaseHealth(b.damage);
          if (balloon.health <= 0) {
            income += initial;
            balloons.remove(j);
          }
          else {
            income += b.damage;
          }
        }
        b.hitBalloon = true;
        bullets.remove(i);
        
      }
      j++;
    }
    
    if (bullets.size() > 0 && b.range <= 0){
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

void selectTower() {
  if (!selectingTower) {
    for (Tower t : towers) {
      //if user clicks on a tower
      if (dist(t.x, t.y, mouseX, mouseY) < 25) {
        if (mousePressed) {
          selectingTower = true;
          selectedTower = t;
        }
      }
    }
  }
  else {
    fill(255, 255, 255, 50);
    ellipse(selectedTower.x, selectedTower.y, selectedTower.range * 2, selectedTower.range * 2);
    if (mousePressed && mouseX < 800 && ! (dist(selectedTower.x, selectedTower.y, mouseX, mouseY) < 25)) {
      selectingTower = false;
    }
  }
}

void dragTower() {
  if (draggingTower) {
     if (mousePressed && (mouseButton == LEFT)) {
       //currently dragging tower
       selectingTower = true;
       selectedTower = curTower;
       curTower.drag();
       curTower.display();
       //Range
       if (isLegalTowerPlacement()) {
         fill(255, 255, 255, 50);
       } else {
         fill(255, 0, 0, 50);
       }

       ellipse(curTower.x, curTower.y,curTower.range * 2, curTower.range * 2); 
     } else {
       //you let go of tower
       draggingTower = false;
       selectingTower = false;
       //if legal tower placement
       if (isLegalTowerPlacement()) {
         //System.out.println("legal tower placement");
         towers.add(curTower);
         bank -= curTower.cost;
         income -= (int) (curTower.cost * 0.07);
       }
       curTower = null;
       selectedTower = null;
       //System.out.println(locatePatch()[0] + " " + locatePatch()[1]);
     }
   }
   else if (!selectingTower) {
     if (dist(900, 300, mouseX, mouseY) < 25) {
        //System.out.println("tower not selected");
        if (mousePressed) {
          Tower newDartMonkey = new Tower(18, 6);
          curTower = newDartMonkey;
          draggingTower = true;
        }
     }
     else if (dist(1000, 300, mouseX, mouseY) < 25) {
        //System.out.println("tower not selected");
        if (mousePressed) {
          Sniper newSniperMonkey = new Sniper(20, 6);
          curTower = newSniperMonkey;
          draggingTower = true;
        }
     }
     else if (dist(1100, 300, mouseX, mouseY) < 25) {
        //System.out.println("tower not selected");
        if (mousePressed) {
          BombTower newBombTower = new BombTower(22, 6);
          curTower = newBombTower;
          draggingTower = true;
        }
     }
   }

}

void makeBalloon(int h){
  Balloon bloon = new Balloon(h, 15.5, 1.5);
  balloons.add(bloon);  
}

void moveBalloons(){
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

void keyPressed(){
  if (key == 32){
    makeBalloon(2);
  }
}

int[] locatePatch() {
  return new int[] { (int) mouseX / 50, (int) mouseY / 50 };
}

double[] locatePatch(int x, int y) {
  return new double[] { x / 50, y / 50};
}

boolean isLegalTowerPlacement() {
  if (mouseX > 775 || mouseX < 25 || mouseY < 25 || mouseY > 725 || bank < curTower.cost) {
    return false;
  }
  double[] patch;
  int value;
  
  //check if overlaps with path
  try {
    patch = locatePatch(mouseX + 25, mouseY);
    value = background[(int) patch[1]][(int) patch[0]];
    if (value == 1) {
      return false;
    }
    patch = locatePatch(mouseX - 25, mouseY);
    value = background[(int) patch[1]][(int) patch[0]];
    if (value == 1) {
      return false;
    }
    patch = locatePatch(mouseX, mouseY + 25);
    value = background[(int) patch[1]][(int) patch[0]];
    if (value == 1 ) {
      return false;
    }
    patch = locatePatch(mouseX, mouseY - 25);
    value = background[(int) patch[1]][(int) patch[0]];
    if (value == 1) {
      return false;
    }
  
    //check if overlaps with other towers
    for (Tower t : towers) {
      patch = locatePatch(mouseX + 25, mouseY);
      if (Arrays.equals(patch, locatePatch(t.x + 25, t.y))) {
        return false;
      }
      patch = locatePatch(mouseX - 25, mouseY);
      if (Arrays.equals(patch, locatePatch(t.x -  25, t.y))) {
        return false;
      }
      patch = locatePatch(mouseX, mouseY + 25);
      if (Arrays.equals(patch, locatePatch(t.x, t.y + 25))) {
        return false;
      }
      patch = locatePatch(mouseX, mouseY - 25);
      if (Arrays.equals(patch, locatePatch(t.x, t.y - 25))) {
        return false;
      }
    }
  }
  catch (ArrayIndexOutOfBoundsException e){
    print("hi");
    return false;
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
