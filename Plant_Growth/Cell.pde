abstract class Cell {
  float nutrition;
  int age = 0;
  int species;
  int x; 
  int y;

  public Cell(float nutrition, int species, int x, int y) {
    this.nutrition = nutrition;
    this.species = species;
    this.x = x;
    this.y = y;
  }

  abstract void display(int x, int y);

  abstract String type();

  boolean affectedByGravity() {
    String t = type();
    return t == "deadPlant" || t == "seed" || t == "soil";
  }
}

// Used to fill by linearly interpolating between two different colors
void lerpFill(int r1, int g1, int b1, int r2, int g2, int b2, float nutrition) {
  float x = max(0, min(1, nutrition * 0.01));

  float r = (r2 - r1) * x + r1;
  float g = (g2 - g1) * x + g1;
  float b = (b2 - b1) * x + b1;
  fill(r, g, b);
}

class YoungPlantCell extends Cell {  
  public YoungPlantCell(float nutrition, int species, int x, int y) {
    super(nutrition, species, x, y);
  }


  void display(int x, int y) {
    lerpFill(216, 223, 186, 143, 196, 0, nutrition);
    rect(x * cellSize, y * cellSize, cellSize, cellSize);
  }


  String type() {
    return "youngPlant";
  }
}

class OldPlantCell extends Cell {
  public OldPlantCell(float nutrition, int species, int x, int y) {
    super(nutrition, species, x, y);
  }


  void display(int x, int y) {
    lerpFill(96, 124, 92, 19, 156, 0, nutrition);
    rect(x * cellSize, y * cellSize, cellSize, cellSize);
  }


  String type() {
    return "oldPlant";
  }
}

class DeadPlantCell extends Cell {
  int decompositionTime;

  public DeadPlantCell(float nutrition, int x, int y) {
    super(nutrition, 0, x, y);
    this.decompositionTime = DECOMPOSITION_TIME_MIN + int(random(DECOMPOSITION_TIME_MAX - DECOMPOSITION_TIME_MIN));
  }


  void display(int x, int y) {
    lerpFill(142, 155, 140, 133, 122, 110, nutrition);
    rect(x * cellSize, y * cellSize, cellSize, cellSize);
  }


  String type() {
    return "deadPlant";
  }
}

class RootCell extends Cell {
  public RootCell(float nutrition, int species, int x, int y) {
    super(nutrition, species, x, y);
  }


  void display(int x, int y) {
    lerpFill(209, 201, 164, 228, 206, 132, nutrition);
    rect(x * cellSize, y * cellSize, cellSize, cellSize);
  }


  String type() {
    return "root";
  }
}

class FlowerCell extends Cell {
  public FlowerCell(float nutrition, int species, int x, int y) {
    super(nutrition, species, x, y);
  }


  void display(int x, int y) {
    fill(255, 185, 84);
    rect(x * cellSize, y * cellSize, cellSize, cellSize);
  }


  String type() {
    return "flower";
  }
}

class PetalCell extends Cell {
  public PetalCell(float nutrition, int species, int x, int y) {
    super(nutrition, species, x, y);
  }


  void display(int x, int y) {
    fill(PETAL_COLORS[species]);
    rect(x * cellSize, y * cellSize, cellSize, cellSize);
  }


  String type() {
    return "petal";
  }
}

class SeedCell extends Cell {
  public SeedCell(int species, int x, int y) {
    super(0, species, x, y);
  }


  void display(int x, int y) {
    fill(SEED_COLORS[species]);
    rect(x * cellSize, y * cellSize, cellSize, cellSize);
  }


  String type() {
    return "seed";
  }
}

class SoilCell extends Cell {
  public SoilCell(float nutrition, int x, int y) {
    super(nutrition, 0, x, y);
  }


  void display(int x, int y) {
    lerpFill(255, 235, 175, 48, 40, 6, nutrition);
    rect(x * cellSize, y * cellSize, cellSize, cellSize);
  }


  String type() {
    return "soil";
  }
}
