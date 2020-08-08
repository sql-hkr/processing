class Boudaisei
{
int ID;
boolean sleeping;
int TOEICPower;
Boudaisei(int setID)
{
  ID=setID;
  TOEICPower=0;
  sleeping=true;
}
int EStudy()
{
  if(!sleeping)
  {
    TOEICPower+=10;
  }
  return TOEICPower;
  }
}

void setup()
{
  Boudaisei nakamura=new Boudaisei(1);
  nakamura.sleeping=false;
  for(int i=0;i<3;i++)
  {
    println(nakamura.EStudy());
  }
}
