abstract class Entity {
  PVector position;
  
  public Entity(PVector pos) {
    this.position = pos;
  }
}

class Person extends Entity {
  
  public Person(PVector pos) {
    super(pos);
  }
  
}

class SpaceShip extends Entity {
  
  public SpaceShip(PVector pos) {
    super(pos);
  }
  
}

class Block extends Entity {
  
  public Block(PVector pos) {
    super(pos);
  }
  
}
