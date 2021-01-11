class Token{
  private float xPos;
  private float yPos;
  private float radius;
  private char ch;
  
  public Token(float ex, float why, float r, char karacter)
  {
    xPos = ex;
    yPos = why;
    radius = r;
  }
  
  void display()
  {
    
    if (a.tokenCounter + b.tokenCounter == (numTokens-1))
    {
    fill(random(0,255),random(0,255),random(0,255));
    ellipse(xPos, yPos, radius, radius);
    }
    else 
    {  
    fill(255,215,0);
    ellipse(xPos, yPos, radius, radius);
    textSize(radius*0.5);
    fill(212, 50, 12);
    text(ch, xPos-radius*0.25+2, yPos+radius*0.25-1);
    }
  }
  
  void disappear()
  {
    xPos = 2000;
    yPos = 2000;
    radius = 0.1;
  }
  
  void beOnPlat(Platform Plat)
  {
    xPos = Plat.xTopLeft + Plat.lengthvalue/2;
    yPos = Plat.yTopLeft - 20;
    
  }  
}
