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
    fill(218);
    stroke(141);
    rectMode(CENTER);
    rect(x, y, w, h, 10);
    rectMode(CORNER);
    textAlign(CENTER);
    fill(0);
    text(label, x, y);
  }
  
  boolean mouseIsOver() {
    if (mouseX > (x - w/2) && mouseX < (x + w/2) && mouseY > (y - h/2) && mouseY < (y + h/2)) {
      return true;
    }
    return false;
  }
}
