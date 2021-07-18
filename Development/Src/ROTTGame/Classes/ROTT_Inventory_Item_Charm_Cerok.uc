/*============================================================================= 
 * ROTT_Inventory_Item_Charm_Cerok
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * Recipe ingredient.
 *===========================================================================*/
 
class ROTT_Inventory_Item_Charm_Cerok extends ROTT_Inventory_Item;

/*=============================================================================
 * getDropChance()
 *
 * Implemented in each item subclsas
 *===========================================================================*/
protected function float getDropChance(int dropLevel) {
  // Linear climb until cap
  if (dropLevel < 5) return 1.f - ((5 - dropLevel) * 0.05f);
  
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
  itemName="Cerok Charm"
  
  // Item texture
  itemTexture=Texture2D'ROTT_Items.Charms.Item_Charm_Red'
  
  // Item text color
  itemFont=DEFAULT_SMALL_ORANGE
}


