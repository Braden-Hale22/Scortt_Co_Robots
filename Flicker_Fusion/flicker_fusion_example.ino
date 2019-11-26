//Written by Braden Hale 11/20/19
//this Progam when used in conjunction with the java applet
// is made to demonstration flicker fusion by 
// changing the frequency at which the LED blinks

/* the following variables are global variables.
 *  normally useing lots of these is frowned upon because they 
 *  are constaly accesed and leads to memory issues 
 *  but this program is small and it gets the job done.
 *  Global variables can be used anywhere in the program 
 *  even in different files.
 */
char val;
int ledPin=6;
int inc=0;
int freq=31;
int buttonState1;
int buttonState2;
int lastButtonState1;
int lastButtonState2;
unsigned long lastDebounceTime1=0;
unsigned long lastDebounceTime2=0;
unsigned long debounceDelay=50;

/*
 * Void setup is code that is anly ran one time at startup
 * in this program we declare the button pins as inputs and run the 
 * "establishContact" function 
 */
void setup() {
pinMode(10,INPUT);
pinMode(11,INPUT);
Serial.begin(9600);
establishContact();

}

void loop() {
if(Serial.available()>0)   //this if statment say if there is serial data then then 
{                          //then update the variables that were sent over.
  val=Serial.read();

  if(val=='1')
  {
    inc=1;
  }
  if(val=='2')
  {
    inc=10;
  }
  if(val=='3')
  {
    inc=100;
  }

  
}
else
{
    Serial.println(freq);  //when there is no incoming serial information
    //delay(10);           //it sends out the frequency that is currently being outputted
}
//now for the buttons
// since these are cheap buttons they have to be whats called "debounced"
// this logic looks at when the button is hit and then waits a certain amount of time 
//before the button is able to be pressed again
  int up=digitalRead(10);
  if(up!=lastButtonState1)
  {
    lastDebounceTime1=millis();
  }
  if((millis()-lastDebounceTime1)>debounceDelay)
  {
    if(up!=buttonState1)
    {
      buttonState1=up;
      if(buttonState1==HIGH)
      {
        freq=freq+inc;
      }
    }
  }
  lastButtonState1=up;
 int down=digitalRead(11);
  if(down!=lastButtonState2)
  {
    lastDebounceTime2=millis();
  }
  if((millis()-lastDebounceTime2)>debounceDelay)
  {
    if(down!=buttonState2)
    {
      buttonState2=down;
      if(buttonState2==HIGH)
      {
        freq=freq-inc;
        if(freq<=30)
        {
          freq=31;
        }
      }
    }
  }
  lastButtonState2=down;


  //now to blink the light
  // here the "tone" function is used to generate the PWM 
  tone(ledPin,freq);

  //wait a bit
  //added delay for the serial com to take place
  delay(10);
  

}

void establishContact()
{
  while(Serial.available()<=0)
  {
    Serial.println("A");
    delay(300);
  }
}
