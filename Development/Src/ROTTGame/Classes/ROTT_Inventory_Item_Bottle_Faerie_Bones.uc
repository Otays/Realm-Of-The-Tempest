/*============================================================================= 
 * ROTT_Inventory_Item_Bottle_Faerie_Bones
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * Recipe ingredient.
 *===========================================================================*/
 
class ROTT_Inventory_Item_Bottle_Faerie_Bones extends ROTT_Inventory_Item;

/*=============================================================================
 * getDropChance()
 *
 * Implemented in each item subclsas
 *===========================================================================*/
protected function float getDropChance(int dropLevel) {
  if (dropLevel < 5) return 0.5f - dropLevel * 0.05f;
  return 0.5f;
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
  itemName="Faerie Bones"
  
  // Item texture
	itemTexture=Texture2D'ROTT_Items.Bottles.Item_Bottle_Pink'
  
  // Item text color
  itemFont=DEFAULT_SMALL_ORANGE
}


