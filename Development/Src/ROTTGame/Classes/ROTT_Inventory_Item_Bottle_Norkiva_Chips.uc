/*============================================================================= 
 * ROTT_Inventory_Item_Bottle_Norkiva_Chips
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * Recipe ingredient.
 *===========================================================================*/
 
class ROTT_Inventory_Item_Bottle_Norkiva_Chips extends ROTT_Inventory_Item;

/// +60 accuracy
/// +60% physical damage

/*=============================================================================
 * getDropChance()
 *
 * Implemented in each item subclsas
 *===========================================================================*/
protected function float getDropChance(int dropLevel) {
  // Linear climb until cap
  if (dropLevel < 5) return 0.25f - ((5 - dropLevel) * 0.05f);
  
  // Cap
  return 0.25f;
}

/*=============================================================================
 * getMinQuantity()
 *
 * Implemented in each item subclsas
 *===========================================================================*/
protected function float getMinQuantity(int dropLevel) {
  return 1;
}

/*=============================================================================
 * getMaxQuantity()
 *
 * Implemented in each item subclsas
 *===========================================================================*/
protected function float getMaxQuantity(int dropLevel) {
  return 1;
}

/*============================================================================= 
 * Default Properties
 *===========================================================================*/
defaultProperties
{
  // Item categories
  category=ITEM_CATEGORY_CONSUMABLE
  
  // Display name
  itemName="Norkiva Chips"
  
  // Item texture
  itemTexture=Texture2D'ROTT_Items.Bottles.Item_Bottle_Gold'
  
  // Item text color
  itemFont=DEFAULT_SMALL_CYAN
}


