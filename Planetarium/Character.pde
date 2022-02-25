abstract class Entity {
  PVector position;
  
  public Entity(PVector pos) {
    this.position = pos;
  }
  
  abstract void display(int x, int y);
}

class Person extends Entity {
  
  public Person(PVector pos) {
    super(pos);
  }
  
  void display(int x, int y) {
    fill(232, 235, 52);
    rect(x*cellSize, y*cellSize, cellSize, cellSize);
  }
  
}

class SpaceShip extends Entity {
  
  public SpaceShip(PVector pos) {
    super(pos);
  }
  
  void display(int x, int y) {
    fill(53, 180, 240);
    rect(x*cellSize, y*cellSize, cellSize, cellSize);
  }
  
}

class Block extends Entity {
  
  Planet planet;
  color c;
  
  public Block(PVector pos, Planet planet, color c) {
    super(pos);
    this.planet = planet;
    this.c = c;
  }
  
  void display(int x, int y) {
    fill(c);
    rect(x*cellSize, y*cellSize, cellSize, cellSize);
  }
  
}
