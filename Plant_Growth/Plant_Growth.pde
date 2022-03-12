// Plant growth cellular automaton by Jay Ren

// Interesting things to try:
// Add a new species (remember to edit NUM_SPECIES)
// Change an existing species
// Change the LIGHT_AMOUNT
// Change the DEATH_CONSTANT
// Change the DECOMPOSITION_CONSTANT
// Read keyPressed()
// Change 

// Parameters
final int NUM_SPECIES = 4;

final float[] GROWTH_FACTOR =         {0.035,  0.045,  0.030,  0.06}; // How likely new plant cells will form. From 0 to 1 (but usually less than 0.1)
final float[] ROOT_GROWTH_FACTOR =    {0.015,  0.038,  0.022,  0.019}; // How likely new root cells will form. From 0 to 1 (but usually less than 0.1)
final float[] DOWNWARD_GROWTH_BIAS =  {0.2,    0.95,   0.1,    0.6}; // How likely root cells will grow downwards. From 0 to 1.  0 implies the roots don't grow dowards
final int[]   MATURITY_AGE =          {55,     65,     60,     70}; // How long it takes until young plant cells become old plant cells, in # of generations
final float[] FLOWERING_PROBABILITY = {0.0008, 0.0001, 0.0006, 0.0005}; // How likely it is for old plant cells to become flower cells. From 0 to 1 (but usually less than 0.0010)
final float[] PHOTOSYNTHESIS_SPEED =  {0.3,    0.25,   0.3,    0.06}; // How much nutrition plant cells gain per generation when it photosynthesizes
final float[] LIVING_COST =           {0.8,    0.8,    0.7,    0.12}; // How much nutrition it costs per generation for plant cells to survive.
final color[] PETAL_COLORS =          {color(243, 243, 243), color(153, 0, 255), color(210, 173, 249), color(251, 255, 12)};
final color[] SEED_COLORS =           {color(107, 86, 62), color(152, 105, 4), color(112, 119, 34), color(122, 113, 59)};
final float LIGHT_AMOUNT =               1; // Global multiplier of photosynthesis speed 
final float SPROUTING_PROBABILITY =   0.03; // How likely it is for a seed to sprout each generation. From 0 to 1
final float POLLINATION_PROBABILITY =  0.5; // How likely it is for a flower to be pollinated. From 0 to 1
final float DEATH_CONSTANT =         0.001; // How likely it is for a non-root cell to die. From 0 to 1
final float ROOT_DEATH_CONSTANT =   0.0006; // How likely it is for a root cell to die. From 0 to 1
final float DECOMPOSITION_PROBABILIY = 0.2; // How likely it is for a cell to become a dead plant cell when it dies (becomes an empty cell otherwise). From 0 to 1
final float MIN_FLOWERING_NUTRITION =   80; // Minimum nutrition an old plant cell needs to become a flower cell
final float MAX_ROOT_GROWTH_AGE =      100; // Age at which root cells stop growing
final float DISTRIBUTION_SPEED =       0.3; // How fast young/old plant cells spread nutrition to one another. From 0 to 1
final float ROOT_DISTRIBUTION_SPEED =  0.8; // How fast root cells spread nutrition to one another. From 0 to 1

final int   DECOMPOSITION_TIME_MIN =   100; // Minimum time it takes for dead plant cells to become soil cells
final int   DECOMPOSITION_TIME_MAX =   150;
final int   SOIL_NUTRITION_MIN =        70; // Minimum initial nutrition of soil cells 
final int   SOIL_NUTRITION_MAX =       100;

final float SEED_SPROUT_INITIAL_NUTRITION = 300; // Initial nutrition of newborn plants
final int SIMULATION_SPEED = 60; // 60 is the best

// Visual parameters
int widthInCells = 380;
int heightInCells = 180;
int cellSize = 5;

// Don't change
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
  // For explanation of setup functions, see Setup
  //bumpyGroundConfiguration(50, 10, 10, 0);
  flatGroundConfiguration(50);
  
  spawnSeedsOfAllSpecies(80);
}

void draw() {
  background(129, 180, 240);
  // For explanation of functions, see Evolution
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

// Click to drop seeds!
void mousePressed() {
  int x = mouseX / cellSize;
  int y = mouseY / cellSize;
  if (cells[y][x] == null && mouseButton == LEFT) {
    cells[y][x] = new SeedCell(int(random(NUM_SPECIES)), x, y);
  } else if (mouseButton == RIGHT) {
    cells[y][x] = null;
  }
}

// heheheheh
void keyPressed() {
  if (key == 'k') {
    for (int y = 0; y < heightInCells; y++) {
      for (int x = 0; x < widthInCells; x++) {
        if (isPlantCell(x, y)) {
          if (random(1) < DECOMPOSITION_PROBABILIY) {
            cells[y][x] = new DeadPlantCell(cells[y][x].nutrition, x, y);
          } else {
            cells[y][x] = null;
          }
        }
      }
    }
  }
}
