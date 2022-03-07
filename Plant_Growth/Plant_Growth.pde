int widthInCells = 300;
int heightInCells = 180;
int cellSize = 5;

Cell[][] cells;
Cell[][] cellsNext;

void settings() {
  size(widthInCells * cellSize, heightInCells * cellSize);
}

void setup() {
  cells = new Cell[heightInCells][widthInCells];
  cellsNext = new Cell[heightInCells][widthInCells];
  noStroke();
  flyingDirtConfiguration(0.3);
}

void draw() {
  background(129, 180, 240);
  drawCells();
  gravityAndGrowth();
  replaceCells();
  photosynthesisAndSeedSprouting();
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
