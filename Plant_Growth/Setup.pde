void oneSeedConfiguration() {
  for (int y=0; y < heightInCells; y++) {
    for (int x=0; x < widthInCells; x++) {
      if (y >= heightInCells - 30) {
        cells[y][x] = new SoilCell(70 + round(random(30)), x, y);
      }
    }
  }

  for (int i = 0; i < 10; i ++) {
    int species = int(random(5));
    int sX = 50 + (widthInCells-100) * i / 10; 
    int sY = heightInCells - 30;
    cells[sY][sX] = new SeedCell(species, sX, sY);
  }
}

// One cell at the top
void flyingDirtConfiguration(float percentageDirt) {
  for (int y=0; y < heightInCells; y++) {
    for (int x=0; x < widthInCells; x++) {
      if (random(1) < percentageDirt) {
        cells[y][x] = new SoilCell(70 + round(random(30)), x, y);
      }
    }
  }
  
  
  for (int i = 0; i < 10; i ++) {
    int species = int(random(5));
    int sX = 50 + (widthInCells-100) * i / 10; 
    int sY = 0;
    cells[sY][sX] = new SeedCell(species, sX, sY);
  }

  //int species = int(random(5));
  //int sX = widthInCells / 2;
  //int sY = 0;
  //cells[sY][sX] = new SeedCell(species, sX, sY);
}
