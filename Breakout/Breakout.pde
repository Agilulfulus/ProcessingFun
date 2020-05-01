import processing.sound.*;

ArrayList<Block> blocks;
ArrayList<FloatingText> ftext;
ArrayList<Ball> balls;
ArrayList<Character> keys;
ArrayList<float[][]> songs;
PImage img;
int mindex = 0;
Slider slider;
boolean lost = false;
boolean began = false;
boolean menu = true;
boolean help = false;
int score = 0;
static PApplet app;
int bezel = 5;
float speed = 10;
int hue_var = 0;
MusicThread mt;
String[] menu_op = {
  "Difficulty: Normal",
  "Play",
  "Help",
  "Quit"
};
int menu_sel = 0;

String banner = "\n"
  + " _|_|_|    _|_|_|    _|_|_|_|    _|_|    _|    _|    _|_|    _|    _|  _|_|_|_|_|  \n"
  + " _|    _|  _|    _|  _|        _|    _|  _|  _|    _|    _|  _|    _|      _|      \n"
  + " _|_|_|    _|_|_|    _|_|_|    _|_|_|_|  _|_|      _|    _|  _|    _|      _|      \n"
  + " _|    _|  _|    _|  _|        _|    _|  _|  _|    _|    _|  _|    _|      _|      \n"
  + " _|_|_|    _|    _|  _|_|_|_|  _|    _|  _|    _|    _|_|      _|_|        _|      \n"
  + "                                                                                   ";



int[][] map = {
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 0},
  {0, 3, 3, 3, 0, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 0, 3, 3, 3, 0},
  {0, 3, 3, 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 0, 0, 0, 3, 3, 0},
  {0, 2, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 2, 0},
  {0, 2, 2, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 2, 2, 0},
  {0, 2, 2, 2, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 2, 2, 2, 0},
  {0, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0}
};

