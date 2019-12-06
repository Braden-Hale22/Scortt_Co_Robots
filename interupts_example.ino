//Braden Hale 12_5_2019
//written to show an example of an interupt

bool mainButton=false;
bool auxButton=false;
bool light=false;

void setup()
{
  Serial.begin(9600);
  pinMode(6,OUTPUT); //the pin for the LED
  pinMode(11,INPUT); //the pin for the main power button
  pinMode(2,INPUT); //the pin for the aux button it has to be wired into pin to because thats how the chip is made.
  attachInterrupt(digitalPinToInterrupt(2),blink , RISING);
}


void loop()
{
  if(mainButton==true)
  {
    auxButton=digitalRead(11);
    if(auxButton==false)
    {
      digitalWrite(6,HIGH);
    }
    else
    {
      digitalWrite(6,LOW);
    }
  }
}


void blink()
{
  mainButton=!mainButton; 
}

 
