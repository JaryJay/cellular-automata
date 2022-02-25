int numPlanets = 3;
int cellSize = 5;

Entity[][] characters;


void setup() {
  size(900, 900);
  characters = new Entity[height / cellSize][width / cellSize];
  generatePlanets();
}

void draw() {
  for (int i = 0; i < characters.length; i++) {
    for (int j = 0; j < characters[i].length; j++) {
      
    }
  }
}