float[][] wave = {
  {0, 1000},
  {-1, 0.25},
  {2, 0.25},
  {1, 0.25},
  
  {-3, 1.75},
  {-6, 0.25},
  
  {-5, 0.25},
  {-2, 0.25},
  {1, 0.25},
  {4, 0.25},
  {7, 0.25},
  {6, 0.5},
  {9, 2.75},
  
  {9, 0.25},
  {9, 0.5},
  {11, 0.5},
  {9, 0.5},
  
  {7, 0.5},
  {7, 0.25},
  {6, 0.5},
  {7, 1},
  
  {6, 0.25},
  {7, 0.5},
  {9, 0.5},
  {6, 2.5},
  
  {6, 0.25},
  {9, 0.25},
  {8, 0.25},
  {7, 0.25},
  {6, 0.5},
  {6, 0.5},
  
  {2, 0.25},
  {2, 0.25},
  {2, 0.5},
  {-1, 0.25},
  {2, 0.25},
  {4, 0.25},
  
  {5, 0.25},
  {2, 0.25},
  {0, 0.25},
  {-4, 0.25},
  {-5, 0.25},
  {-7, 0.5},
  {-7, 0.5},
  {-10, 3},
  
  {-1, 0.25},
  {2, 0.25},
  {1, 0.25},
  
  {-3, 1.75},
  {-6, 0.25},
  
  {-5, 0.25},
  {-2, 0.25},
  {1, 0.25},
  {4, 0.25},
  {7, 0.25},
  {6, 0.5},
  {9, 2.75},
  
  {9, 0.25},
  {9, 0.5},
  {11, 0.5},
  {9, 0.5},
  
  {7, 0.5},
  {7, 0.25},
  {6, 0.5},
  {7, 1},
  
  {6, 0.25},
  {7, 0.5},
  {9, 0.5},
  {6, 2.5},
  
  {6, 0.25},
  {9, 0.25},
  {8, 0.25},
  {7, 0.25},
  {6, 0.5},
  {6, 0.5},
  
  {2, 0.25},
  {2, 0.25},
  {2, 0.5},
  {-1, 0.25},
  {2, 0.25},
  {4, 0.25},
  
  {5, 0.25},
  {2, 0.25},
  {0, 0.25},
  {-4, 0.25},
  {-5, 0.25},
  {-7, 0.5},
  {-7, 0.5},
  {-10, 3.75},
  
  {2, 1},
  {0, 1.0/3.0},
  {-2, 1.0/3.0},
  {-3, 1.0/3.0},
  
  {-5, 1},
  {-3, 1.0/3.0},
  {-2, 1.0/3.0},
  {2, 1.0/3.0},
  
  {0, 0.75},
  {0, 0.25},
  {0, 3},
  
  {0, 1.25},
  {-2, 0.25},
  {-4, 0.25},
  {-5, 0.25},
  
  {-7, 1},
  {-5, 1.0/3.0},
  {-4, 1.0/3.0},
  {0, 1.0/3.0},
  
  {-2, 0.75},
  {-2, 0.25},
  {-2, 2.25},
  
  {-2, 0.25},
  {2, 0.25},
  {1, 0.25},
  
  {-3, 1.75},
  {-6, 0.25},
  
  {-5, 0.25},
  {-2, 0.25},
  {1, 0.25},
  {4, 0.25},
  {7, 0.25},
  {6, 0.5},
  {9, 2.75},
  
  {9, 0.25},
  {9, 0.5},
  {11, 0.5},
  {9, 0.5},
  
  {7, 0.5},
  {7, 0.25},
  {6, 0.5},
  {7, 1},
  
  {6, 0.25},
  {7, 0.5},
  {9, 0.5},
  {6, 2.5},
  
  {6, 0.25},
  {9, 0.25},
  {8, 0.25},
  {7, 0.25},
  {6, 0.5},
  {6, 0.5},
  
  {2, 0.25},
  {2, 0.25},
  {2, 0.5},
  {-1, 0.25},
  {2, 0.25},
  {4, 0.25},
  
  {5, 0.25},
  {2, 0.25},
  {0, 0.25},
  {-4, 0.25},
  {-5, 0.25},
  {-7, 0.5},
  {-7, 0.5},
  {-10, 3.75},
  
  {2, 1},
  {0, 1.0/3.0},
  {-2, 1.0/3.0},
  {-3, 1.0/3.0},
  
  {-5, 1},
  {-3, 1.0/3.0},
  {-2, 1.0/3.0},
  {2, 1.0/3.0},
  
  {0, 0.75},
  {0, 0.25},
  {0, 3},
  
  {0, 1.25},
  {-2, 0.25},
  {-4, 0.25},
  {-5, 0.25},
  
  {-7, 1},
  {-5, 1.0/3.0},
  {-4, 1.0/3.0},
  {0, 1.0/3.0},
  
  {-2, 0.75},
  {-2, 0.25},
  {-2, 2.25}
};

float[][] dissealguem = {
  {0, 1000},
  {12, 0.75},
  {7, 0.25},
  {4, 2},
  
  {12, 1.0/3.0},
  {14, 1.0/3.0},
  {12, 1.0/3.0},
  
  {11, 0.75},
  {8, 0.25},
  {4, 3},
  
  {9, 0.75},
  {7, 0.25},
  {4, 1.5},
  
  {3, 0.5},
  {4, 1.0/3.0},
  {10, 1.0/3.0},
  {9, 1.0/3.0},
  
  {7, 1},
  {5, 3},
  
  {4, 0.75},
  {3, 0.25},
  {2, 2},
  
  {4, 1.0/3.0},
  {8, 1.0/3.0},
  {11, 1.0/3.0},
  
  {14, 1},
  {12, 3},
  
  {11, 0.75},
  {10, 0.25},
  {9, 2},
  
  {9, 1.0/3.0},
  {14, 1.0/3.0},
  {11, 1.0/3.0},
  
  {9, 2},
  {11, 2},
  
  {12, 0.75},
  {7, 0.25},
  {4, 2},
  
  {12, 1.0/3.0},
  {14, 1.0/3.0},
  {12, 1.0/3.0},
  
  {11, 0.75},
  {8, 0.25},
  {4, 3},
  
  {9, 0.75},
  {7, 0.25},
  {4, 1.5},
  
  {3, 0.5},
  {4, 1.0/3.0},
  {10, 1.0/3.0},
  {9, 1.0/3.0},
  
  {7, 1},
  {5, 3},
  
  {14, 1},
  {12, 0.5},
  {11, 0.5},
  
  {14, 1.5},
  {12, 0.5},
  
  {11, 1},
  {4, 0.5},
  {7, 0.5},
  
  {11, 1.5},
  {9, 0.5},
  
  {12, 1},
  {9, 0.5},
  {12, 0.5},
  
  {16, 1},
  {16, 1},
  
  {12, 4}  
};

