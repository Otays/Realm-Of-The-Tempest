/*============================================================================= 
 * ROTT_Inventory_Item_Herb_Unjah
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * Consumed at the Etzland shrine for experience
 *===========================================================================*/
 
class ROTT_Inventory_Item_Herb_Unjah extends ROTT_Inventory_Item;

/*=============================================================================
 * getDropChance()
 *
 * Implemented in each item subclsas
 *===========================================================================*/
protected function float getDropChance(int dropLevel) {
  // Linear climb until cap
  if (dropLevel < 5) return 1.0f - ((5 - dropLevel) * 0.05f);
  
  // Cap
  return 1.f;
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
  itemName="Unjah Petal"
  
  // Item texture
  itemTexture=Texture2D'ROTT_Items.Herbs.Item_Herb_Cyan'
  
  // Item text color
  itemFont=DEFAULT_SMALL_ORANGE
}


