Orbis sun, venus, earth, moon, lmoon;

void setup() {
  size(1000, 1000);
  sun = new Orbis(new Color(255,255,0), 500, 500, 200);
  venus = new Orbis(sun, new Color(255,125,0), 40, 0.005, 150);
  earth = new Orbis(sun, new Color(0,0,255), 50, 0.01, 300);
  moon = new Orbis(earth, new Color(125,125,125), 20, 0.03, 75);
  lmoon = new Orbis(moon, new Color(255,255,255), 10, 0.1, 25);
  frameRate(60);
}

void draw() {
  clear();
  sun.iterate();
}

class Color {
  int r, g, b;
  Color(int r,int g,int b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
}

class Orbis {
  float x, y, speed, distance, size, degree;
  ArrayList<Orbis> children;
  Color c;
  
  Orbis(Color c, float x, float y, float size) {
    children = new ArrayList<Orbis>();
    this.c = c;
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  Orbis(Orbis parent, Color c, float size, float speed, float distance) {
    children = new ArrayList<Orbis>();
    this.c = c;
    this.speed = speed;
    this.distance = distance;
    this.size = size;
    parent.children.add(this);
  }
  
  void iterate() {
    for (Orbis o : children) {
      o.degree = o.degree + o.speed;
      o.x = cos(o.degree) * o.distance + x;
      o.y = sin(o.degree) * o.distance + y;
      o.iterate();
    }
    draw();
  }
  
  void draw() {
    fill(c.r, c.g, c.b);
    circle(x, y, size);
  }
}
