// Parameters
final float GROWTH_FACTOR = 0.1;
final float ROOT_GROWTH_FACTOR = 0.008;
final float SPROUTING_PROBABILITY = 0.02;
final float PHOTOSYNTHESIS_SPEED = 0.1;
final float DEATH_CONSTANT = 0.0002;

final float SEED_SPROUT_INITIAL_NUTRITION = 100;
final int SIMULATION_SPEED = 20;

// Visual parameters
int widthInCells = 300;
int heightInCells = 180;
int cellSize = 5;

Cell[][] cells;
Cell[][] cellsNext;

void settings() {
  size(widthInCells * cellSize, heightInCells * cellSize);
}

void setup() {
  //frameRate(SIMULATION_SPEED);
  cells = new Cell[heightInCells][widthInCells];
  cellsNext = new Cell[heightInCells][widthInCells];
  noStroke();
  flyingDirtConfiguration(0.3);
  //oneSeedConfiguration();
}

void draw() {
  background(129, 180, 240);
  drawCells();
  gravityAndGrowth();
  replaceCells();
  photosynthesisAndSeedSprouting();
  replaceCells();
  nutritionDistribution();
  aging();
  replaceCells();
  deathAndDecomposition();
  replaceCells();
}

void drawCells() {
  for (int y = 0; y < heightInCells; y++) {
    for (int x = 0; x < widthInCells; x++) {
      Cell c = cells[y][x];
      if (c != null) {
        c.display(x, y);
      }
    }
  }
}

void replaceCells() {
  for (int y = 0; y < heightInCells; y++) {
    for (int x = 0; x < widthInCells; x++) {
      cells[y][x] = cellsNext[y][x];
    }
  }
}

// Just like replaceCells(), except it copies each cell
void deepCopyCells() {
  for (int y = 0; y < heightInCells; y++) {
    for (int x = 0; x < widthInCells; x++) {
      cells[y][x] = cellsNext[y][x] == null ? null : cellsNext[y][x].copy();
    }
  }
}
