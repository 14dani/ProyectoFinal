class Ball{
  
  Body body;
  float r;
  boolean activarPortal;
  PImage img;
  
  //constructor
  Ball(float x_, float y_, float r_){
    float x = x_;
    float y = y_;
    
    
    img = loadImage("Pelota.png");
    r = img.width / 2;
    
    makeBody(new Vec2(x,y),r);
    body.setUserData(this); //nombre de clase apellido Ball
    
  }
  
  
  void potenciaDisparo(float potencia){
    //give it some initial random velocity
    body.setLinearVelocity(new Vec2(0,potencia));
    body.setAngularVelocity(random(-10,10));
  }
  
  
  void killBody(){
    box2d.destroyBody(body);
  }
  
  
  void teletransportar() {
    activarPortal = true;
  }
  
  
  boolean getActivarPortal() {
    return activarPortal;
  }
  
  
  void portal(float _x, float _y) {
    body.setTransform(box2d.coordPixelsToWorld(new Vec2(_x, _y)), 0);
    activarPortal = false;
  }
  
  
  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height-30) {
      return true;
    }
    return false;
  }
  
  boolean contains(float x, float y){
    Vec2 worldPoint = box2d.coordPixelsToWorld(x,y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;
  }
  
  
  void display(){
    //we look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    //Get its angle of rotations
    float a = body.getAngle();
    
    //ellipseMode(CENTER);
    //noStroke();
    //fill(0);
    
    //pushMatrix();
    //translate(pos.x, pos.y);
    //rotate(a);
    //circle(0,0,r*2);
    //popMatrix();
    
    imageMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    image(img,0,0);
    popMatrix();
    
    
  }
  
  
  void makeBody(Vec2 center, float r){
    //Define and create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);
    
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    //Define a fixture
    FixtureDef fd = new FixtureDef();
    //fd.shape = sd;
    fd.shape = cs;
    
    //Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    
    body.createFixture(fd);
    body.isBullet();
    
    //body.setLinearVelocity(new Vec2(0,-80));
    //body.setAngularVelocity(random(-10,10));
    
  }
}
