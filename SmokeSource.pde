class SmokeSource {
  PVector pos;
  int rate;
  
  SmokeSource(float x, float y, int rate) {
    this.pos = new PVector(x, y);
    this.rate = rate;
  }
  
  ArrayList<Particle> update(ArrayList<Particle> globalParticles, int canvas) {
    //create a copy of global particle list to update
    ArrayList<Particle> particleArray = new ArrayList<Particle>(globalParticles);
    //generate new smoke particles 50% of the time
    for (int i = 0; i < this.rate; i++) {
      if (int(random(1.1)) == 1) {
        particleArray.add(new Particle(this.pos.x + (int(random(-10, 11))), this.pos.y + (int(random(-10, 11))), 100, 1, PVector.fromAngle(random(0, 2*PI)).setMag(2)));
      }
    }
    //run update function on all particles
    for (Particle particle : particleArray) {
      particle.update();
    }
    for (int i = 0; i < 5; i++) {                                              //for every chunk
      for (int j = 0; j < 5; j++) {
        ArrayList<Particle> chunkParticles = new ArrayList<Particle>();
        for (Particle particle : particleArray) {                             //add particles in chunk too chunkParticles arraylist
          if (particle.checkChunk(canvas, i, j)) {
            chunkParticles.add(particle);
          }
        }
        if (chunkParticles.size() > 1) {                                      //if more than one particle is in the chunk, make a temporary particle arraylist without current particle
          for (int k = 0; k < chunkParticles.size(); k++) {
            ArrayList<Particle> tempParticles = new ArrayList<Particle>(chunkParticles);
            tempParticles.remove(k);
            Particle current = chunkParticles.get(k);
            for (Particle other : tempParticles) {
              if (dist(current.pos.x, current.pos.y, other.pos.x, other.pos.y) <= 5) { //if distance to other particle is more than radius of particle (5) transfer velocities
                PVector previousVelocity = current.velocity;
                current.velocity = other.velocity;
                other.velocity = previousVelocity;
              }
            }
          }
        }
      }
    }
    return particleArray;
  }
}
