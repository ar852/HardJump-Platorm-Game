// this class does everything that the other character class does, just with different key inputs
class CharacterB {
  private float x;
  private float y;
  private float dx;
  private float dy;
  private float xbuild = 0;
  private float ybuild = 0;
  private float holdvalue = 0;
  private boolean onplatform = true;
  private static final int wide = 20;
  private float tall = 20;
  private boolean w = false;
  private boolean a = false;
  private boolean d = false;
  private int tokenCounter = 0;



  public CharacterB(float xcord, float ycord, float xvelocity, float yvelocity, float holdframe, boolean platform)
  {
    x = xcord;
    y = ycord;
    dx = xvelocity;
    dy = yvelocity;
    holdvalue = holdframe;
    onplatform = platform;
  }

  public void display()
  {
    rect (x, y, wide, tall, 5);
  }

  public void bouncex()
  {
    if (x >= width - wide || x <= 0)
    {
      dx = -dx;
    }

    if (x>width-wide)
    {
      x=width-wide-1;
    }
    if (x<0)
    {
      x=1;
    }
  }

  public void bouncey()
  {
    if (y >= height - wide)
    {
      dy = 0;
      dx = 0;
      onplatform = true;
    }


    if (y>height-wide)
    {
      y=height-wide-1;
    }

  }

  public void gravity()
  {
    if (!onplatform)
    {
      dy = dy + 0.5;
    }
  }
  public void move()
  {
    x = dx + x;
    y = dy + y;
  }
  public float bottomy()
  {
    return y+wide;
  }
  public float bottomx()
  {
    return x+wide;
  }
  public float x()
  {
    return x;
  }
  public float y()
  {
    return y;
  }
  public float dy()
  {
    return dy;
  }
  public boolean onplatformornot()
  {
    return onplatform;
  }  
  public boolean w()
  {
    return w;
  }  
  public boolean a()
  {
    return a;
  }  
  public boolean d()
  {
    return d;
  }  
  public void collidetop(float yplatform)
  {
    dx=0;
    dy=0;
    y=yplatform-wide;
    onplatform = true;
  }  
  public void collidebottom(float yplatform)
  {
    dy = dy*-0.8;
    y=yplatform+wide;
  }
  public void upbooleanfalse()
  {
    w = false;
  }
  public void leftbooleanfalse()
  {
    a = false;
  }
  public void rightbooleanfalse()
  {
    d = false;
  }
  public void upbooleantrue()
  {
    w = true;
  }
  public void leftbooleantrue()
  {
    a = true;
  }
  public void rightbooleantrue()
  {
    d = true;
  }

  public void xstoreleft()
  {
    if (xbuild>-7)
    {
      xbuild = xbuild - 0.4;
    }
    holdvalue ++;
  }
  public void xstoreright()
  {
    if (xbuild<7)
    {
      xbuild = xbuild + 0.4;
    }
    holdvalue ++;
  }
  public void ystore()
  {
    if (ybuild>-13)
    {
      ybuild = ybuild - 0.4;
    }
    holdvalue ++;
  }

  public void jump() 
  {
    if (!w && !a && !d)
    {
      if (holdvalue>0)
      {
        dy = ybuild;
        dx = xbuild;
        ybuild = 0;
        xbuild = 0;
        holdvalue = 0;
        onplatform = false;
        tall = 20;
      }
    }
  }
  boolean touchingToken(Token T) {
    float[] TL = {x, y};
    float[] TR = {x+wide, y};
    float[] BL = {x, y+tall};
    float[] BR = {x+wide, y+tall};

    if (
      T.radius>findDistance(T.xPos, T.yPos, TL) ||
      T.radius>findDistance(T.xPos, T.yPos, TR) ||
      T.radius>findDistance(T.xPos, T.yPos, BL) ||
      T.radius>findDistance(T.xPos, T.yPos, BR) 
      )
    {
      tokenCounter +=1;
      return true;
    } else {
      return false;
    }
  }

  void checkTouchingAllTokens() {
    for (int i=0; i<manyTokens.length; i++) {
      if (touchingToken(manyTokens[i])) {
        tokenSound.rewind();
        tokenSound.play();
        manyTokens[i].disappear();
      }
    }
  }  

  void displayTokenCounter(int xPos, color c) {
    textSize(50);
    fill(c);
    text(this.tokenCounter, xPos, 60.0);
  }

  float findDistance(float x, float y, float[] b) {
    float x1 = x;
    float x2 = b[0];
    float y1 = y;
    float y2 = b[1];

    return (float)Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2) * 1.0);
  }

  public void collideplatform()
  {
    for (int i=0; i<Platforms.length; i++)
    {
      if (b.x() > Platforms[i].bottomx() || Platforms[i].x() > b.bottomx())
      {
      } else if (b.y() > Platforms[i].bottomy() || Platforms[i].y() > b.bottomy())
      {
      } else if (!b.onplatformornot())
      {
        if (b.dy()>0)
        {
          b.collidetop(Platforms[i].y());
        }
        if (b.dy()<0)              
        {
          b.collidebottom(Platforms[i].y());
        }
      }
    }
  }
  public void exist()
  {
    b.bouncey();
    b.bouncex();
    b.gravity();
    b.move();
    b.collideplatform();
    if (b.w()==true )
    {
      b.ystore();
    }
    if (b.a()==true )
    {
      b.xstoreleft();
    }
    if (b.d()==true )
    {
      b.xstoreright();
    }
    b.jump();
    if (b.w() || b.a() || b.d())
    {
      image(img2, b.x(), b.y()+5, 20, 15);
    } else
    {
      image(img2, b.x(), b.y(), 20, 20);
    }
    b.checkTouchingAllTokens();
    b.displayTokenCounter(height-50, #FF0000);
  }
  
}
