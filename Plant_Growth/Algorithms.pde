import java.util.List; //<>//

boolean isType(int x, int y, String type) {
  if (x >= 0 && x < widthInCells && y >= 0 && y < heightInCells) {
    return cells[y][x] == null ? (type.equals("empty")) : (cells[y][x].type() == type);
  }
  return false;
}

boolean isPlantCell(int x, int y) {
  if (x >= 0 && x < widthInCells && y >= 0 && y < heightInCells) {
    return (!isType(x, y, "empty")) && !isType(x, y, "deadPlant") && !isType(x, y, "soil") && !isType(x, y, "seed");
  }
  return false;
}

int numAirNeighbours(int x, int y) {
  int count = 0;
  for (int i = y - 1; i <= y + 1; i++) {
    for (int j = x - 1; j <= x + 1; j++) {
      if (!(i == y && j == x) && isType(j, i, "empty")) {
        count++;
      }
    }
  }
  return count;
}

List<Cell> adjacentPlantCells(int x, int y) {
  List<Cell> adj = new ArrayList<Cell>();
  int j = x-1, i = y;
  if (isPlantCell(j, i))
    adj.add(cells[i][j]);

  j = x+1;
  if (isPlantCell(j, i))
    adj.add(cells[i][j]);

  j = x;
  i = y-1;
  if (isPlantCell(j, i))
    adj.add(cells[i][j]);

  i=y+1;
  if (isPlantCell(j, i))
    adj.add(cells[i][j]);

  return adj;
}

List<Cell> adjacentPlantCellsAndSoil(int x, int y) {
  List<Cell> adj = new ArrayList<Cell>();
  int j = x-1, i = y;
  if (isPlantCell(j, i) || isType(j, i, "soil"))
    adj.add(cells[i][j]);

  j = x+1;
  if (isPlantCell(j, i) || isType(j, i, "soil"))
    adj.add(cells[i][j]);

  j = x;
  i = y-1;
  if (isPlantCell(j, i) || isType(j, i, "soil"))
    adj.add(cells[i][j]);

  i=y+1;
  if (isPlantCell(j, i) || isType(j, i, "soil"))
    adj.add(cells[i][j]);

  return adj;
}

// Determines whether or not the cell at x, y should grow into either
// a young plant cell, a petal cell, a root cell, or a flower cell
Cell possiblyGrow(int x, int y) {
  float totalNutrition = 0;
  int species = 0;
  if (cells[y][x] == null) {

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
    float growthProbability = -0.2 * totalNutrition * 0.01 * (totalNutrition * 0.01 - 4);
    float rand = random(1);
    //println(rand, );
    if (rand < growthProbability * GROWTH_FACTOR[species]) {
      return new YoungPlantCell(0, species, x, y);
    } else if (rand < (growthProbability + totalNutritionForPetals) * GROWTH_FACTOR[species]) {
      return new PetalCell(0, species, x, y);
    }
  } else if (cells[y][x].type() == "soil") {
    int age = Integer.MAX_VALUE;
    // Check cell to the left
    if (isType(x-1, y, "root") && cells[y][x-1].age < MAX_ROOT_GROWTH_AGE) {
      totalNutrition += cells[y][x-1].nutrition * 0.06;
      species = cells[y][x-1].species;
      age = min(age, cells[y][x-1].age);
    }

    // Check cell to the right
    if (isType(x+1, y, "root") && cells[y][x+1].age < MAX_ROOT_GROWTH_AGE) {
      totalNutrition += cells[y][x+1].nutrition * 0.06;
      species = cells[y][x+1].species;
      age = min(age, cells[y][x+1].age);
    }

    // Check above cell
    if (isType(x, y-1, "root") && cells[y-1][x].age < MAX_ROOT_GROWTH_AGE) {
      totalNutrition += cells[y-1][x].nutrition;
      species = cells[y-1][x].species;
      age = min(age, cells[y-1][x].age);
    }
    totalNutrition = min(100, totalNutrition);
    float growthProbability = -0.6 * totalNutrition * 0.01 * (totalNutrition * 0.01 - 1);
    float rand = random(1);
    if (rand < growthProbability * ROOT_GROWTH_FACTOR[species]) {
      RootCell r = new RootCell(0, species, x, y);
      r.age = age;
      r.nutrition = cells[y][x].nutrition;
      return r;
    }
  } else if (cells[y][x].type() == "oldPlant") {
    if (numAirNeighbours(x, y) >= 5 && isType(x, y+1, "empty")) {
      float growthProbability = cells[y][x].age * FLOWERING_PROBABILITY[species] * (cells[y][x].nutrition - MIN_FLOWERING_NUTRITION) * 0.01;
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
