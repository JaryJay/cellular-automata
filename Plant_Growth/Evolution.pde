void gravityAndGrowth() {
  for (int y = 0; y < heightInCells; y++) {
    for (int x = 0; x < widthInCells; x++) {
      Cell c = cells[y][x];
      if (c == null) {
        if (y > 0 && cells[y-1][x] != null && cells[y-1][x].affectedByGravity()) {
          cellsNext[y][x] = cells[y-1][x];
          cellsNext[y-1][x] = null;
          } else {
          cellsNext[y][x] = possiblyGrow(x, y);
        }
      } else {
        cellsNext[y][x] = possiblyGrow(x, y);
      }
    }
  }
}

void photosynthesisAndSeedSprouting() {
  for (int y = 0; y < heightInCells; y++) {
    for (int x = 0; x < widthInCells; x++) {
      Cell c = cells[y][x];
      if (c == null) {
        continue;
      } else if (c.type() == "seed" && y < heightInCells - 1) {
        if (isType(x, y+1, "soil") && random(1) < SPROUTING_PROBABILITY) {
          cellsNext[y][x] = new YoungPlantCell(SEED_SPROUT_INITIAL_NUTRITION, c.species);
          cellsNext[y+1][x] = new RootCell(SEED_SPROUT_INITIAL_NUTRITION, c.species);
        }
      } else if (c.type() == "youngPlant" || c.type() == "oldPlant") {
        cellsNext[y][x].nutrition += numAirNeighbours(x, y) * PHOTOSYNTHESIS_SPEED;
      }
    }
  }
}

void nutritionDistribution() {
  for (int y = 0; y < heightInCells; y++) {
    for (int x = 0; x < widthInCells; x++) {
      Cell c = cells[y][x];
      if (c == null) {
        continue;
      } else if (c.type() == "root") {
        
      }
    }
  }
}