float[][] love = {
  {0, 800},
  {7, 1.5},
  {6, 0.5},
  
  {6, 0.5},
  {4, 0.5},
  {3, 0.5},
  {4, 0.5},
  
  {7, 1.5},
  {6, 0.5},
  {6, 2},
  
  {6, 1.5},
  {4, 0.5},
  
  {4, 0.5},
  {2, 0.5},
  {1, 0.5},
  {2, 0.5},
  
  {6, 1.5},
  {4, 0.5},
  {4, 2},
  
  {11, 1.5},
  {9, 0.5},
  
  {9, 0.5},
  {7, 0.5},
  {6, 0.5},
  {7, 0.5},
  
  {11, 1.5},
  {9, 0.5},
  
  {9, 0.5},
  {7, 0.5},
  {6, 0.5},
  {7, 0.5},
  
  {11, 1.5},
  {9, 0.5},
  
  {9, 0.5},
  {7, 0.5},
  {6, 0.5},
  {7, 0.5},
  
  {11, 0.5},
  {9, 0.5},
  {9, 0.5},
  {7, 0.5},
  
  {7, 0.5},
  {6, 0.5},
  {4, 0.5},
  {6, 0.5},
  //
  {7, 1.5},
  {6, 0.5},
  
  {6, 0.5},
  {4, 0.5},
  {3, 0.5},
  {4, 0.5},
  
  {7, 1.5},
  {6, 0.5},
  {6, 2},
  
  {6, 1.5},
  {4, 0.5},
  
  {4, 0.5},
  {2, 0.5},
  {1, 0.5},
  {2, 0.5},
  
  {6, 1.5},
  {4, 0.5},
  {4, 2},
  
  {11, 1.5},
  {9, 0.5},
  
  {9, 0.5},
  {7, 0.5},
  {6, 0.5},
  {7, 0.5},
  
  {11, 0.5},
  {9, 0.5},
  {9, 0.5},
  {7, 0.5},
  
  {7, 0.5},
  {6, 0.5},
  {4, 0.5},
  {6, 0.5},
  
  {7, 1.5},
  {6, 0.5},
  
  {6, 0.5},
  {4, 0.5},
  {6, 0.5},
  {9, 0.5},
  
  {7, 4}
};

void setup() {
  noStroke();
  size(2000, 1000);
  frameRate(60);
  img = loadImage("ball.png");
  ftext = new ArrayList<FloatingText>();
  balls = new ArrayList<Ball>();
  keys = new ArrayList<Character>();
  songs = new ArrayList<float[][]>();
  songs.add(wave);
  songs.add(dissealguem);
  songs.add(love);
  setupMap(map);
  slider = new Slider(900);
  app = this;  
  mt = new MusicThread(songs.get(mindex));
  mt.start();
}

int[][] perlinMap(int w, int h) {
  noiseSeed((long)random(100000));
  int[][] map = new int[h][w];
  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      float n = pow(noise(2 * x * 0.05, y * 0.05), pow((float)y/h, 0.5));
      map[y][x] = n < 0.6 && n > 0.4 ? 0 : 1;
    }
  }
  
  noiseSeed((long)random(100000));
  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      float n = pow(noise(2 * x * 0.1, y * 0.1), 1.5);
      if (map[y][x] == 1) {
        map[y][x] = ceil(n * 6.0);
      }
    }
  }
  
  return map;
}

void setupMap(int[][] map) {
  blocks = new ArrayList<Block>();
  for (int y = 0; y < map.length; y++) {
    for (int x = 0; x < map[0].length; x++) {
      if (map[y][x] > 0)
        blocks.add(new Block(x * 80, y * 40, map[y][x]));
    }
  }
}

void keyPressed() {
  if (!keys.contains(key))
    keys.add(key);
}
 
