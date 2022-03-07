void oneSeedConfiguration() {
  for (int y=0; y < heightInCells; y++) {
    for (int x=0; x < widthInCells; x++) {
      if (y >= heightInCells - 20) {
        cells[y][x] = new SoilCell(10 + round(random(30)));
      }
    }
  }
  
  int species = int(random(3));
  cells[heightInCells - 20][widthInCells / 2] = new SeedCell(species);
}

// One cell at the top
void flyingDirtConfiguration(float percentageDirt) {
  for (int y=0; y < heightInCells; y++) {
    for (int x=0; x < widthInCells; x++) {
      if (random(1) < percentageDirt) {
        cells[y][x] = new SoilCell(10 + round(random(30)));
      }
    }
  }
  
  int species = int(random(3));
  cells[0][widthInCells / 2] = new SeedCell(species);
}
