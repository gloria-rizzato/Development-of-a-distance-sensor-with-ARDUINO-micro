



class ButtonController{
  ArrayList<Button> buttons;   // ho una lista di array che chiamo buttons. 
  ButtonController(){
  buttons= new ArrayList<Button>();
  }
  void addButton(Button button){ // definisco funzione per aggiungere un bottone, lo aggiunge in una lista di array. 
    buttons.add(button);
  }
  
  Button getButton(String buttonID){ // getButton è una funzione che mi return il botton. 
    for(Button button : buttons){
      if (button.ID.equals(buttonID)){
        return button;
      }
    }
    return null;
  }
  
  
  
  
  void buttonClick(Button button){ // clicco il bottone
    if (button.ID.equals("clear_b")){
      valueHistory= new FloatList();
    }else if  (button.ID.equals("rec_b")){
      if(valueHistory.size()>0){
      recordedValues.append(valueHistory.get(valueHistory.size()-1));}
    }else if  (button.ID.equals("del_b")){
      if(recordedValues.size()>0){
      recordedValues.remove(recordedValues.size()-1);}
    }else if  (button.ID.equals("save_b")){
      if(recordedValues.size()>0){
        saveStrings(String.format("%d-%d-%d@%d:%d:%d-%d.txt",year(),month(),day(),hour(),minute(),second(),millis()%1000),getStringArray(recordedValues));
    }
    }
    button.refractory(BUTTON_DEFAULT_REFRACTORY); 
  }
}

    
  
    


class Button{
  String name;
  String ID;
  boolean enabled;
  int refrac;
   
  Button(String mName,String mID){
    name=mName;
    ID=mID;
    enabled=true;
    refrac=millis();
  }
  

 
  
  void render(float buttonX, float buttonY,  float buttonWidth, float buttonHeight){
    
    if(enabled && millis()>refrac){
      if ( ( mouseX>=buttonX && mouseX<=buttonX+buttonWidth) && (mouseY>=buttonY && mouseY<= buttonY+buttonHeight)){ //I.E. hover over button i // se il muose è sul bottone questo cambia il colore. 
        fill(58,138,125); //hover Color
        if (mousePressed && mouseButton == LEFT){ // se il mouse è schiacciato, 
          buttonController.buttonClick(this); // allora chiamo il bottone schiacciato 
        }
      }else{
        fill(BUTTON_ACTIVE_COLOR); //Normal Color, se non sono col muose sopra al bottone allora resta del colore normale
      }
    }else{
      fill(BUTTON_INACTIVE_COLOR); //greyed out
    }
      
    noStroke();
    rect(buttonX,buttonY, buttonWidth, buttonHeight, BUTTON_CORNER_RADIUS);
    
    fill(BUTTON_TEXT_COLOR);
    textSize(BUTTON_TEXT_SIZE);
    textAlign(CENTER,CENTER);
    text(name,buttonX+(buttonWidth/2),buttonY + (buttonHeight/2)-3); //IDK why but the height is wonky allineo i bottoni 
  }
  
  
  void refractory(int delay){ // funzione disable, che prende un numero come input e lo aggiungo al tempo
      refrac=millis()+delay;
  }
  
  void enable(){
  enabled=true;
  }
  void disable(){
  enabled=false;
  }
}