void keyReleased() {
  if (menu) {
    if (!help) {
      if (key == 's')
        menu_sel = (menu_sel + 1) % menu_op.length;
      if (key == 'w')
        menu_sel = (menu_op.length + menu_sel - 1) % menu_op.length;
      if (key == ' ') {
        switch (menu_op[menu_sel]) {
          case "Play":
            menu = false;
            break;
          case "Difficulty: Easy":
            menu_op[0] = "Difficulty: Normal";
            speed = 10;
            break;
          case "Difficulty: Normal":
            menu_op[0] = "Difficulty: Hard";
            speed = 15;
            break;
          case "Difficulty: Hard":
            menu_op[0] = "Difficulty: Easy";
            speed = 5;
            break;
          case "Help":
            help = true;
            break;
          case "Quit":
            exit();
            break;
        }
      }
    } else {
      help = false;
    }
  } else {
    if (key == ' ') {
      if (lost) {
        began = false;
        lost = false;
        score = 0;
        setupMap(perlinMap(25, 16));
      } else {
        balls.add(new Ball(slider.x + 100, 955, 30, speed));
        began = true;
      }
    }
  }
  
  if (key == 'e') {
    mt.terminate();
    mindex = (mindex + 1) % songs.size();
    mt = new MusicThread(songs.get(mindex));
    mt.start();
  } else if (key == 'q') {
    mt.terminate();
    mindex = (songs.size() + mindex - 1) % songs.size();
    mt = new MusicThread(songs.get(mindex));
    mt.start();
  }
  
  keys.remove((Object)key);
}

void drawMenu() {
    colorMode(HSB, 360, 100, 100);
    fill(hue_var / 2, 100, 100);
    textFont(createFont("PixelMplus12-Bold.ttf", 36));
    textAlign(CENTER);
    text(banner, 1000, 200);
    colorMode(RGB, 256);
    if (!help) {
      for (int i = 0; i < menu_op.length; i++) { 
        if (i == menu_sel) {
          fill(255,0,0);
          textFont(createFont("PixelMplus12-Bold.ttf", 36));
        } else {
          fill(255,255,255);
          textFont(createFont("PixelMplus12-Regular.ttf", 36));
        }
        text(menu_op[i], 1000, 600 + i * 40);
      }
    } else {
      textFont(createFont("PixelMplus12-Bold.ttf", 36));
      fill(255,255,255);
      text("INSTRUCTIONS", 1000, 600);
      textFont(createFont("PixelMplus12-Regular.ttf", 36));
      text("Use the keys <A> and <D> to move left and right respectively\nPress <SPACE> to select an option in the menu, and to shoot a ball during the game\nPress <W> and <S> to navigate up and down in the menu\nPress <Q> and <E> to navigate the music tracks\nPRESS ANY KEY TO RETURN", 1000, 640);
    }
    hue_var = (hue_var + 1) % 720;
}

void draw() {
  clear();
  background(0,0,0);
  
  if (menu) {
      drawMenu();
      return;
  }
  
  textFont(createFont("PixelMplus12-Regular.ttf", 64));
  
  for (Block b : blocks) {
    b.draw();
  }
  for (Ball b : balls) {
    b.draw();
  }
  ArrayList<FloatingText> remove = new ArrayList<FloatingText>();
  for (FloatingText t : ftext) {
    if(t.draw())
      remove.add(t);
  }
  ftext.removeAll(remove);
  slider.draw();
  textSize(32);
  textAlign(LEFT);
  fill(255,255,255);
  text("SCORE: " + score, 20, 980);
  if (!lost) {
    if (keys.contains('a'))
      slider.momentum -= 1;
    if (keys.contains('d'))
      slider.momentum += 1;
    slider.x += slider.momentum * 4;
    slider.momentum *= 0.75;
    if (slider.x <= 0) {
      slider.momentum *= -1;
      slider.x = 0;
    }
    if (slider.x >= 1800){
      slider.momentum *= -1;
      slider.x = 1800;
    }
    if (!began) {
      fill(255);
      circle(slider.x + 100, 965, 30);
    }
    ArrayList<Ball> br = new ArrayList<Ball>();
    for (Ball b : balls) {
      if(b.move())
        br.add(b);
    }
    balls.removeAll(br);
    if (balls.isEmpty() && began) {
      lost = true;
    }
  } else {
    textSize(128);
    textAlign(CENTER);
    fill(255,255,255);
    text("YOU LOSE", 1000, 500);
  }
}

