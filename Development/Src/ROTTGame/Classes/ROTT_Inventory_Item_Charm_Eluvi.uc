/*============================================================================= 
 * ROTT_Inventory_Item_Charm_Eluvi
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * 
 *===========================================================================*/
 
class ROTT_Inventory_Item_Charm_Eluvi extends ROTT_Inventory_Item;

/*=============================================================================
 * getDropChance()
 *
 * Implemented in each item subclsas
 *===========================================================================*/
protected function float getDropChance(int dropLevel) {
  return 5.f;
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
  itemName="Eluvi Charm"
  
  // Item texture
	itemTexture=Texture2D'ROTT_Items.Item_Charm_Orange'
  
  // Item text color
  itemFont=DEFAULT_SMALL_ORANGE
}


