/*============================================================================= 
 * ROTT_Inventory_Item_Bottle_Nettle_Roots
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * 
 *===========================================================================*/
 
class ROTT_Inventory_Item_Bottle_Nettle_Roots extends ROTT_Inventory_Item;

/// +60 accuracy
/// +60% physical damage

/*=============================================================================
 * getDropChance()
 *
 * Implemented in each item subclsas
 *===========================================================================*/
protected function float getDropChance(int dropLevel) {
  // Cut until minimum drop level
  if (dropLevel < 10) return 0;
  
  // Cap
  return 0.5f + (dropLevel * 0.05f);
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
  category=ITEM_CATEGORY_EQUIPABLE
  
  // Display name
  itemName="Nettle Roots"
  
  // Item texture
  itemTexture=Texture2D'ROTT_Items.Bottles.Item_Bottle_Green'
  
  // Item text color
  itemFont=DEFAULT_SMALL_CYAN
}


