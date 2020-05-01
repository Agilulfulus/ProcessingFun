ArrayList<Character> keys;
ArrayList<Mob> mobs;
float rot_Z_C, rot_Z_P, x, y, z, px, py;
int dir;
float speed = 2;
Person p;

void setup() {
  size(2000,1000,P3D);
  frameRate(60);
  keys = new ArrayList<Character>();
  mobs = new ArrayList<Mob>();
  mobs.add(new Mob(0, 450, -PI, 2, new int[] {0, 0, 255}));
  mobs.add(new Mob(450, 0, -PI / 2, 1, new int[] {255, 255, 0}));
  mobs.add(new Mob(-450, 0, -PI / 2, 1, new int[] {0, 255, 255}));
  px = 0;
  py = -450;  
  p = new Person();
  x = 1000;
  y = 500;
  z = 700;
  dir = 0;
}

void keyPressed() {
  if (!keys.contains(key))
    keys.add(key);
}
 
void keyReleased() {
  if (keys.contains('a')) {
    thread("turnLeft");
    rot_Z_P -= PI / 2;
    dir = (dir + 1) % 4;
    p.paths.add(new Path(px, py, rot_Z_P, dir, new int[] {255, 0, 0}));
  }
  if (keys.contains('d')) {
    thread("turnRight");
    rot_Z_P += PI / 2;
    dir = (4 + dir - 1) % 4;
    p.paths.add(new Path(px, py, rot_Z_P, dir, new int[] {255, 0, 0}));
  }
  keys.remove((Object)key);
}

void turnLeft() {
  for (int i = 0; i < 100; i++) {
    delay(1);
    rot_Z_C-=PI / (2 * 100);
  }
  rot_Z_C = rot_Z_P;
}

void turnRight() {
  for (int i = 0; i < 100; i++) {
    delay(1);
    rot_Z_C+=PI / (2 * 100);
  }
  rot_Z_C = rot_Z_P;
}

void draw() {  
  clear();
  translate(x, y + 50, z);
  rotateX(PI * -0.55);  
  rotateZ(rot_Z_C);
  p.draw();
  for (Mob m : mobs) {
    m.draw();
  }
  rectMode(CENTER);
  fill(51);
  stroke(255);
  translate(-px, -py, 0);
  rect(0,0,1000,1000);
  for (Mob m : mobs) {
    m.drawModel();
  }
  p.drawModel();
  
  p.update();
  for (Mob m : mobs) {
    m.update();
  }
}

class Person {
  ArrayList<Path> paths;
  
  Person() {
    paths = new ArrayList<Path>();
    paths.add(new Path(px, py, rot_Z_P, dir, new int[] {255, 0, 0}));
  }
  
  void draw() {
    rectMode(CORNER);  
    for (Path p : paths) {
      p.draw(px, py);
    }
  }
  
  void drawModel() {
    translate(px, py, 0);
    rotateY(PI / 2);
    rotateX(rot_Z_P);
    rect(5, 0, 10, 10);
    rotateX(-rot_Z_P);
    rotateY(-PI / 2);
    translate(-px, -py, 0);
  }
  
  void update() {
    switch (dir) {
      case 0:
        py+=speed;
        break;
      case 1:
        px-=speed;
        break;
      case 2:
        py-=speed;
        break;
      case 3:
        px+=speed;
        break;
    }
    paths.get(paths.size() - 1).full_len+=speed;
    paths.get(paths.size() - 1).len+=speed;
    paths.get(0).len-=speed/2;
    if (paths.get(0).len <= 0)
      paths.remove(0);
  }
}

class Mob {
  ArrayList<Path> paths;
  int dir;
  float mx, my, rot_Z_M;
  int[] c;
  
  Mob(float mx, float my, float rot_Z_M, int dir, int[] c) {
    this.mx = mx;
    this.my = my;
    this.c = c;
    paths = new ArrayList<Path>();
    paths.add(new Path(mx, my, rot_Z_M, dir, c));
    this.dir = dir;
    this.rot_Z_M = rot_Z_M;
  }
  
  void draw() {
    rectMode(CORNER);  
    for (Path p : paths) {
      p.draw(px, py);
    }
  }
  
