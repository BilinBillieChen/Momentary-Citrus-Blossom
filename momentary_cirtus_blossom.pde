import processing.sound.*;

AudioIn in;
Amplitude amp;
int numParticles = 200;
Particle[] particles;

void setup() {
  size(800, 600);
  background(0);
  smooth();
  
  // Initialize the audio input
  in = new AudioIn(this, 0);
  in.start();
  
  // Initialize amplitude detection
  amp = new Amplitude(this);
  amp.input(in);
  
  particles = new Particle[numParticles];
  for (int i = 0; i < numParticles; i++) {
    particles[i] = new Particle(random(width), random(height));
  }
}

void draw() {
  background(0, 10); // Slight transparency to create the ink effect
  
  float amplitude = amp.analyze(); // Get the current amplitude level
  float colorShift = amplitude * 255 * 2;
  
  for (Particle p : particles) {
    p.update(amplitude);
    p.display(colorShift);
  }
}

class Particle {
  float x, y;
  float xSpeed, ySpeed;
  
  Particle(float x, float y) {
    this.x = x;
    this.y = y;
    this.xSpeed = random(-200, 200);
    this.ySpeed = random(-200, 200);
  }
  
  void update(float amplitude) {
    x += xSpeed * amplitude;
    y += ySpeed * amplitude;
    
    if (x < 0 || x > width) xSpeed *= -1;
    if (y < 0 || y > height) ySpeed *= -1;
  }
  
  void display(float colorShift) {
    noStroke();
    fill(colorShift, 100, 255 - colorShift, 150);  // Adjust color based on amplitude
    ellipse(x, y, 80, 80);
  }
}
