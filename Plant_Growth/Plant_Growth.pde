// Parameters
final float[] GROWTH_FACTOR =         {0.035,  0.045,  0.025,  0.09};
final float[] ROOT_GROWTH_FACTOR =    {0.18,   0.19,   0.17,   0.16};
final float[] FLOWERING_PROBABILITY = {0.0008, 0.0010, 0.0007, 0.0018};
final float[] PHOTOSYNTHESIS_SPEED =  {0.4,    0.35,   0.4,    0.06};
final float[] LIVING_COST =           {0.8,    1.0,    0.7,    0.12};
final float SPROUTING_PROBABILITY = 0.05;
final float POLLINATION_PROBABILITY = 1;
final float DECOMPOSITION_PROBABILIY = 0.8;
final float MIN_FLOWERING_NUTRITION = 80;
final float MAX_ROOT_GROWTH_AGE = 800;
final float DEATH_CONSTANT = 0.0005;
final float ROOT_DEATH_CONSTANT = 0.005;

final float SEED_SPROUT_INITIAL_NUTRITION = 300;
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
  //flyingDirtConfiguration(0.3);
  oneSeedConfiguration();
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

void mousePressed() {
  for (int y = 0; y < heightInCells; y++) {
    for (int x = 0; x < widthInCells; x++) {
      if (isPlantCell(x, y)) {
        cells[y][x] = new DeadPlantCell(cells[y][x].nutrition, 20 + int(random(50)), x, y);
      }
    }
  }
}
