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
    rect(0, 0, 0, 0);
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
    rect(0, 0, 0, 0);
  }

  String type() {
    return "oldPlant";
  }
}

class DeadPlantCell extends Cell {
  int decompositionTime;

  public DeadPlantCell(int nutrition, int decompositionTime) {
    super(nutrition, 0);
  }

  void display(int x, int y) {
    rect(0, 0, 0, 0);
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
    rect(0, 0, 0, 0);
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
    rect(0, 0, 0, 0);
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
    rect(0, 0, 0, 0);
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
    rect(0, 0, 0, 0);
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
    rect(0, 0, 0, 0);
  }

  String type() {
    return "soil";
  }
}
