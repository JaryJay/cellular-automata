

void generatePlanets() {
  for (int i = 0; i < numPlanets; i++) {
    int radius = int(random(minPlanetRadius, maxPlanetRadius + 1));

    int planetX = int(random(radius, worldWidth - radius + 1));
    int planetY = int(random(radius, worldHeight - radius + 1));

    Planet planet  =new Planet(new PVector(planetX, planetY), 0);

    color c = planetColours[int(random(planetColours.length))];

    for (int x = planetX - radius; x <= planetX + radius; x++) {
      for (int y = planetY - radius; y <= planetY + radius; y++) {
        if (dist(x, y, planetX, planetY) <= radius) {
          Block block = generateBlock(x, y, planet, radius, c);
          characters[y][x] = block;
          planet.mass++;
        }
      }
    }
  }
}

private Block generateBlock(int x, int y, Planet planet, int radius, color c) {
  Block block = null;
  if (dist(x, y, planet.position.x, planet.position.y) <= 5) {
    block = new Block(new PVector(x, y), planet, color(255, 0, 0));
  } else if (dist(x, y, planet.position.x, planet.position.y) >= radius * 0.94) {
    block = new Block(new PVector(x, y), planet, color(140, 124, 65));
  } else {
    block = new Block(new PVector(x, y), planet, c);
  }
  return block;
}
