/*============================================================================= 
 * ROTT_Inventory_Item_Shield_Kite
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * Equipment
 *===========================================================================*/
 
class ROTT_Inventory_Item_Shield_Kite extends ROTT_Inventory_Item;

/*=============================================================================
 * getDropChance()
 *
 * Implemented in each item subclsas
 *===========================================================================*/
protected function float getDropChance(int dropLevel) {
  return 22.f;
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
  bDoesNotStack=true
  bUseClanColor=true
  
  // Display name
  itemName="Kite Shield"
  
  // Item texture
  ///itemTexture=Texture2D'ROTT_Items.Kite_Shield.Kite_Shield_Red'
  
  // Item Textures
  itemClanTextures(CLAN_BLUE)=Texture2D'ROTT_Items.Kite_Shield.Kite_Shield_Blue'
  itemClanTextures(CLAN_CYAN)=Texture2D'ROTT_Items.Kite_Shield.Kite_Shield_Cyan'
  itemClanTextures(CLAN_GREEN)=Texture2D'ROTT_Items.Kite_Shield.Kite_Shield_Green'
  itemClanTextures(CLAN_GOLD)=Texture2D'ROTT_Items.Kite_Shield.Kite_Shield_Gold'
  itemClanTextures(CLAN_ORANGE)=Texture2D'ROTT_Items.Kite_Shield.Kite_Shield_Orange'
  itemClanTextures(CLAN_RED)=Texture2D'ROTT_Items.Kite_Shield.Kite_Shield_Red'
  itemClanTextures(CLAN_VIOLET)=Texture2D'ROTT_Items.Kite_Shield.Kite_Shield_Violet'
  itemClanTextures(CLAN_PURPLE)=Texture2D'ROTT_Items.Kite_Shield.Kite_Shield_Purple'
  itemClanTextures(CLAN_BLACK)=Texture2D'ROTT_Items.Kite_Shield.Kite_Shield_Black'
  itemClanTextures(CLAN_WHITE)=Texture2D'ROTT_Items.Kite_Shield.Kite_Shield_White'
  
  // Item text color
  itemFont=DEFAULT_SMALL_GREEN
}


