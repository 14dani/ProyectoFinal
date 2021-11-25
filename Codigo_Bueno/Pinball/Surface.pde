//creates the outside of the levels
class Surface
{

 ArrayList<Vec2> superficie;


    //constructor arcos 
    Surface(float _x,float _y, float _r, int _beginAngle, int _endAngle){
    superficie = new ArrayList<Vec2>();
    
    ChainShape chain = new ChainShape();
    
    for (float x = _beginAngle; x < _endAngle; x += 5) {
      float pX = _x + cos(radians(x))*_r;
      float pY = _y + sin(radians(x))*_r;
      superficie.add(new Vec2(pX,pY));
    }
    
    //Se crean vertice
    Vec2[] vertices = new Vec2[superficie.size()];
    for (int i = 0; i < vertices.length; i++) {
      Vec2 edge = box2d.coordPixelsToWorld(superficie.get(i));
      vertices[i] = edge;
    }
    
    //Se crea la cadena
    chain.createChain(vertices,vertices.length);

    BodyDef bd = new BodyDef();
    bd.position.set(0.0f,0.0f);
    Body body = box2d.createBody(bd);
    body.createFixture(chain,1);
    body.setUserData(this);
  }
  
  
  //Una superficie totalmente personalizada
  Surface(ArrayList<Vec2> _puntos) {
    superficie = _puntos; //new ArrayList<Vec2>(); 
    //println(_puntos.size());
    
    ChainShape chain = new ChainShape();

    Vec2[] vertices = new Vec2[_puntos.size()];
    for (int i = 0; i < vertices.length; i++) {
      println(_puntos.get(i));
      Vec2 edge = box2d.coordPixelsToWorld(_puntos.get(i));
      vertices[i] = edge;
    }
    
    chain.createChain(vertices,vertices.length);

    BodyDef bd = new BodyDef();
    bd.position.set(0.0f,0.0f);
    Body body = box2d.createBody(bd);
    body.createFixture(chain,1);
    body.setUserData(this);
  }
  
  
  void display() {
    strokeWeight(2);
    stroke(255);
    noFill();
    beginShape();
    for (Vec2 v: superficie) {
      vertex(v.x,v.y);
    }
    endShape();
  }
  
}
