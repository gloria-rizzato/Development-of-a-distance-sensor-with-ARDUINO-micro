import processing.net.*;

// UI Elements
ButtonController buttonController;
Animation calibrationSprite;
Animation startUpSprite;

//Connectivity
Client mClient;
String dataIn;     // Data received from the serial port

// Local Data Handling
FloatList valueHistory;
FloatList recordedValues;

// States
Phase phase, remotePhase;

void setup() {
  size(1200, 800); 
  clearScreen();
  frameRate(30); 
  
  buttonController= new ButtonController();  // definiamo i bottoni. 
    buttonController.addButton(new Button("Clear","clear_b"));
    buttonController.addButton(new Button("Record","rec_b"));
    buttonController.addButton(new Button("Delete","del_b"));
    buttonController.addButton(new Button("Save","save_b"));

  remotePhase=Phase.STARTUP; 
  phase=Phase.STARTUP; // siamo nella fase di starup
  
  mClient = new Client(this, HOST, PORT);  
  mClient.write(str(remotePhase.ordinal())+"\n"); 
  

  
  calibrationSprite = new Animation("calibration", CALIBRATION_SPRITE_FRAMES); 
  startUpSprite = new Animation("startup", STARTUP_SPRITE_FRAMES);
  
  

  valueHistory = new FloatList();
  recordedValues = new FloatList();

  
}

void draw() { 
   if (mClient.available() > 0) {  
    dataIn = mClient.readStringUntil('\n'); 
    if(valueHistory.size()==MEASURE_HISTORY_LENGHT){
      valueHistory.remove(0);
    }
    if (float(dataIn)==CONNECTION_CALIBRATION_COMMAND){
      phase=Phase.CALIBRATION;
      remotePhase=Phase.CALIBRATION;
    } else{
      phase=Phase.OPERATION;
      valueHistory.append(float(dataIn));
    }
  } 
   
  if (phase==Phase.STARTUP){ // se siamo nella fase startup, 
   startUp();
  } else if (phase==Phase.CALIBRATION){ // se phase è phase.calibration allora apro la funzione calibration, che 
      calibration();
  }if (phase==Phase.OPERATION){
      measure();
  }
}


void keyPressed(){ // Temporaneo per ciclare le schermate, cioè se premo, allora cambio la schermata. 
   if (phase==Phase.STARTUP){
     phase=Phase.CALIBRATION;
  } else if (phase==Phase.CALIBRATION){
    phase=Phase.OPERATION;
  }else if (phase==Phase.OPERATION){
    phase=Phase.STARTUP;
  }
}
