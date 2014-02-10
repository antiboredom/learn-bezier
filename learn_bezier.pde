ArrayList<Bez> vs = new ArrayList<Bez>();
Dragg selected;
boolean dragging = false;

void setup() {
  size(600, 600);
  colorMode(HSB);
  vs.add(new Bez(10, 10, 50, 20, 10, 30));
  vs.add(new Bez(40, 40, 50, 50, 10, 80));
  vs.add(new Bez(70, 70, 80, 80, 180, 180));
  vs.add(new Bez(90, 90, 100, 100, 20, 180));
}


void draw() {
  background(255);
  stroke(0);
  beginShape();
  vertex(0, 0);
  for (int i = 0; i < vs.size(); i++) {
    vs.get(i).display();
  }
  endShape();
}


class Bez {
  Dragg points[] = new Dragg[3];

  Bez(float _x2, float _y2, float _x3, float _y3, float _x4, float _y4) {
    points[0] = new Dragg(_x2, _y2, "c1");
    points[1] = new Dragg(_x3, _y3, "c2");
    points[2] = new Dragg(_x4, _y4, "a");
    color c = color(random(255), 255, 255);
    for (int i = 0; i < 3; i ++) {
      points[i].c = c;
    }
  }

  void display() {
    bezierVertex(points[0].loc.x, points[0].loc.y, points[1].loc.x, points[1].loc.y, points[2].loc.x, points[2].loc.y);
    for (int i = 0; i < points.length; i++) {
      points[i].display();
    }
  }
}

class Dragg {
  PVector loc;
  float r;
  color c;
  String name;

  Dragg(float x, float y, String _name) {
    loc = new PVector(x, y);
    r = 8;
    c = color(255, 0, 0);
    name = _name;
  }

  void display() {
    fill(c);
    ellipse(loc.x, loc.y, r, r);
    fill(100);
    text(name, loc.x, loc.y + 12);
    noFill();
    
    if (!dragging && mousePressed && dist(loc.x, loc.y, mouseX, mouseY) < r) {
      selected = this;
    }
    
    if (selected == this) {
           textSize(10);
      fill(100);
      text("    (" + loc.x + ", " + loc.y + ")", loc.x, loc.y + 12);
      noFill();
      println("x: " + loc.x + ", y: " + loc.y); 
      
    }
  }
}

void mouseReleased() {
  selected = null;
  dragging = false;
}

void mouseDragged() {
  dragging = true;
  selected.loc.x = mouseX;
  selected.loc.y = mouseY;
}

