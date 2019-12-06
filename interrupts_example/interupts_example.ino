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
  attachInterrupt(digitalPinToInterrupt(2),blink , RISING); // this line attaches the interrupt pin to the function (Blink) that we want it to run
}


void loop()
{
  if(mainButton==true)            //Here we check the status of the main on/off button andd if its true
  {
    auxButton=digitalRead(11);    //if mainButton is true then we read the state of the auxButton
    if(auxButton==false)          //we had to change the way the buttons work to pull up resistors instead of pull down.
    {
      digitalWrite(6,HIGH);       //if the button is pressed (true) then we turn on the led
    }
    else
    {
      digitalWrite(6,LOW);        //if the button is not pressed write the led Low
    }
  }
}


void blink()                      // this is the function that runs when the interupt is called
{
  mainButton=!mainButton;         // this startement takes the state of the variable mainButton and inverts it
}                                 //if its true it turns false, of its false it turns true

 
