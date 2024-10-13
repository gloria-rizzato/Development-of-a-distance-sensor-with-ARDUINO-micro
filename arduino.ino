// PIN
const int controlPin1 = 7;     // H-bridge pin
const int controlPin2 = 8;     // H-bridge pin
const int accendiMotore = 9;   // motor pin

const int button = 2;     // calibration button

const int PD = A5;      // photodiode

const int switch1 = 6;   // near switch1 pin
const int switch2 = 5;   // far switch2 pin

// DEFINE
#define CALIBRATION 11
#define MEASUREMENT 0
#define N_VALUES 20
#define MAX_ADC 1023
#define MAX_IN_ARDUINO 5

// VARIABLES INITIALIZATION
int velocitaMotore1 = 105; //135
int velocitaMotore2 = 103; //89

int value = 0;
float volt = 0;
float sum = 0;
float initial_value = 0;
float final_value = 0;
float dist = 0;
int distance = 0;

int state = CALIBRATION;

// FUNCTIONS

void calibration()
{
  digitalWrite(controlPin1, HIGH);
  digitalWrite(controlPin2, LOW);
  analogWrite(accendiMotore, 100);
  delay(500);
  
  analogWrite(accendiMotore, 0);
  
  digitalWrite(controlPin1, LOW);
  digitalWrite(controlPin2, HIGH);

  analogWrite(accendiMotore, velocitaMotore1);
  
  while(digitalRead(switch1)==HIGH);
  
  analogWrite(accendiMotore, 0);
  
  for(int i=0;i<N_VALUES;i++)
  {
    value = analogRead(PD);
    volt = float(value)/MAX_ADC*MAX_IN_ARDUINO;
    delay(100);
    sum+=volt;
  }
  initial_value = sum/N_VALUES;
  sum = 0;
  
  digitalWrite(controlPin1, HIGH);
  digitalWrite(controlPin2, LOW);

  analogWrite(accendiMotore, velocitaMotore2);
  
  while(digitalRead(switch2)==HIGH);
  
  analogWrite(accendiMotore, 0);

//  digitalWrite(controlPin1, LOW);
//  digitalWrite(controlPin2, HIGH);
//
//  analogWrite(accendiMotore, 80);
//  delay(85);
//  analogWrite(accendiMotore, 0);

  for(int i=0;i<N_VALUES;i++)
  {
    value = analogRead(PD);
    volt = float(value)/MAX_ADC*MAX_IN_ARDUINO;
    delay(100);
    sum+=volt;
  }
  final_value = sum/N_VALUES;
  sum = 0;
  
  Serial.println(initial_value);
  
  Serial.println(final_value);
}

void measurement()
{
  for(int i=0;i<10;i++)
  {
    value = analogRead(PD);
    volt = float(value)/MAX_ADC*MAX_IN_ARDUINO;
    delay(100);
    sum+=volt;
  }
  final_value = sum/10;
  sum = 0;
  
  Serial.println(final_value);
  
  while(!Serial.available());
  distance = Serial.readString().toInt();
}


void setup() {
  
  pinMode(button, INPUT);
  pinMode(PD, INPUT);
  pinMode(switch1, INPUT_PULLUP);
  pinMode(switch2, INPUT_PULLUP);
  pinMode(controlPin1, OUTPUT);
  pinMode(controlPin2, OUTPUT);
  digitalWrite(accendiMotore, LOW);
  Serial.begin(115200);
  Serial.setTimeout(1);

  //p.begin("python");
  //p.addParameter("C:\Users\chiar\OneDrive\università\4_quarto_anno\Tech for sensors\Lab\Python_code\code.py");
  //p.run();
}


void loop() {
  
  if(state==CALIBRATION || digitalRead(button)==HIGH)
  {
    if(digitalRead(button)==HIGH)
    {
      Serial.println(CALIBRATION);
    }
    state = MEASUREMENT;

    calibration();
    
  }
  
  measurement();
  
}
