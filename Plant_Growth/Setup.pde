void flatGroundConfiguration(int groundHeight) {
  for (int y=heightInCells - groundHeight; y < heightInCells; y++) {
    for (int x=0; x < widthInCells; x++) {
        cells[y][x] = new SoilCell(SOIL_NUTRITION_MIN + round(random(SOIL_NUTRITION_MAX - SOIL_NUTRITION_MIN)), x, y);
    }
  }

  for (int i = 0; i < NUM_SPECIES; i ++) {
    int sX = 50 + (widthInCells-100) * i / (NUM_SPECIES - 1); 
    int sY = max(0, heightInCells - groundHeight - 30);
    cells[sY][sX] = new SeedCell(i, sX, sY);
  }
}

void bumpyGroundConfiguration(int groundHeight, int bumpiness, float period, float phaseShift) {
  //for (int y=heightInCells - groundHeight; y < heightInCells; y++) {
  //  for (int x=0; x < widthInCells; x++) {
  //      cells[y][x] = new SoilCell(SOIL_NUTRITION_MIN + round(random(SOIL_NUTRITION_MAX - SOIL_NUTRITION_MIN)), x, y);
  //  }
  //}
  for (int y=heightInCells - groundHeight - bumpiness; y < heightInCells; y++) {
    for (int x=0; x < widthInCells; x++) {
      if (y - heightInCells + groundHeight > sin((x - phaseShift) / period) * bumpiness) {
        cells[y][x] = new SoilCell(SOIL_NUTRITION_MIN + round(random(SOIL_NUTRITION_MAX - SOIL_NUTRITION_MIN)), x, y);
      }
    }
  }

  for (int i = 0; i < NUM_SPECIES; i ++) {
    int sX = 50 + (widthInCells-100) * i / (NUM_SPECIES - 1);
    int sY = max(0, heightInCells - groundHeight - 30);
    cells[sY][sX] = new SeedCell(i, sX, sY);
  }
}
