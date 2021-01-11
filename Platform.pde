class Platform {
  private float lengthvalue;
  private static final float heightvalue = 5; 
  private float xTopLeft;
  private float yTopLeft;
  private boolean hasToken = false;

  public Platform(float lengthval, float xcord, float ycord)
  {
    lengthvalue = lengthval;
    xTopLeft = xcord;
    yTopLeft = ycord;
  }
  // returns bottom right y-coordinate of the 
  public float bottomy()
  {
    return yTopLeft+heightvalue;
  }
  public float bottomx()
  {
    return xTopLeft+lengthvalue;
  }
  public float y()
  {
    return yTopLeft;
  }
  public float x()
  {
    return xTopLeft;
  }
  public void display()
  {

    fill(xTopLeft/3,0,yTopLeft/3);
    rect (xTopLeft, yTopLeft, lengthvalue, heightvalue);
  }

  public void randomize(int xmin, int xmax, int ymin, int ymax)
  {
    xTopLeft = random(xmin, xmax);
    yTopLeft = random(ymin, ymax-15);
  }
  
  public void randomize()
  {
    lengthvalue = random(15,40);
    xTopLeft = random(0, width-lengthvalue);
    yTopLeft = random(0, height-15);
  }
  
  public boolean overlapping(Platform other)
  {
    float bottomright1x = xTopLeft+lengthvalue;
    float bottomright1y = yTopLeft+heightvalue;
    float bottomright2x = other.yTopLeft+other.lengthvalue;
    float bottomright2y = other.yTopLeft+heightvalue;

    if (xTopLeft > bottomright2x || other.xTopLeft > bottomright1x)
    {
      return false;
    }
    if (yTopLeft > bottomright2y || other.yTopLeft > bottomright1y)
    {
      return false;
    }
    return true;
  }

  public void overlappingsetup(Platform[] other, int x) //lenny setup method
  {
    for (int j=0; j<x; j++)
    {
      while (this.overlapping(other[j]))
      { 
        this.randomize();
        j=0;
      }
    }
  }
  
  public int getLengthValue()
  {
    return (int) lengthvalue;
  }
  
  public void gridSetup(int pixAddX,int pixAddY) //tommy setup method
  {
    int XpixHigh = pixAddX;
    int XpixLow = 0;
    int YpixHigh = pixAddY +pixAddY; // this skips very top left
    int YpixLow = pixAddY;
    int randLength = (int) random(10,pixAddX-5);
    int i = 1;
    int countertest = 0;
    
    while (i<Platforms.length)
    { 
      while (XpixHigh<=width)
      {
        println(i);  
        while (YpixHigh<=height)
        {
            
          if (pixAddX<50)
          {
            randLength = (int) random(10,pixAddX-10);
          }
          else
          {
            randLength = (int) random(10,60);
          }  
       
          Platforms[i] = new Platform(randLength,0,0);
          Platforms[i].randomize(XpixLow ,XpixHigh - Platforms[i].getLengthValue(), YpixLow + 5 ,YpixHigh - 10);
          rect(Platforms[i].xTopLeft, Platforms[i].yTopLeft+15, 5,5);
          YpixLow += pixAddY; //move down collumn.
          YpixHigh += pixAddY;
          i++;
          
        }
        XpixLow += pixAddX; // move to next collumn
        XpixHigh += pixAddX;
        YpixLow = 0; //reset y to top of screen
        YpixHigh = pixAddY;
        //YpixHigh = pixAddY + pixAddY; // this skips very top left
        //YpixLow = pixAddY;
      }
    }
  }  
}
