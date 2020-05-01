float i = 0.0;
float curvature = 0.2;
float cycles = 5;
float start_x = 500;
float start_y = 500;
float orbsize = 50;
float speed = 2;

float t = 1;

void setup() {
  size(1000, 1000);
  colorMode(HSB, 360, 100, 100);
}

void draw() {
  clear();
  background(0,0,100);
  strokeWeight(5);
  spiral(curvature, cycles, start_x, start_y, 0);
  
  i+=t * speed;
  float[] pos1 = coordsAt(new float[] {start_x, start_y}, curvature, i);
  float[] pos2 = coordsAt(new float[] {start_x, start_y}, curvature, cycles * 360.0 - i);
  if (sqrt(pow((pos1[0] - pos2[0]), 2) + pow((pos1[1] - pos2[1]), 2)) <= orbsize) {
    t = -1;
  } else if (i < 0) {
    t = 1;
  }
  strokeWeight(0);
  fill(0);
  circle(pos1[0], pos1[1], orbsize);
  fill(0,0,50);
  circle(pos2[0], pos2[1], orbsize);
}

void spiral(float curvature, float cycles, float start_x, float start_y, float start_hue) {
  float x = start_x;
  float y = start_y;
  for (float i = 0.0; i < cycles * 360.0; i++) {
    float[] pos = coordsAt(new float[] {start_x, start_y}, curvature, i);
    stroke(360 - ((i / (cycles * 360.0) * 360.0 + start_hue) % 360), 100, 100);
    line(x, y, pos[0], pos[1]);
    x = pos[0];
    y = pos[1];
  }
}

float[] coordsAt(float[] origin, float curvature, float i) {
  return new float[] {origin[0] + cos(radians(i))*curvature*i, origin[1] - sin(radians(i))*curvature*i};
}
