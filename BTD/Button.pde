public class Button {
  
  String label;
  float x;    // top left corner x position
  float y;    // top left corner y position
  float w;    // width of button
  float h;    // height of button
  
  Button(String labelB, float xpos, float ypos, float widthB, float heightB) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
  }
  
  void display() {
    stroke(255);
    rectMode(CENTER);
    strokeWeight(2);
    fill(30, 90, 23);
    rect(x, y, w - 5, h - 5, 10);
    fill(105,228,0);
    strokeWeight(1);
    noStroke();
    rect(x, y, w - 15, h - 15, 10);
    rectMode(CORNER);
    textAlign(CENTER);
    fill(0);
    textSize(h / 3);
    text(label, x, y + h/10);
    textSize(12);
  }
  
  boolean mouseIsOver() {
    if (mouseX > (x - w/2) && mouseX < (x + w/2) && mouseY > (y - h/2) && mouseY < (y + h/2)) {
      return true;
    }
    return false;
  }
}
