void writeTitle(String text_v,float posx, float posy, int size){ // funzione writeTitle.
      textSize(size);
      fill(TITLE_COLOR);
      textAlign(CENTER);
      text(text_v,width*posx,height*posy);
}
void clearScreen(){ // funzione che mi copre il background
  background(BG_COLOR);
}

void buttonsRow(String[] IDs,float buttonX, float buttonY,  float buttonWidth, float buttonHeight, float buttonGap){
    for (int i=0; i< IDs.length;i++){
      buttonController.getButton(IDs[i]).render(buttonX+(i*(buttonGap+buttonWidth)),  buttonY,   buttonWidth,  buttonHeight);
    }
}

String[] getStringArray(FloatList list){
  String[] stringa = new String[list.size()];
  for(int i=0; i<list.size(); i++){
    stringa[i] = String.valueOf(list.get(i));
  }
  return stringa;
}
