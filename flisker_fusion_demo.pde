/*
written by Braden Hale 11/20/19
this program is a user interface for the accompaning arduino sketch
it displays the current owm frequency as well as lwtting the user cange the amount
by which the buttons increment the frequency
*/

// Here we import some essential libraries and
//declare out global variables

import processing.serial.*;
import static javax.swing.JOptionPane.*;
Serial myPort; 
final boolean debug=true;
String val;
boolean firstContact=false;
int Fback =0;
boolean s1=true;
boolean s2=false;
boolean s3=false;


// This code is ran one time at start up 
// this lets the user select which com port the arduino is useing and then 
// runs the rest of the program
void setup()
{
  String COMx, COMlist="";
  
  
 // String portName=Serial.list()[2];
 // myPort=new Serial(this, portName,9600);
  size(600,600);
//  myPort.bufferUntil('\n');
  
  //com port selection stuff
  try {
    if(debug) printArray(Serial.list());
    int i = Serial.list().length;
    if (i != 0) {
      if (i >= 2) {
        // need to check which port the inst uses -
        // for now we'll just let the user decide
        for (int j = 0; j < i;) {
          COMlist += char(j+'a') + " = " + Serial.list()[j];
          if (++j < i) COMlist += ",  ";
        }
        COMx = showInputDialog("Which COM port is correct? (a,b,..):\n"+COMlist);
        if (COMx == null) exit();
        if (COMx.isEmpty()) exit();
        i = int(COMx.toLowerCase().charAt(0) - 'a') + 1;
      }
      String portName = Serial.list()[i-1];
      if(debug) println(portName);
      myPort = new Serial(this, portName, 9600); // change baud rate to your liking
      myPort.bufferUntil('\n'); // buffer until CR/LF appears, but not required..
    }
    else {
      showMessageDialog(frame,"Device is not connected to the PC");
      exit();
    }
  }
  catch (Exception e)
  { //Print the type of error
    showMessageDialog(frame,"COM port is not available (may\nbe in use by another program)");
    println("Error:", e);
    exit();
  }
}  
  

// This beginning part "draws" the text on the window
void draw()
{
 // draw the frequncy back from the arduino
 background(255);
 textAlign(LEFT);
 textSize(64);
 text("Current Frequency",10,100);
 if(Fback<999)
 {
 textSize(150);
 textAlign(CENTER);
 text(Fback+"Hz",300,300);
 fill(0,102,153);
 }
 else
 {
  textSize(150);
  textAlign(CENTER);
  text((Fback/1000)+"kHz",300,300);
  fill(0,102,153);
 }
 //all squares
   fill(255);
   rect(10,365,580,130,7);
   rect(200,475,200,50,7);
   fill(0,102,153);
  textSize(30);
  text("Increment",300,510);
  textSize(20);
  textAlign(LEFT);
  text("x1",65,395);
  text("x10",280,395);
  text("x100",505,395);
  rect(50,400,55,55,7);
  rect(275,400,55,55,7);
  rect(500,400,55,55,7);
  
// here we draw the rectangles that are used for the buttons
 //square 1
 if(s1==true)
 {
    fill(0,255,0);
    rect(50,400,55,55,7);
    fill(0,102,153);
 }
 
 //square 2
 if(s2==true)
 {
   fill(0,255,0);
   rect(275,400,55,55,7);
   fill(0,102,153);
 }
 
 //square 3
 if(s3==true)
 {
   fill(0,255,0);
   rect(500,400,55,55,7);
   fill(0,102,153);
 }

 
 
 

 
 
}

// this is where we send information to and receive it from the arduino
void serialEvent(Serial myPort)
{
  redraw();
  val=myPort.readStringUntil('\n');
  if(val !=null)
  {
  val=trim(val);
  //println(val);
  
  if(firstContact==false)
  {
    if(val.equals("A"))
    {
      myPort.clear();
      firstContact=true;
      myPort.write("A");
      //println("contact");
    }
  }
  else
  {
    //println(val);
    Fback=Integer.parseInt(val);
    //println(Fback);
    if(s1==true)
    {
      myPort.write('1');
      //println("1");
    }
    if(s2==true)
    {
      myPort.write('2');
      //println("2");
    }
    if(s3==true)
    {
      myPort.write('3');
     // println("3");
    }
  }
 }
}


// this function is ran when the mouse is clicked
//after the click we determine the position of the mouse 
// and see if it clicked on of the buttons we drew 
void mousePressed()
{
  if(mouseY>=400&&mouseY<=455)
  {
    if(mouseX>=50&&mouseX<=105)
    {
      s1=true;
      s2=false;
      s3=false;
    }
    if(mouseX>=275&&mouseX<=330)
    {
      s1=false;
      s2=true;
      s3=false;
    }
    if(mouseX>=500&&mouseX<=555)
    {
      s1=false;
      s2=false;
      s3=true;
    }
   
  }
  redraw();
}
      
  
  
