void oneSeedConfiguration() {
  for (int y=0; y < heightInCells; y++) {
    for (int x=0; x < widthInCells; x++) {
      if (y >= heightInCells - 30) {
        cells[y][x] = new SoilCell(10 + round(random(40)));
      }
    }
  }
  
  int species = int(random(5));
  cells[heightInCells - 30][widthInCells / 2] = new SeedCell(species);
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
  
  int species = int(random(5));
  cells[0][widthInCells / 2] = new SeedCell(species);
}
