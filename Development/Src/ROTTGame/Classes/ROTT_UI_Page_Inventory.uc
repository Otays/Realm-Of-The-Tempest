/*=============================================================================
 * ROTT_UI_Page_Inventory
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * Description: This class is the interface for the players items 
 *===========================================================================*/
 
class ROTT_UI_Page_Inventory extends ROTT_UI_Page;

const INVENTORY_SLOT_COUNT = 16;

// Internal references
var private UI_Sprite inventoryBackground;
var private UI_Label inventoryPageLabel;
///var private UI_Label itemLabel;
var private UI_Selector inventorySelector;

// Inventory Navigation
var private int pageIndex;

// Item slot graphics
var privatewrite ROTT_UI_Displayer_Item inventorySlots[INVENTORY_SLOT_COUNT];

/*=============================================================================
 * Initialize Component
 *
 * Description: This event is called as the UI is loaded.
 *              Our initial scene is drawn here.
 *===========================================================================*/
public function initializeComponent(optional string newTag = "") {
  local int i, j;
  
  super.initializeComponent(newTag);
  
  // Get internal references
  inventoryBackground = findSprite("Inventory_Background");
  inventoryPageLabel = findLabel("Inventory_Page_Label");
  ///itemLabel = findLabel("Item_Name_Label");
  inventorySelector = UI_Selector(findComp("Inventory_Selector_Box"));
  
  // Initialize item displayers
  for (i = 0; i < 4; i++) {
    for (j = 0; j < 4; j++) {
      inventorySlots[i * 4 + j] = new(self) class'ROTT_UI_Displayer_Item';
      componentList.addItem(inventorySlots[i * 4 + j]);
      inventorySlots[i * 4 + j].initializeComponent();
      inventorySlots[i * 4 + j].updatePosition(
        782 + 157 * j,
        165 + 157 * i,
        782 + 157 * j + 128,
        165 + 157 * i + 128
      );
    }
  }
}

/*============================================================================= 
 * onPushPageEvent()
 *
 * This event is called every time the page is pushed.
 *===========================================================================*/
event onPushPageEvent() {
  super.onPushPageEvent();
  
  // Initialize navigation
  pageIndex = 0;
}
 
/*============================================================================= 
 * refresh()
 *
 * Called when item info changes
 *===========================================================================*/
public function refresh() {
  local ROTT_Inventory_Item selectedItem;
  local int index;
  local int i;
  
  super.refresh();
  
  // Get selected item
  index = inventorySelector.getSelection() + pageIndex * INVENTORY_SLOT_COUNT;
  selectedItem = getItem(index);
  
  // Show name of item
  ///if (selectedItem != none) {
  ///  itemLabel.setText(selectedItem.itemName);
  ///} else {
  ///  itemLabel.setText("");
  ///}
  
  // Show a page of the player's inventory
  for (i = 0; i < INVENTORY_SLOT_COUNT; i++) {
    inventorySlots[i].updateDisplay(getItem(i + pageIndex * INVENTORY_SLOT_COUNT));
  }
  
  // Update inspector window
  if (selectedItem != none) {
    ROTT_UI_Scene_Game_Menu(Outer).setMgmtDescriptor(
      selectedItem.getItemDescriptor(selectedItem)
    );
  }
  
  // Footer page numbers
  inventoryPageLabel.setText("Page " $ pageIndex+1 $ " of " $ getPageCount());
}

/*=============================================================================
 * getItem()
 *
 * Used to access an item from the player's inventory at the given index.
 *===========================================================================*/
public function ROTT_Inventory_Item getItem(int index) {
  if (!(index < gameInfo.playerProfile.playerInventory.itemList.length))
    return none;
  
  return gameInfo.playerProfile.playerInventory.itemList[index];
}
 
/*=============================================================================
 * onFocusMenu()
 *
 * Called when a menu is given focus.  Assign controls, and enable graphics.
 *===========================================================================*/
event onFocusMenu() {
  // Changes to graphics
  inventoryBackground.setEnabled(true);
  
  // Selector focus
  inventorySelector.setEnabled(true);
  inventorySelector.setActive(true);
  
  // Show items
  refresh();
}

/*=============================================================================
 * onUnfocusMenu()
 *
 * Called when the menu loses focus, but is not popped from the page stack.
 * Disable controls and update graphics accordingly.
 *===========================================================================*/
event onUnfocusMenu() {

}

/*=============================================================================
 * D-Pad controls
 *===========================================================================*/
public function onNavigateDown() {
  refresh();
}

public function onNavigateUp() {
  refresh();
}

public function onNavigateLeft() {
  refresh();
}

public function onNavigateRight() {
  refresh();
}

/*=============================================================================
 * Bumper inputs
 *===========================================================================*/
protected function navigationRoutineLB() {
  // Navigate to next page
  pageIndex--;
  
  // Loop around
  if (pageIndex < 0) pageIndex = getPageCount() - 1;
  
  // Update visuals
  refresh();
  
  // Sfx
  gameInfo.sfxBox.playSfx(SFX_MENU_NAVIGATE);
}
 
protected function navigationRoutineRB() {
  // Navigate to previous page
  pageIndex++;
  
  // Loop around
  if (pageIndex >= getPageCount()) pageIndex = 0;
  
  // Update visuals
  refresh();
  
  // Sfx
  gameInfo.sfxBox.playSfx(SFX_MENU_NAVIGATE);
}

/*=============================================================================
 * Button inputs
 *===========================================================================*/
protected function navigationRoutineA() {
  // Load item inspection
  ROTT_UI_Scene_Game_Menu(Outer).focusTop();
  
  // Sfx
  gameInfo.sfxBox.playSfx(SFX_MENU_ACCEPT);
}

