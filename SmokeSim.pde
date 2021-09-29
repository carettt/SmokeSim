// Create global particle list
ArrayList<Particle> globalParticles = new ArrayList<Particle>();

void setup() {
  size(500, 500);
}

void draw() {
  //create a smoke source in the center of the screen and update global particle list every frame
  background(50);
  SmokeSource source = new SmokeSource(250, 250, 10);
  globalParticles = new ArrayList<Particle>(source.update(globalParticles, 500));
}
