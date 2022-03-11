// Parameters
final float[] GROWTH_FACTOR =         {0.035,  0.045,  0.030,  0.09};
final float[] ROOT_GROWTH_FACTOR =    {0.015,  0.038,  0.022,  0.025};
final float[] DOWNWARD_GROWTH_BIAS =  {0.2,    0.95,   0.1,    0.6};
final int[] MATURITY_AGE =            {55,     50,     60,     80};
final float[] FLOWERING_PROBABILITY = {0.0008, 0.0010, 0.0007, 0.0024};
final float[] PHOTOSYNTHESIS_SPEED =  {0.3,    0.25,   0.3,    0.06};
final float[] LIVING_COST =           {0.8,    1.0,    0.7,    0.12};
final float LIGHT_AMOUNT = 1;
final float SPROUTING_PROBABILITY = 0.03;
final float POLLINATION_PROBABILITY = 1;
final float DECOMPOSITION_PROBABILIY = 0.1;
final float DECOMPOSITION_TIME_MIN = 100;
final float DECOMPOSITION_TIME_MAX = 150;
final float MIN_FLOWERING_NUTRITION = 80;
final float MAX_ROOT_GROWTH_AGE = 100;
final float DEATH_CONSTANT = 0.05;
final float ROOT_DEATH_CONSTANT = 0.0006;
final float DISTRIBUTION_SPEED = 0.3;
final float ROOT_DISTRIBUTION_SPEED = 0.8;

final float SEED_SPROUT_INITIAL_NUTRITION = 300;
final int SIMULATION_SPEED = 60;

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
  frameRate(SIMULATION_SPEED);
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
  int x = mouseX / cellSize;
  int y = mouseY / cellSize;
  if (cells[y][x] == null && mouseButton == LEFT) {
    cells[y][x] = new SeedCell(int(random(4)), x, y);
  } else if (mouseButton == RIGHT) {
    cells[y][x] = null;
  }
}


void keyPressed() {
  if (key == 'k') {
    for (int y = 0; y < heightInCells; y++) {
      for (int x = 0; x < widthInCells; x++) {
        if (isPlantCell(x, y)) {
          if (random(1) < DECOMPOSITION_PROBABILIY) {
            cells[y][x] = new DeadPlantCell(cells[y][x].nutrition, 20 + int(random(50)), x, y);
          } else {
            cells[y][x] = null;
          }
        }
      }
    }
  }
}
