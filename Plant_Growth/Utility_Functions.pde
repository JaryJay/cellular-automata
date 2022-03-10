import java.util.List;

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
