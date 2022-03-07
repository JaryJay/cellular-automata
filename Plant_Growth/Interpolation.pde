void lerpFill(int r1, int g1, int b1, int r2, int g2, int b2, int nutrition) {
  float x = min(1, nutrition * 0.01);
  
  float r = (r2 - r1) * x + r1;
  float g = (g2 - g1) * x + g1;
  float b = (b2 - b1) * x + b1;
  fill(r, g, b);
}
