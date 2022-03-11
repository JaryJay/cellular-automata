// Determines whether or not the cell at x, y should grow into either //<>//
// a young plant cell, a petal cell, a root cell, or a flower cell
Cell possiblyGrow(int x, int y) {
  float totalNutrition = 0;
  int species = 0;
  if (cells[y][x] == null) {
    
    if (numAdjYoungOldPlantCells(x, y) >= 3) {
      return null;
    }

    // Used to determine whether to transform the air cell into
    // a young plant cell or a petal cell
    float totalNutritionForPetals = 0;

    // Check cell to the left
    if (isType(x-1, y, "youngPlant")) {
      totalNutrition += cells[y][x-1].nutrition;
      species = cells[y][x-1].species;
    } else if (isType(x-1, y, "flower")) {
      totalNutritionForPetals += cells[y][x-1].nutrition;
      species = cells[y][x-1].species;
    }

    // Check cell to the right
    if (isType(x+1, y, "youngPlant")) {
      totalNutrition += cells[y][x+1].nutrition;
      species = cells[y][x+1].species;
    } else if (isType(x+1, y, "flower") ) {
      totalNutritionForPetals += cells[y][x+1].nutrition;
      species = cells[y][x+1].species;
    }

    // Check below cell
    if (isType(x, y+1, "youngPlant")) {
      totalNutrition += cells[y+1][x].nutrition;
      species = cells[y+1][x].species;
    } else if (isType(x, y+1, "flower") ) {
      totalNutritionForPetals += cells[y+1][x].nutrition;
      species = cells[y+1][x].species;
    }
    // Decide whether to return a young plant cell or petal cell or neither
    float z = totalNutrition * 0.01;
    //float growthProbability = (0.055 * (1.92*z-1.1) * (1.92*z-5.8) * (1.92*z-2.1) + 0.726) * GROWTH_FACTOR[species];
    float growthProbability = z * GROWTH_FACTOR[species];
    //float
    float petalGrowthProbability = totalNutritionForPetals * GROWTH_FACTOR[species];
    //float growthProbability = totalNutrition * 0.01 * GROWTH_FACTOR[species];
    float rand = random(1);
    //println(rand, );
    if (rand < growthProbability) {
      return new YoungPlantCell(0, species, x, y);
    } else if (rand < growthProbability + petalGrowthProbability) {
      return new PetalCell(0, species, x, y);
    }
  } else if (cells[y][x].type() == "soil") {
    
    if (numAdjRootCells(x, y) >= 2) {
      return cells[y][x];
    }
    
    // Check cell to the left
    if (isType(x-1, y, "root") && cells[y][x-1].age < MAX_ROOT_GROWTH_AGE) {
      species = cells[y][x-1].species;
      totalNutrition += cells[y][x-1].nutrition * (1-DOWNWARD_GROWTH_BIAS[species]);
    }

    // Check cell to the right
    if (isType(x+1, y, "root") && cells[y][x+1].age < MAX_ROOT_GROWTH_AGE) {
      species = cells[y][x+1].species;
      totalNutrition += cells[y][x+1].nutrition * (1-DOWNWARD_GROWTH_BIAS[species]);
    }

    // Check above cell
    if (isType(x, y-1, "root") && cells[y-1][x].age < MAX_ROOT_GROWTH_AGE) {
      species = cells[y-1][x].species;
      totalNutrition += cells[y-1][x].nutrition * (2*DOWNWARD_GROWTH_BIAS[species]);
    }
    totalNutrition = min(100, totalNutrition);
    float growthProbability = totalNutrition * 0.01 * ROOT_GROWTH_FACTOR[species];
    float rand = random(1);
    if (rand < growthProbability) {
      RootCell r = new RootCell(0, species, x, y);
      r.nutrition = cells[y][x].nutrition;
      return r;
    }
  } else if (cells[y][x].type() == "oldPlant") {
    if (numAirNeighbours(x, y) >= 5 && isType(x, y+1, "empty")) {
      float growthProbability = log(cells[y][x].age) * FLOWERING_PROBABILITY[species] * (cells[y][x].nutrition - MIN_FLOWERING_NUTRITION) * 0.01;
      float rand = random(1);
      if (rand < growthProbability) {
        return new FlowerCell(0, cells[y][x].species, x, y);
      }
    }
  } else if (cells[y][x].type() == "flower") {
    if (cells[y][x].age == 120) {
      if (random(1) < POLLINATION_PROBABILITY) {
        return new SeedCell(cells[y][x].species, x, y);
      } else {
        return new DeadPlantCell(cells[y][x].nutrition, 50, x, y);
      }
    }
  }
  return cells[y][x];
}

float[][] newNutrition = new float[heightInCells][widthInCells];

void absorbNutrition(int x, int y) {
  Cell c = cells[y][x];
  if (c.type() == "root") {
    for (Cell adj : adjacentPlantCellsAndSoil(x, y)) {
      if (adj.nutrition > c.nutrition) {
        float diff = adj.nutrition - c.nutrition;
        newNutrition[y][x] += diff * 0.2 * ROOT_DISTRIBUTION_SPEED;
        newNutrition[adj.y][adj.x] -= diff * 0.2 * ROOT_DISTRIBUTION_SPEED;
      }
    }
  } else if (isPlantCell(x, y)) {
    for (Cell adj : adjacentPlantCells(x, y)) {
      if (adj.nutrition > c.nutrition) {
        float diff = adj.nutrition - c.nutrition;
        newNutrition[y][x] += diff * 0.2 * DISTRIBUTION_SPEED;
        newNutrition[adj.y][adj.x] -= diff * 0.2 * DISTRIBUTION_SPEED;
      }
    }
  }
}
