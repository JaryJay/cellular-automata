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
        if (isType(x, y+1, "soil") && isType(x, y-1, "empty") && random(1) < SPROUTING_PROBABILITY) {
          cellsNext[y][x] = new YoungPlantCell(SEED_SPROUT_INITIAL_NUTRITION, c.species, x, y);
          cellsNext[y+1][x] = new RootCell(SEED_SPROUT_INITIAL_NUTRITION, c.species, x, y+1);
        }
      } else if (c.type() == "youngPlant" || c.type() == "oldPlant") {
        cellsNext[y][x].nutrition += numAirNeighbours(x, y) * PHOTOSYNTHESIS_SPEED[c.species] - LIVING_COST[c.species];
      }
    }
  }
}

void nutritionDistribution() {
  float[][] newNutrition = new float[heightInCells][widthInCells];
  for (int y = 0; y < heightInCells; y++) {
    for (int x = 0; x < widthInCells; x++) {
      newNutrition[y][x] = cells[y][x] == null ? 0 : cells[y][x].nutrition;
    }
  }

  for (int y = 0; y < heightInCells; y++) {
    for (int x = 0; x < widthInCells; x++) {
      Cell c = cells[y][x];
      if (c == null) {
        continue;
      } else if (c.type() == "root") {
        for (Cell adj : adjacentPlantCellsAndSoil(x, y)) {
          if (adj.nutrition > c.nutrition) {
            float multiplier;
            if (adj.type() == "soil") {
              multiplier = 0.3;
            } else {
              multiplier = 0.1;
            }
            float diff = adj.nutrition - c.nutrition;
            newNutrition[y][x] += diff * multiplier;
            newNutrition[adj.y][adj.x] -= diff * multiplier;
          }
        }
      } else if (isPlantCell(x, y)) {
        for (Cell adj : adjacentPlantCells(x, y)) {
          if (adj.nutrition > c.nutrition) {
            float diff = adj.nutrition - c.nutrition;
            newNutrition[y][x] += diff * 0.1;
            newNutrition[adj.y][adj.x] -= diff * 0.1;
          }
        }
      }
    }
  }

  for (int y = 0; y < heightInCells; y++) {
    for (int x = 0; x < widthInCells; x++) {
      if (cellsNext[y][x] != null) {
        cellsNext[y][x].nutrition = newNutrition[y][x];
      }
    }
  }
}

void aging() {
  for (int y = 0; y < heightInCells; y++) {
    for (int x = 0; x < widthInCells; x++) {
      if (cellsNext[y][x] != null) {
        cellsNext[y][x].age++;
        if (isType(x, y, "youngPlant") && cellsNext[y][x].age > 60) {
          Cell prev = cellsNext[y][x];
          cellsNext[y][x] = new OldPlantCell(prev.nutrition, prev.species, x, y);
          cellsNext[y][x].age = prev.age;
        }
      }
    }
  }
}

void deathAndDecomposition() {
  for (int y = 0; y < heightInCells; y++) {
    for (int x = 0; x < widthInCells; x++) {
      if (cells[y][x] != null) {
        Cell c = cells[y][x];
        if (isPlantCell(x, y)) {
          float deathProbability = log(c.age) * DEATH_CONSTANT / (c.nutrition + 0.01);
          if (isType(x, y, "root")) {
            deathProbability = log(c.age) * ROOT_DEATH_CONSTANT / (c.nutrition + 0.01);
          } else if (isType(x, y, "petal")) {
            deathProbability *= 10;
          }
          if (random(1) < deathProbability) {
            if (c.nutrition > 30 && random(1) < DECOMPOSITION_PROBABILIY) {
              cellsNext[y][x] = new DeadPlantCell(c.nutrition, int(120 + random(20)), x, y);
            } else {
              cellsNext[y][x] = null;
            }
          }
        } else if (isType(x, y, "deadPlant")) {
          DeadPlantCell deadCell = (DeadPlantCell) c;
          if (c.age >= deadCell.decompositionTime) {
            cellsNext[y][x] = new SoilCell(c.nutrition, x, y);
          }
        }
      }
    }
  }
}
