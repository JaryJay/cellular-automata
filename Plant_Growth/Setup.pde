void oneSeedConfiguration() {
  for (int y=0; y < heightInCells; y++) {
    for (int x=0; x < widthInCells; x++) {
      if (y >= heightInCells - 30) {
        cells[y][x] = new SoilCell(50 + round(random(40)), x, y);
      }
    }
  }

  int species = int(random(5));
  int sX = widthInCells / 2;
  int sY = heightInCells - 30;
  cells[sY][sX] = new SeedCell(species, sX, sY);
}

// One cell at the top
void flyingDirtConfiguration(float percentageDirt) {
  for (int y=0; y < heightInCells; y++) {
    for (int x=0; x < widthInCells; x++) {
      if (random(1) < percentageDirt) {
        cells[y][x] = new SoilCell(50 + round(random(30)), x, y);
      }
    }
  }

  int species = int(random(5));
  int sX = widthInCells / 2;
  int sY = 0;
  cells[sY][sX] = new SeedCell(species, sX, sY);
}
