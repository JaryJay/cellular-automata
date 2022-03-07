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
        if (isType(x, y+1, "soil") && random(1) < 0.02) {
          cellsNext[y][x] = new YoungPlantCell(100, c.species);
          cellsNext[y+1][x] = new RootCell(100, c.species);
        }
      } else if (c.type() == "youngPlant" || c.type() == "oldPlant") {
        
      }
    }
  }
}
