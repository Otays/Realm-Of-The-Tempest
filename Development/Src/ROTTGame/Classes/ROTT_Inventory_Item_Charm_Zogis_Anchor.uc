/*============================================================================= 
 * ROTT_Inventory_Item_Charm_Zogis_Anchor
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * Rare equipable item
 *===========================================================================*/
 
class ROTT_Inventory_Item_Charm_Zogis_Anchor extends ROTT_Inventory_Item;

/// +75% mana
/// +10 HP Regen

/*=============================================================================
 * getDropChance()
 *
 * Implemented in each item subclsas
 *===========================================================================*/
protected function float getDropChance(int dropLevel) {
  local float dropChance;
  
  // Cut until minimum drop level
  if (dropLevel < 25) return 0;
  
  // Linear scaling by drop level
  dropChance = 0.05f + (dropLevel * 0.001f);
  
  // Cap
  if (dropChance > 2.f) dropChance = 2.f; 
  
  return dropChance;
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
  itemName="Zogi's Anchor"
  
  // Item texture
  itemTexture=Texture2D'ROTT_Items.Charms.Item_Charm_Pink'
  
  // Item text color
  itemFont=DEFAULT_SMALL_CYAN
}