class MusicThread extends Thread{
  float[][] notes;
  SinOsc sine;
  boolean running;
  public MusicThread(float[][] notes) {
    this.notes = notes;
    sine = new SinOsc(app);
    running = true;
  }
  
  public void terminate() {
    running = false;
    sine.amp(0);
  }
  
  public void run() {
    int bar = (int)notes[0][1];
    while (running) {
      for (int j = 1; j < notes.length; j++) {
        float[] n = notes[j];
        if (!running)
          break;
        float note = n[0];
        float dur = n[1];
        sine.freq(261.64 * pow(2.0, (note / 12.0)));
        sine.amp(1);
        sine.play();
        delay((int)(dur * bar) - 100);
        for (int i = 10; i > 0; i--) {
          if (running)
            sine.amp((float)i / 10.0);
          delay(10);
        }
      }
    }
    print("Music thread ended\n");
  }
}

class SoundThread extends Thread{
   int fever;
   float pan;
 
   public SoundThread(int fever, float pan){
      this.fever = fever;
      this.pan = pan;
   }
 
   public void run(){
    SqrOsc sine = new SqrOsc(app);
    sine.freq(261.64 * pow(2.0, ((float)min(fever, 36)) / 12.0));
    sine.amp(0.25);
    sine.pan(pan);
    sine.play();
    delay(100);
    sine.stop();
   }
}

class Ball {
  float x, y, speed_x, speed_y, size, max_speed;
  int fever;
  Ball(float x, float y, float size, float speed) {
    this.x = x;
    this.y = y;
    this.size = size;
    speed_x = 0;
    speed_y = -speed;
    this.max_speed = speed;
    fever = 0;
  }
  
  boolean move() {
    x += speed_x;
    y += speed_y;
    int i = isCollidedBlock();
    if (i > 0) {
      bounce(i);
      fever++;
    }
    else if (isCollidedBall())
      bounce(3);
    else if (x <= size / 2.0 || x >= 2000 - size / 2.0)
      bounce(1);
    else if (y <= size / 2.0)
      bounce(2);
    else {
      if (y >= 980 - size / 2.0) {
        if (x < slider.x + 200 + size / 2.0 && x > slider.x - size / 2.0 && speed_y > 0) {
          float dist = (slider.x + 100) - x;
          speed_x = constrain(speed_x - dist/20.0, -max_speed * 0.9, max_speed * 0.9);
          speed_y = sqrt(pow(max_speed, 2) - pow(speed_x, 2));
          fever = 0;
          bounce(2);
        } else if (y >= 1000) {
          return true;
        }
      }
    }
    return false;
  }
  
  void bounce(int axis) {
    new SoundThread(fever, (x / 1000.0) -1).start();
    switch (axis) {
      case 1:
        speed_x *= -1;
        break;
      case 2:
        speed_y *= -1;
        break;
      case 3:
        speed_x *= -1;
        speed_y *= -1;
        break;
    }
  }
  
  boolean isCollidedBall() {
    for (Ball b : balls) {
      if (sqrt(pow(b.x - x, 2) + pow(b.y - y, 2)) < 50 && b != this) {
        return true;
      }
    }
    return false;
  }
  