protected function navigationRoutineB() {
  inventorySelector.resetSelection();
  inventoryBackground.setEnabled(false);
  inventoryPageLabel.setText("");
  
  // Pop both inventory and inspection
  parentScene.popPage();
  parentScene.popPage();
  
  gameInfo.sfxBox.playSfx(SFX_MENU_BACK);
}

/*=============================================================================
 * getPageCount
 *
 * Returns the index of the last page with items on it. 
 *===========================================================================*/
private function byte getPageCount() {
  return gameInfo.playerProfile.playerInventory.itemList.length / INVENTORY_SLOT_COUNT + 1;
}

/*=============================================================================
 * Assets
 *===========================================================================*/
defaultProperties
{
  /** ===== Input ===== **/
  begin object class=ROTT_Input_Handler Name=Input_A
    inputName="XBoxTypeS_A"
    buttonComponent=none
  end object
  inputList.add(Input_A)
  
  begin object class=ROTT_Input_Handler Name=Input_B
    inputName="XBoxTypeS_B"
    buttonComponent=none
  end object
  inputList.add(Input_B)
  
  begin object class=ROTT_Input_Handler Name=Input_LB
    inputName="XboxTypeS_LeftShoulder"
    buttonComponent=none
  end object
  inputList.add(Input_LB)
  
  begin object class=ROTT_Input_Handler Name=Input_RB
    inputName="XboxTypeS_RightShoulder"
    buttonComponent=none
  end object
  inputList.add(Input_RB)
  
  /** ===== Textures ===== **/
  // Inventory Background
  begin object class=UI_Texture_Info Name=Inventory_Page
    componentTextures.add(Texture2D'GUI.Inventory_Page')
  end object
  
  /** ===== UI Components ===== **/
  // Inventory Background
  begin object class=UI_Sprite Name=Inventory_Background
    tag="Inventory_Background"
    bEnabled=false
    posX=720
    posY=0
    posXEnd=NATIVE_WIDTH
    posYEnd=NATIVE_HEIGHT
    images(0)=Inventory_Page
  end object
  componentList.add(Inventory_Background)
  
  // Page Label
  begin object class=UI_Label Name=Inventory_Page_Label
    tag="Inventory_Page_Label"
    posX=720
    posY=826
    posXEnd=NATIVE_WIDTH
    posYEnd=866
    AlignX=CENTER
    AlignY=CENTER
    fontStyle=DEFAULT_SMALL_WHITE
    labelText=""
  end object
  componentList.add(Inventory_Page_Label)
  
  // Item name label
  begin object class=UI_Label Name=Item_Name_Label
    tag="Item_Name_Label"
    posX=720
    posY=58
    posXEnd=NATIVE_WIDTH
    posYEnd=124
    AlignX=CENTER
    AlignY=CENTER
    fontStyle=DEFAULT_MEDIUM_GOLD
    labelText="Inventory"
  end object
  componentList.add(Item_Name_Label)
  
  // Page navigation arrows
  begin object class=UI_Texture_Info Name=Menu_Navigation_Arrows_LR
    componentTextures.add(Texture2D'GUI.Menu_Navigation_Arrows_LR')
  end object
  
  // Page Navigation Graphics
  begin object class=UI_Sprite Name=Page_Navigation_Arrow_Sprite
    tag="Page_Navigation_Arrow_Sprite"
    bEnabled=true
    posX=755
    posY=826
    images(0)=Menu_Navigation_Arrows_LR
    
    // Alpha Effects
    activeEffects.add((effectType = EFFECT_ALPHA_CYCLE, lifeTime = -1, elapsedTime = 0, intervalTime = 0.6, min = 200, max = 255))
    
  end object
  componentList.add(Page_Navigation_Arrow_Sprite)
  
  // Inventory Selection Box
  begin object class=UI_Selector Name=Inventory_Selector_Box
    tag="Inventory_Selector_Box"
    bEnabled=false
    posX=775
    posY=159
    navigationType=SELECTION_2D
    selectionOffset=(x=157,y=157)  // Distance from neighboring spaces
    selectionCoords=(x=0,y=0)      // The space which this selector occupies
    gridSize=(x=4,y=4)             // Total size of 2d selection space
    
    // Inventory Selection Box
    begin object class=UI_Texture_Info Name=Inventory_Selection_Texture
      componentTextures.add(Texture2D'GUI.Inventory_Selector')
    end object
    
    // Selector sprite
    begin object class=UI_Sprite Name=Selector_Sprite
      tag="Selector_Sprite"
      images(0)=Inventory_Selection_Texture
      
      // Selector effect
      activeEffects.add((effectType = EFFECT_ALPHA_CYCLE, lifeTime = -1, elapsedTime = 0, intervalTime = 0.4, min = 170, max = 255))
    end object
    componentList.add(Selector_Sprite)
    
    // Inactive selector sprite
    begin object class=UI_Sprite Name=Inactive_Selector_Sprite
      tag="Inactive_Selector_Sprite"
      images(0)=Inventory_Selection_Texture
      
      // Selector effect
      ///activeEffects.add((effectType = EFFECT_ALPHA_CYCLE, lifeTime = -1, elapsedTime = 0, intervalTime = 2, min = 70, max = 205))
      activeEffects.add((effectType=EFFECT_FLICKER, lifeTime=-1, elapsedTime=0, intervalTime=0.4, min=100, max=205))
    end object
    componentList.add(Inactive_Selector_Sprite)
    
  end object
  componentList.add(Inventory_Selector_Box) 
  
}













