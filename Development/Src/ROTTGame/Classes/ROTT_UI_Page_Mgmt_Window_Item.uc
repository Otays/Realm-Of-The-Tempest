/*=============================================================================
 * ROTT_UI_Page_Mgmt_Window_Item
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * Description: This management window show an item's stats, and allows the 
 * player to choose to equip an item.
 *===========================================================================*/
 
class ROTT_UI_Page_Mgmt_Window_Item extends ROTT_UI_Page_Mgmt_Window;

enum StatsMenuOptions {
  ITEM_EQUIP,
};

/*=============================================================================
 * Button controls
 *===========================================================================*/
protected function navigationRoutineA() {
  // Transition to hero selection
  /// ...
}

/*=============================================================================
 * Assets
 *===========================================================================*/
defaultProperties
{
  // Number of menu options
  selectOptionsCount=1
  
  /** ===== Input ===== **/
  begin object class=ROTT_Input_Handler Name=Input_A
    inputName="XBoxTypeS_A"
    buttonComponent=none
  end object
  inputList.add(Input_A)
  
  /** ===== Textures ===== **/
  // Buttons
  begin object class=UI_Texture_Info Name=Button_Invest_1
    componentTextures.add(Texture2D'GUI.Button_Equip')
  end object
  
  /** ===== UI Components ===== **/
  // Buttons
  begin object class=UI_Sprite Name=Button_Invest_1_Sprite
    tag="Button_Invest_1_Sprite"
    posX=132
    posY=544
    ///posX=132
    ///posY=624
    images(0)=Button_Invest_1
  end object
  componentList.add(Button_Invest_1_Sprite)
  
}
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  