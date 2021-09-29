class Particle {
  PVector pos;
  PVector velocity;
  float maxSpeed;
  float friction;
  
  Particle(float x, float y, float maxSpeed, float friction, PVector initialVelocity) {
    //declare initial values including initial velocity
    this.pos = new PVector(x, y);
    this.maxSpeed = maxSpeed;
    this.friction = friction;
    this.velocity = initialVelocity != null ? initialVelocity : new PVector(0, 0);
  }
  
  boolean checkChunk(int canvas, int chunkX, int chunkY) {
    //check if particle is within a certain chunk boundary
    if (this.pos.x > ((canvas / 5) * chunkX) && this.pos.x <= ((canvas / 5) * (chunkX + 1)) && this.pos.y > ((canvas / 5) * chunkY) && this.pos.y <= ((canvas / 5) * (chunkY + 1))) {
      return true;
    } else {
      return false;
    }
  }
  
  void accelerate(PVector acceleration) {
    //add acceleration to velocity and add velocity to position (using lerp to interpolate friction)
    this.velocity.add(acceleration != null ? acceleration : new PVector(0, 0));
    this.velocity.limit(this.maxSpeed);
    this.velocity.x = lerp(this.velocity.x, 0, 0.01);
    this.velocity.y = lerp(this.velocity.y, 0, 0.01);
    this.pos.add(velocity);
  }
  
  void update() {
    //render and update acceleration
    accelerate(null);
    ellipse(this.pos.x, this.pos.y, 5, 5);
  }
}
