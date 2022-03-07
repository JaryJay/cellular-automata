int numAirNeighbours(int x, int y) {
  int count = 0;
  for (int i = max(0, y - 1); i <= min(heightInCells - 1, y + 1); i++) {    
    for (int j = max(0, x - 1); j <= min(widthInCells - 1, x + 1); j++) {
      if (cells[i][j] == null && !(i == y && j == x)) {
        count++;
      }
    }
  }
  return count;
}

//int (int x, int y,  
