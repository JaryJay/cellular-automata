int numPlanets = 11;
int cellSize = 1;
int worldWidth = 1000;
int worldHeight = 800;
int minPlanetRadius = 50;
int maxPlanetRadius = 100;
color[] planetColours = { color(163, 142, 16), color(153, 133, 89), color(164, 204, 161), color(101, 175, 240) };

Entity[][] characters;

void settings() {
  size(cellSize * worldWidth, cellSize * worldHeight);
}

void setup() {
  characters = new Entity[worldHeight][worldWidth];
  generatePlanets();
  
  noStroke();
}

void draw() {
  background(0, 0, 0);
  for (int i = 0; i < characters.length; i++) {
    for (int j = 0; j < characters[i].length; j++) {
      if (characters[i][j] != null) {
        characters[i][j].display(j, i);
      }
    }
  }
}
