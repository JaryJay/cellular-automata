abstract class Cell { 
  int nutrition;
  int species;

  public Cell(int nutrition, int species) {
    this.nutrition = nutrition;
    this.species = species;
  }

  abstract void display(int x, int y);

  abstract String type();
}

class YoungPlantCell extends Cell {
  public YoungPlantCell(int nutrition, int species) {
    super(nutrition, species);
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
  public OldPlantCell(int nutrition, int species) {
    super(nutrition, species);
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

  public DeadPlantCell(int nutrition, int decompositionTime) {
    super(nutrition, 0);
    this.decompositionTime = decompositionTime;
  }

  void display(int x, int y) {
    lerpFill(142, 155, 140, 61, 45, 11, nutrition);
    rect(x * cellSize, y * cellSize, cellSize, cellSize);
  }

  String type() {
    return "deadPlant";
  }
}

class RootCell extends Cell {
  public RootCell(int nutrition, int species) {
    super(nutrition, species);
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
  public FlowerCell(int nutrition, int species) {
    super(nutrition, species);
  }

  void display(int x, int y) {
    fill(255, 222, 175); 
    rect(x * cellSize, y * cellSize, cellSize, cellSize);
  }

  String type() {
    return "flower";
  }
}

class PetalCell extends Cell {
  public PetalCell(int nutrition, int species) {
    super(nutrition, species);
  }

  void display(int x, int y) {
    if (species == 0)
      fill(243, 243, 243);
    else if (species == 1)
      fill(153, 0, 255);
    else if (species == 2)
      fill(210, 173, 249);
    else if (species == 3)
      fill(251, 255, 12);
    else
      fill(255, 193, 119);  
    rect(x * cellSize, y * cellSize, cellSize, cellSize);
  }

  String type() {
    return "petal";
  }
}

class SeedCell extends Cell {
  public SeedCell(int species) {
    super(0, species);
  }

  void display(int x, int y) {
    if (species == 0)
      fill(107, 86, 62);
    else if (species == 1)
      fill(152, 105, 4);
    else if (species == 2)
      fill(112, 119, 34);
    else if (species == 3)
      fill(122, 113, 59);
    else
      fill(148, 89, 41);
    rect(x * cellSize, y * cellSize, cellSize, cellSize);
  }

  String type() {
    return "seed";
  }
}

class SoilCell extends Cell {
  public SoilCell(int nutrition) {
    super(nutrition, 0);
  }

  void display(int x, int y) {
    lerpFill(255, 235, 175, 48, 40, 6, nutrition);
    rect(x * cellSize, y * cellSize, cellSize, cellSize);
  }

  String type() {
    return "soil";
  }
}