  void drawModel() {
    translate(mx, my, 0);
    rotateY(PI / 2);
    rotateX(rot_Z_M);
    rect(5, 0, 10, 10);
    rotateX(-(rot_Z_M));
    rotateY(-PI / 2);
    translate(-mx, -my, 0);
  }
  
  int pathCol(Path path) {
    int wall_dir = -1;
        if (mx - path.x <= 5 && mx - path.x > 0 && my < path.y + path.full_len && my > path.y + (path.full_len - path.len) && path.dir == 0) {
          wall_dir = 1;
        }
        if (mx - path.x <= 5 && mx - path.x > 0 && my > path.y - path.len && my < path.y && path.dir == 2) {
          wall_dir = 1;
        }
        
        if (mx - path.x >= -5 && mx - path.x < 0 && my < path.y + path.full_len && my > path.y + (path.full_len - path.len) && path.dir == 0) {
          wall_dir = 3;
        }
        if (mx - path.x >= -5 && mx - path.x < 0 && my > path.y - path.len && my < path.y && path.dir == 2) {
          wall_dir = 3;
        }
        
        if (my - path.y <= 5 && my - path.y > 0 && mx < path.x + path.full_len && mx > path.x + (path.full_len - path.len) && path.dir == 3) {
          wall_dir = 2;
        }
        if (my - path.y <= 5 && my - path.y > 0 && mx > path.x - path.len && mx < path.x && path.dir == 1) {
          wall_dir = 2;
        }
        
        if (my - path.y >= -5 && my - path.y < 0 && mx < path.x + path.full_len && mx > path.x + (path.full_len - path.len) && path.dir == 3) {
          wall_dir = 0;
        }
        if (my - path.y >= -5 && my - path.y < 0 && mx > path.x - path.len && mx < path.x && path.dir == 1) {
          wall_dir = 0;
        }
       return wall_dir;
  }
  
  int collide(int dir) {
    float dist_to_coll = min(new float[]{abs(-500 - mx), 500 - mx, abs(-500 - my), 500 - my});
    int wall_dir = -1;
    if (dist_to_coll == abs(-500 - mx))
      wall_dir = 1;
    if (dist_to_coll == abs(-500 - my))
      wall_dir = 2;
    if (dist_to_coll == 500 - mx)
      wall_dir = 3;
    if (dist_to_coll == 500 - my)
      wall_dir = 0;
    if (dist_to_coll <= 20 && dir == wall_dir)
      return wall_dir;
    else {
      for (Path path : p.paths) {
        wall_dir = pathCol(path);
        
        if (wall_dir == dir) {
          return wall_dir;
        }
      }
      for (Mob m : mobs) { 
        for (Path path : m.paths) {
          wall_dir = pathCol(path);
          
          if (wall_dir == dir) {
            return wall_dir;
          }
        }
      }
    }
    return -1;
  }
  
  void update() {
    if (collide(dir) != -1 || (collide(dir) == -1 && random(100) < 1)) {
      int v = (int)random(-2, 1);
      if (v == 0)
        v++;
      int new_dir = (4 + dir - v) % 4;
      if (collide(new_dir) != -1)
        v *= -1;
      dir = (4 + dir - v) % 4;
      rot_Z_M += (PI / 2) * v;
      paths.add(new Path(mx, my, rot_Z_M, dir, c));
    }
    
    switch (dir) {
      case 0:
        my+=speed;
        break;
      case 1:
        mx-=speed;
        break;
      case 2:
        my-=speed;
        break;
      case 3:
        mx+=speed;
        break;
    }
    paths.get(paths.size() - 1).full_len+=speed;
    paths.get(paths.size() - 1).len+=speed;
    paths.get(0).len-= speed / 2;
    if (paths.get(0).len <= 0)
      paths.remove(0);
  }
}

class Path {
  float x, y, len, full_len, r;
  int[] c;
  int dir;
  
  Path(float x, float y, float r, int dir, int[] c) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.len = 0;
    this.full_len = 0;
    this.c = c;
    this.dir = dir;
  }
  
  void draw(float px, float py) {
    fill(c[0],c[1],c[2],100);
    stroke(c[0],c[1],c[2],255);
    translate(x - px, y - py, 0);
    rotateY(PI / 2);
    rotateX(r);
    rect(0, full_len - len, 10, len);
    rotateX(-r);
    rotateY(-PI / 2);
    translate(-(x - px), -(y - py), 0);
  }
}
