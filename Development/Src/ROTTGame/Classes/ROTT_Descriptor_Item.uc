/*=============================================================================
 * ROTT_Descriptor_Item
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * Given an item, this class formats display information.
 *===========================================================================*/

class ROTT_Descriptor_Item extends ROTT_Descriptor;

// Store item for formatting
var private ROTT_Inventory_Item formatTarget;

/*=============================================================================
 * formatItem()
 *
 * Given an item, this calls the format process.
 *===========================================================================*/
public function formatItem(ROTT_Inventory_Item item) {
  formatTarget = item;
  setUI();
}

/*=============================================================================
 * setUI()
 *
 * Assigns display information
 *===========================================================================*/
public function setUI() {
  local string itemCategory;
  local FontStyles headerFont;
  
  // Set header
  switch (formatTarget.itemFont) {
    case DEFAULT_SMALL_TAN:      headerFont = DEFAULT_MEDIUM_GOLD;    break;
    case DEFAULT_SMALL_ORANGE:   headerFont = DEFAULT_MEDIUM_ORANGE;  break;
    case DEFAULT_SMALL_CYAN:     headerFont = DEFAULT_MEDIUM_CYAN;    break;
    case DEFAULT_SMALL_GREEN:    headerFont = DEFAULT_MEDIUM_GREEN;   break;
  }
  
  h1(
    formatTarget.itemName,
    headerFont
  );
  
  // Set sub-heading
  switch (formatTarget.category) {
    case ITEM_CATEGORY_CURRENCY:   
      itemCategory = "(Currency)";          
      break;
    case ITEM_CATEGORY_CONSUMABLE: 
      itemCategory = "(Ritual Ingredient)"; 
      break;
    case ITEM_CATEGORY_EQUIPABLE:  
      itemCategory = "(Lvl. " $ formatTarget.itemLevel $ " Equipment)";         
      break;
  }
  
  h2(
    itemCategory
  );
  
  // Set paragraph information
  p1(
    "",
    "",
    ""
  );
  
  // Set skill information for p2 and p3
  p2(      
    "",
    "",
    "",
    ""
  );
}

/*============================================================================= 
 * Default Properties
 *===========================================================================*/
defaultProperties 
{
  
}