  int isCollidedBlock() {
    for (Block b : blocks) {
      float top_left_x = b.x;
      float top_left_y = b.y;
      float bottom_right_x = b.x + 80;
      float bottom_right_y = b.y + 40;
      if (abs(y - bottom_right_y) < size / 2.0 && x > top_left_x && x < bottom_right_x) {
        b.health--;
        if (b.health == 0)
          b.destroy(fever);
        return 2;
      }
      if (abs(y - top_left_y) < size / 2.0 && x > top_left_x && x < bottom_right_x) {
        b.health--;
        if (b.health == 0)
          b.destroy(fever);
        return 2;
      }
      if (abs(x - bottom_right_x) < size / 2.0 && y > top_left_y && y < bottom_right_y) {
        b.health--;
        if (b.health == 0)
          b.destroy(fever);
        return 1;
      }
      if (abs(x - top_left_x) < size / 2.0 && y > top_left_y && y < bottom_right_y) {
        b.health--;
        if (b.health == 0)
          b.destroy(fever);
        return 1;
      }
      if (sqrt(pow(x - top_left_x, 2) + pow(y - top_left_y, 2)) < size / 2.0
          || sqrt(pow(x - bottom_right_x, 2) + pow(y - top_left_y, 2)) < size / 2.0
          || sqrt(pow(x - top_left_x, 2) + pow(y - bottom_right_y, 2)) < size / 2.0
          || sqrt(pow(x - bottom_right_x, 2) + pow(y - bottom_right_y, 2)) < size / 2.0) {
        b.health--;
        if (b.health == 0)
          b.destroy(fever);
        return 2;
       }
    }
    return 0;
  }
  
  void draw() {
    fill(255 - min(255, fever * 20),255, 255 - min(255, fever * 20));
    circle(x, y, size);
  }
}

class Slider {
  float x, momentum;
  
  Slider(float x) {
    this.x = x;
  }
  
  void draw() {
    fill(255,255,255);
    rect(x, 980, 200, 20);
  }
}

class Block {
  int x, y, health, value;
  
  Block(int x, int y, int health) {
    this.x = x;
    this.y = y;
    this.health = health;
    value = health;
  }
  
  void draw() {
    int r, g, b;
    r = 0;
    g = 0;
    b = 0;
    switch(health) {
      case 1:
        r = g = b = 205;
        break;
      case 2:
        r = g = b = 145;
        break;
      case 3:
        r = g = b = 85;
        break;
      case 4:
        b = 205;
        break;
      case 5:
        b = 145;
        break;
      case 6:
        b = 85;
        break;
    }
    fill(r, g, b);
    rect(x + bezel, y + bezel, 80 - bezel * 2, 40 - bezel * 2);
    fill(min(255, r + 50), min(255, g + 50), min(255, b + 50));
    triangle(x,y,x+bezel,y+bezel,x + bezel,y);
    triangle(x + 80,y,x+80-bezel,y+bezel,x + 80-bezel,y);
    rect(x+bezel,y,80-bezel*2,bezel);
    fill(min(255, r + 25), min(255, g + 25), min(255, b + 25));
    triangle(x,y,x+bezel,y+bezel,x,y+bezel);
    triangle(x,y+40,x+bezel,y+40-bezel,x,y+40-bezel);
    rect(x,y+bezel,bezel,40-bezel*2);
    fill(max(0, r - 50), max(0, g - 50), max(0, b - 50));
    triangle(x + 80,y + 40, x + 80-bezel, y + 40-bezel, x + 80-bezel, y+40);
    triangle(x,y+40,x+bezel,y+40-bezel,x+bezel,y+40);
    rect(x+bezel,y+40-bezel,80-bezel*2,bezel);
    fill(max(0, r - 25), max(0, g - 25), max(0, b - 25));
    triangle(x + 80,y + 40, x + 80-bezel, y + 40-bezel, x + 80, y+40-bezel);
    triangle(x + 80,y, x + 80-bezel, y + bezel, x + 80,y+bezel);
    rect(x+80-bezel,y+bezel,bezel,40-bezel*2);
  }
  
  void destroy(int fever) {
    blocks.remove(this);
    ftext.add(new FloatingText(x + 40, y + 20, "+" + (value + fever), 255 - min(255, fever * 20), 255, 255 - min(255, fever * 20), fever + 20));
    score += value + fever;
  }
}

class FloatingText {
  float x, y, time;
  int r,g,b,size;
  String text;
  
  FloatingText(float x, float y, String text, int r, int g, int b, int size) {
    this.x = x;
    this.y = y;
    this.text = text;
    time = 50;
    this.r = r;
    this.b = b;
    this.g = g;
    this.size = size;
  }
  
  boolean draw() {
    time--;
    if (time <= 0)
      return true;
    textSize(size);
    textAlign(CENTER);
    fill(r,g,b,255 * time / 50);
    text(text, x, y + (50 - time));
    return false;
  }
}
