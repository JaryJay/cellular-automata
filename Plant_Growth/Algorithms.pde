import java.util.List;

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
  List<Cell> adj = new ArrayList<>();
  for (int i = y - 1; i <= y + 1; i++) {
    for (int j = x - 1; j <= x + 1; j++) {
      if (!(i == y && j == x) && !isType(j, i, "empty") && !isType(j, i, "deadPlant") && !isType(j, i, "soil")) {
        adj.add(cells[j][i]);
      }
    }
  }
  return adj;
}

List<Cell> adjacentPlantCellsAndSoil(int x, int y) {
  List<Cell> adj = new ArrayList<>();
  for (int i = y - 1; i <= y + 1; i++) {
    for (int j = x - 1; j <= x + 1; j++) {
      if (!(i == y && j == x) && !isType(j, i, "empty") && !isType(j, i, "deadPlant")) {
        adj.add(cells[j][i]);
      }
    }
  }
  return adj;
}

boolean isType(int x, int y, String type) {
  if (x >= 0 && x < widthInCells && y >= 0 && y < heightInCells) {
    return cells[y][x] == null ? (type == "empty") : (cells[y][x].type() == type);
  }
  return false;
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
    } else if (isType(x-1, y, "flower") || isType(x-1, y, "petal")) {
      totalNutritionForPetals += cells[y][x-1].nutrition;
      species = cells[y][x-1].species;
    }

    // Check cell to the right
    if (isType(x+1, y, "youngPlant")) {
      totalNutrition += cells[y][x+1].nutrition;
      species = cells[y][x+1].species;
    } else if (isType(x+1, y, "flower") || isType(x+1, y, "petal")) {
      totalNutritionForPetals += cells[y][x+1].nutrition;
      species = cells[y][x+1].species;
    }

    // Check below cell
    if (isType(x, y+1, "youngPlant")) {
      totalNutrition += cells[y+1][x].nutrition;
      species = cells[y+1][x].species;
    } else if (isType(x, y+1, "flower") || isType(x, y+1, "petal")) {
      totalNutritionForPetals += cells[y-1][x].nutrition;
      species = cells[y+1][x].species;
    }

    // Decide whether to return a young plant cell or petal cell or neither
    float rand = random(100);
    if (rand < totalNutrition * GROWTH_FACTOR) {
      return new YoungPlantCell(0, species);
    } else if (rand < (totalNutrition + totalNutritionForPetals) * GROWTH_FACTOR) {
      return new PetalCell(0, species);
    }
  } else if (cells[y][x].type() == "soil") {

    // Check cell to the left
    if (isType(x-1, y, "root")) {
      totalNutrition += cells[y][x-1].nutrition;
      species = cells[y][x-1].species;
    }

    // Check cell to the right
    if (isType(x+1, y, "root")) {
      totalNutrition += cells[y][x+1].nutrition;
      species = cells[y][x+1].species;
    }

    // Check above cell
    if (isType(x, y-1, "root")) {
      totalNutrition += cells[y-1][x].nutrition;
      species = cells[y-1][x].species;
    }
    float rand = random(100);
    if (rand < totalNutrition  * GROWTH_FACTOR) {
      return new RootCell(0, species);
    }
  }
  return cells[y][x];
}

//int (int x, int y,
