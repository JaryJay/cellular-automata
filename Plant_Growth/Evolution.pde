// The evolution procedures. Many of these procedures do more than one thing for performance reasons.

void gravityAndGrowth() {
  for (int y = 0; y < heightInCells; y++) {
    for (int x = 0; x < widthInCells; x++) {
      Cell c = cells[y][x];
      if (c == null) {
        if (y > 0 && cells[y-1][x] != null && cells[y-1][x].affectedByGravity()) {
          // Gravity
          cellsNext[y][x] = cells[y-1][x];
          cellsNext[y-1][x] = null;
        } else {
          // See Algorithms
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
        // Possibly sprout the seed
        if (isType(x, y+1, "soil") && isType(x, y-1, "empty") && random(1) < SPROUTING_PROBABILITY) {
          cellsNext[y][x] = new YoungPlantCell(SEED_SPROUT_INITIAL_NUTRITION, c.species, x, y);
          cellsNext[y+1][x] = new RootCell(SEED_SPROUT_INITIAL_NUTRITION, c.species, x, y+1);
        }
      } else if (c.type() == "youngPlant" || c.type() == "oldPlant") {
        // Photosynthesize
        cellsNext[y][x].nutrition += numAirNeighbours(x, y) * PHOTOSYNTHESIS_SPEED[c.species] * LIGHT_AMOUNT - LIVING_COST[c.species];
      }
    }
  }
}

void nutritionDistribution() {
  // I know this nested for loop is in a confusing place, but it's the best place to put it
  for (int y = 0; y < heightInCells; y++) {
    for (int x = 0; x < widthInCells; x++) {
      // Set the new nutrition values (found in Algorithms)
      newNutrition[y][x] = cells[y][x] == null ? 0 : cells[y][x].nutrition;
    }
  }
  
  // Calls absorbNutrition found in Algorithms
  for (int y = 0; y < heightInCells; y++) {
    for (int x = 0; x < widthInCells; x++) {
      Cell c = cells[y][x];
      if (c == null) {
        continue;
      } else {
        absorbNutrition(x, y);
      }
    }
  }

  // Set new nutrition values
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
        
        if (isType(x, y, "youngPlant") && cellsNext[y][x].age > MATURITY_AGE[cells[y][x].species]) {
          // Transform into an old plant cell
          Cell prev = cellsNext[y][x];
          cellsNext[y][x] = new OldPlantCell(prev.nutrition, prev.species, x, y);
          // Inherit age
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
          float decompositionProbability = DECOMPOSITION_PROBABILIY;
          // Different death/decomposition probability for root cells and petal cells
          if (isType(x, y, "root")) {
            deathProbability = log(c.age) * ROOT_DEATH_CONSTANT / (c.nutrition + 0.01);
          } else if (isType(x, y, "petal")) {
            deathProbability = cells[y][x].age * log(c.age) * DEATH_CONSTANT / (c.nutrition + 0.01);
            decompositionProbability = 0;
          }
          
          // Possibly die, possibly decompose
          if (random(1) < deathProbability) {
            if (c.nutrition > 30 && random(1) < decompositionProbability) {
              cellsNext[y][x] = new DeadPlantCell(c.nutrition, x, y);
            } else {
              cellsNext[y][x] = null;
            }
          }
        } else if (isType(x, y, "deadPlant")) {
          // Return to the soil
          DeadPlantCell deadCell = (DeadPlantCell) c;
          if (c.age >= deadCell.decompositionTime) {
            cellsNext[y][x] = new SoilCell(c.nutrition, x, y);
          }
        }
      }
    }
  }
}
