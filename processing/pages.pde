void startUp(){ // funzione startUp che pulisce lo schermo e scrive Starting Up
      clearScreen();
      writeTitle("Starting Up", 0.5,0.65,70);
      imageMode(CENTER);
      startUpSprite.display(width*0.5,height*0.45);
}

void calibration(){ // funzione calibration, che quindi pulisce lo schermo e scrive il titolo. 
    clearScreen();
    writeTitle("Calibration in Progress", 0.5,0.65,70);
    imageMode(CENTER);
    calibrationSprite.display(width*0.5,height*0.45);
    
}



void measure(){ //  //funzione measure, 
    clearScreen();
    writeTitle("Measuring", 0.5,0.075,50); //titolo
    
    
    
    
    //List of Numbers
    noFill(); 
    stroke(FRAME_STROKE_COLOR); // contorno
    rect(30,height*0.1, 200, height*0.8, 7);
    
    fill(TEXT_COLOR);
    textAlign(LEFT);
    textSize(20);
    text("Past Values [cm]", 35, height*0.075);
    textSize(16);
     for (int i=0; i<valueHistory.size(); i++){ // leggo tutti i valori di values, sono i valori numerici. 
       text(String.format("%.1f",valueHistory.get(i)),35,height*0.1+20+19*i);
     }
     
     fill(TITLE_COLOR);
     for (int i=0; i<recordedValues.size(); i++){ // leggo tutti i valori di values, sono i valori numerici. 
       text(String.format("%.1f",recordedValues.get(i)),135,height*0.1+20+19*i);
     }
    //Graph Zone
    
    noFill(); // riquadro per il grafico. 
    stroke(FRAME_STROKE_COLOR);
    rect(260,height*0.1, width-290, height*0.8, BUTTON_CORNER_RADIUS);
    line(130,height*0.11,130,height*0.89);
    // visualizziamo le misure correnti in grande. 
    
    textSize(150);
      fill(TITLE_COLOR);
      textAlign(CENTER);
      if (valueHistory.size()>0){
      text(String.format("%.1f cm",valueHistory.get(valueHistory.size()-1)),260+(width-290)*0.5,height*0.5);
      }
      
    //Buttons
    
    if (valueHistory.size()>0){
      buttonController.getButton("clear_b").enable();
    }else{
      buttonController.getButton("clear_b").disable();
    }
    
    if (recordedValues.size()>0){
      buttonController.getButton("del_b").enable();
      buttonController.getButton("save_b").enable();
    }else{
      buttonController.getButton("del_b").disable();
      buttonController.getButton("save_b").disable();
    }
    
    String[] buttons = {"clear_b", "rec_b", "del_b","save_b"}; // nella pagina di measuring metto i 3 bottoni. 
    buttonsRow(buttons,270,height-height*0.1-60,150,50,10);
    
     
    
}
