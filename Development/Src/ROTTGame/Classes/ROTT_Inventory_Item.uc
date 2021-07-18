/*============================================================================= 
 * ROTT_Inventory_Item
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * An item that the player can obtain in their inventory
 *===========================================================================*/
 
class ROTT_Inventory_Item extends ROTTObject abstract;

// Item categories
enum ItemCategory {
  ITEM_CATEGORY_CURRENCY,
  ITEM_CATEGORY_CONSUMABLE,
  ITEM_CATEGORY_EQUIPABLE
};

var privatewrite ItemCategory category;

// Display information
var privatewrite string itemName;
var privatewrite FontStyles itemFont;
var privatewrite int itemLevel;

// Quantity
var privatewrite int quantity;
var privatewrite bool bDoesNotStack;

// Inventory graphic
var public instanced UI_Texture_Storage itemSprite;
var privatewrite Texture2D itemTexture;

// Optional clan color
var privatewrite Texture2D itemClanTextures[10];
var protectedwrite MyColors clanColor;
var protectedwrite bool bUseClanColor;

// Item attributes for equiped usage
enum EquipmentAttributes {
  // Armor
  ITEM_ADD_ARMOR,
  
  // Health
  ITEM_ADD_HEALTH,
  ITEM_ADD_HEALTH_REGEN,
  ITEM_MULTIPLY_HEALTH,
  
  // Mana
  ITEM_ADD_MANA,
  ITEM_ADD_MANA_REGEN,
  ITEM_MULTIPLY_MANA,
  
  // Speed
  ITEM_ADD_SPEED,
  ITEM_REDUCE_ENEMY_SPEED,
  
  // Accuracy and dodge
  ITEM_ADD_ACCURACY,
  ITEM_ADD_DODGE,
  
  // Stats
  ITEM_ADD_ALL_STATS, 
  ITEM_ADD_VITALITY, 
  ITEM_ADD_STRENGTH, 
  ITEM_ADD_COURAGE, 
  ITEM_ADD_FOCUS, 
  
  // Skills
  ITEM_ADD_CLASS_SKILLS,
  ITEM_ADD_GLYPH_SKILLS,
  ITEM_ADD_SKILL_POINTS, /// ...? [one skill]
  
  // Damage
  ITEM_ADD_PHYSICAL_MAX,
  ITEM_ADD_PHYSICAL_MIN,
  ITEM_MULTIPLY_ELEMENTAL,
  
  // Enchantments (Carries from inactive teams too)
  ITEM_ADD_ENCHANTMENT_LEVEL, 
  
  // Misc
  ITEM_ADD_GLYPH_LUCK,
  ITEM_ADD_LOOT_LUCK,
  ITEM_MULTIPLY_EXPERIENCE,
  ITEM_FASTER_AURA_STRIKES,
  ITEM_LACERATIONS, /// ... DPS drain of constant 25% dmg dealt, x% chance?
  ITEM_PERSISTENCE, /// ... Chance to strike again in half time?
  ITEM_MULTIPLY_PRAYER, 
  ITEM_MULTIPLY_HOARD_SIZE, 
};

// Store item attributes
var protectedwrite int itemStats[EquipmentAttributes]; 

// Store which skill ID to boost for ADD_SKILL_POINTS
var protectedwrite HeroClassEnum heroSkillType; 
var protectedwrite int heroSkillID; 

// Store which enchantment to boost
var protectedwrite EnchantmentEnum enchantmentType; 

// Linked list type storage system
var public class<ROTT_Inventory_Item> nextSavedItemType;

/*=============================================================================
 * initialize()
 *
 * This needs to be called when the item is created
 *===========================================================================*/
public function initialize() {
  linkReferences();

  // Set up texture storage
  itemSprite = new class'UI_Texture_Storage';
  itemSprite.initializeComponent("Inventory_Sprite");
  itemSprite.addTexture(getItemTexture(), 0);
  
  // Initialize each UI component
  itemSprite.initializeComponent();
}

/*=============================================================================
 * getItemTexture()
 *
 * Returns texture information for the item
 *===========================================================================*/
private function UI_Texture_Info getItemTexture() {
  local UI_Texture_Info textureInfo;
  
  // Set up texture info
  textureInfo = new class'UI_Texture_Info';
  
  // Texture assignment 
  if (bUseClanColor) {
    // Clan color assignment
    textureInfo.componentTextures.addItem(itemClanTextures[clanColor]);
  } else {
    // Default assignment
    textureInfo.componentTextures.addItem(itemTexture);
  }
  textureInfo.initializeInfo();

  // Check for valid item texture
  if (textureInfo == none) {
    yellowLog("Warning (!) No texture specified for item: " $ self);
    return none;
  }
  
  return textureInfo;
}
  
/*=============================================================================
 * setQuantity()
 *
 * Sets the quantity
 *===========================================================================*/
public function setQuantity(int q) {
  quantity = q;
}

/*=============================================================================
 * addQuantity()
 *
 * Adds the quantity
 *===========================================================================*/
public function addQuantity(int a) {
  if (bDoesNotStack) {
    yellowLog("Warning (!) Item does not stack");
    scriptTrace();
    return;
  }
  quantity += a;
}

/*=============================================================================
 * subtract()
 *
 * Removes a quantity.  Returns true if sufficient quantity.
 *===========================================================================*/
public function bool subtract(int s) {
  // Check for sufficient quantity
  if (quantity < s) {
    return false;
  }
  
  // Subtract and report success
  quantity -= s;
  return true;
}

/*=============================================================================
 * onTake()
 *
 * Called on items in the chest inventory to transfer them to the player
 *===========================================================================*/
public function onTake() {
  // Add Notification to screen
  gameInfo.showGameplayNotification("+" $ quantity $ " " $ itemName);
}

/*=============================================================================
 * initializeAttributes()
 *
 * Called after item generation for values dependent on instanced variables.
 *===========================================================================*/
public function initializeAttributes() {
  // Check for clan color usage
  if (bUseClanColor) {
    // Randomize clan color
    clanColor = MyColors(
      rand(class'ROTT_Combat_Enemy'.static.getClanColorCount())
    );
    
    // Set up texture storage
    violetlog("clan color: " $ clanColor);
    itemSprite.resetDrawInfo();
    itemSprite.addTexture(getItemTexture(), 0);
  }
  
  // Cap quantity if no stack
  if (bDoesNotStack) setQuantity(1);
}

/*=============================================================================
 * getItemDescriptor()
 *
 * Provides a formatted descriptor for item inspection window.
 *===========================================================================*/
public static function ROTT_Descriptor getItemDescriptor(ROTT_Inventory_Item target) 
{
  local ROTT_Descriptor_Item itemDescriptor;
  
  itemDescriptor = new class'ROTT_Descriptor_Item';
  itemDescriptor.formatItem(target);

  return itemDescriptor;
}
  
/*=============================================================================
 * generateItem()
 *
 * Given a drop level, and optionally a drop mod, this handles chance to drop,
 * drop quantity, and drop qualities like attributes, if any.
 *===========================================================================*/
public static function ROTT_Inventory_Item generateItem
(
  class<ROTT_Inventory_Item> lootType,
  int dropLevel,
  ItemDropMod dropMod
) 
{
  local ROTT_Inventory_Item item;
  local float minQuantity, maxQuantity;
  local float dropChance;
  local float itemCount;
  
  // Create item
  item = new lootType;
  item.initialize();
  item.itemLevel = dropLevel;
  
  // Get default drop info
  dropChance = item.getDropChance(dropLevel);
  minQuantity = item.getMinQuantity(dropLevel);
  maxQuantity = item.getMaxQuantity(dropLevel);
  
  // Overrides
  if (dropMod.chanceOverride != -1) dropChance = dropMod.chanceOverride;
  if (dropMod.minOverride != -1) minQuantity = dropMod.minOverride;
  if (dropMod.maxOverride != -1) maxQuantity = dropMod.maxOverride;
  
  // Multipliers
  dropChance *= dropMod.chanceAmp;
  minQuantity *= dropMod.quantityAmp;
  maxQuantity *= dropMod.quantityAmp;
  
  // Calculate chance to drop
  if (fRand() * 100 < dropChance) {
    item.darkGreenLog(
      "Random range: " $ minQuantity $ " - " $ maxQuantity $ " for " $ item,
      DEBUG_LOOT
    );
    
    // Roll random quantity
    itemCount = minQuantity + rand(maxQuantity - minQuantity + 1);
    if (itemCount < 1) itemCount = 1;
    item.setQuantity(itemCount);
    
    // Return result
    return item;
  }
  
  // Item did not drop
  return none;
}

/*=============================================================================
 * getDropChance()
 *
 * Implemented in each item subclsas
 *===========================================================================*/
protected function float getDropChance(int dropLevel) {
  return 100;
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
  quantity=1
  
  // Default color
  itemFont=DEFAULT_SMALL_WHITE
  
}











/** Held Items **
 ** This class contains data for held items used by heroes **
 ** When held, this item provides stat bonuses to the hero holding it **
 /

class ROTT_Inventory_Item extends ROTTObject;

/ Item Data /
/ Item Name /
var string ItemName;

/ Item Level /
var byte ItemLvl;

/ Attributes /
struct ItemAttribute
{
  var byte AttributeID;
  
  var int Stat1;  // Can be capped
  var int  Stat2;  // Sometimes used to hold Skill IDs
  
};

/ Attribute Stems /
struct AttributeStem
{
  var byte AttributeID;
  
  var float MaxStatPerLvl1;
  var float MaxStatPerLvl2;
  
  var byte MinimumLevel;
  
  var bool bCapped;
  var bool bSkill;
  
};

/ All possible item attributes /
var array<AttributeStem> PossibleAttributes;

/ This item's assigned attributes /
var array<ItemAttribute> ItemAttributes;

/ Graphics /
var Color OrbColor;
var byte AuraIndex;
var byte OverlayIndex;

/ Skill arrays /
var array<byte> PossibleSkills;

////////////////////////////////////////
//                                    //
//                ____                //
//            ,dP9CGG88@b,            //   
//          ,IP""YICCG888@@b,         //      
//         dIi   ,IICGG8888@b         //      
//        dCIIiciIICCGG8888@@b        //       
//________GCCIIIICCCGGG8888@@@________//
//        GGCCCCCCCGGG88888@@@        //       
//        GGGGCCCGGGG88888@@@@        //          
//        Y8GGGGGG8888888@@@@P        //            
//         Y88888888888@@@@@P         //            
//         `Y8888888@@@@@@@P'         //            
//            `@@@@@@@@@P'            //          
//                """"                //       
//                                    //         
////////////////////////////////////////


/ Functions /
/ Create random Item /
function GenerateItem(byte ItemLevel)
{
  / Set Item Level /
  ItemLvl = ItemLevel;
  
  / Prepare 'all possible' attribute list /
  InitStatList();
  
  / Assign attributes /
  AssignAttributes();
  SortAttributes();
  
  / Assign graphics /
  RandomizeGraphics();
}

/ Prepare this item for creation /
function InitStatList()
{
  PossibleAttributes.Length = 0;
  
  / SYNTAX:   [ID],   [1st], [2nd],   [MinLvl],     [bCap], [bSkill] /
  / +%1 to Max HP /
  PopulateAttribute( 1, 4, 0, 0 );
  / +%1 to Max MP /
  PopulateAttribute( 2, 4, 0, 0 );
  / +%1 to Damage Reduction /
  PopulateAttribute( 3, 0.5, 0, 0 );
  / %1 to %2 more Physical Damage /
  PopulateAttribute( 4, 0.75, 3, 0 );
  / %1 to max Physical Damage /
  PopulateAttribute( 5, 3, 0, 2 );
  / +%1 to Glyph Luck /
  PopulateAttribute( 6, 1, 20, 3, true );
  
  / +%1 to %SKILL /
  PopulateAttribute( 7, 0.35, 0, 3, , true );
    / +%1 to %SKILL /
    PopulateAttribute( 8, 0.35, 0, 5, , true );
    
  / %1% chance of Lacerations /
  PopulateAttribute( 9, 4, 50, 3, true );
  / %1 HP Regen /
  PopulateAttribute( 10, 2, 0, 4 );
  / %1 MP Regen /
  PopulateAttribute( 11, 2, 0, 4 );
  
  / +%1 Raid Loot /
  PopulateAttribute( 12, 2, 0, 5 );
  / +%1 chance to block /
  PopulateAttribute( 13, 2, 40, 5, true );
  / +%1 experience gained /
  PopulateAttribute( 14, 2, 25, 6, true );
  / +%1 chance of Persistence /
  PopulateAttribute( 15, 1, 35, 7, true );
  / +%1% faster Aura Strikes /
  PopulateAttribute( 16, 1, 20, 8, true );
  
  
  /
  PopulateAttribute( 4, 0, "+%1 to Max HP", 0 );
  PopulateAttribute( 4, 0, "+%1 to Max MP", 0 );
  PopulateAttribute( 0.5, 0, "+%1 to Damage Reduction", 0 );
  PopulateAttribute( 0.75, 3, "%1 to %2 more Physical Damage", 0 );
  PopulateAttribute( 3, 0, "%1 to max Physical Damage", 2 );
  PopulateAttribute( 1, 20, "+%1 to Glyph Luck", 3, true );
  PopulateAttribute( 0.35, 0, "+%1 to %SKILL", 3, , true );
  PopulateAttribute( 4, 50, "%1% chance of Lacerations", 3, true );
  PopulateAttribute( 2, 0, "%1 HP Regen", 4 );
  PopulateAttribute( 2, 0, "%1 MP Regen", 4 );
  PopulateAttribute( 0.35, 0, "+%1 to %SKILL", 5, , true );
  PopulateAttribute( 2, 0, "+%1 Raid Loot", 5 );
  PopulateAttribute( 2, 40, "+%1 chance to block", 5, true );
  PopulateAttribute( 2, 25, "+%1 experience gained", 6, true );
  PopulateAttribute( 1, 35, "+%1 chance of Persistence", 7, true );
  PopulateAttribute( 1, 20, "+%1% faster Aura Strikes", 8, true );
  /
  //PopulateAttribute( 0, 0, "", 0 );
  
}

function AssignAttributes()
{
  local int i; 
  local float PopChance, DeltaChance;
  
  grayLog("Generating item: Lvl " $ ItemLvl);
  
  / Check if any attributes are out of level range /
  i = PossibleAttributes.Length - 1;
  do
  {
    grayLog("Minimum level: " $ PossibleAttributes[i].MinimumLevel $ " ... Item Level: " $ ItemLvl);
    
    / Remove attributes out of level range /
    if (PossibleAttributes[i].MinimumLevel > ItemLvl) 
    {
      PossibleAttributes.Remove(i, 1);
      //grayLog("We have removed an attribute stem");
    } else {
      //grayLog("We have KEPT an attribute stem");
    }
    
    i--;
  } until (i <= 0);
  
  / Clear any existing attributes /
  ItemAttributes.Length = 0;
  
  / Force one attribute to the item /
  //(the next section also forces another, for a total minimum of two attributes)
  //...
  //grayLog("Forcing first attribute");
  AddRandomAttribute(ItemLvl);
  
  PopChance = 100.0;  //Start with another guaranteed attribute
  i = PossibleAttributes.Length - 1;
  do
  {
    / Random population chance /
    if (Rand(100) < PopChance)
    {
      / Officially put random Attribute on item /
      AddRandomAttribute(ItemLvl);
      //grayLog("Attribute passed chance test.  Chance was " $ PopChance);
    }
    
    / Decrease attribute population chance based on ItemLvl /
    DeltaChance = 100.0 / ItemLvl;
    
    if (DeltaChance > 12.5)
    {
      PopChance -= DeltaChance;
    } else {
      / Hardcap /
      PopChance -= 12.5;
    }
    
    //grayLog("Chance is now " $ PopChance);
    
    i--;
  } until (i <= 0);
  
}

/ Put an attribute on the actual item /
function AddRandomAttribute(int ItemLevel)
{
  local int i, j;
  
  / Increase array length for next attribute /
  ItemAttributes.Length = ItemAttributes.Length + 1;
  
  i = ItemAttributes.Length - 1;
  
  / Find random Attribute /
  j = Rand(PossibleAttributes.Length);
  
  / Set attribute properties /
  ItemAttributes[i].AttributeID = PossibleAttributes[j].AttributeID;
  ItemAttributes[i].Stat1 = Rand(FFloor(PossibleAttributes[j].MaxStatPerLvl1 * float(ItemLevel))) + 1;
  
  if (PossibleAttributes[j].bCapped)
  {
    / Here we use 'MaxStatPerLvl2' as a cap /
    if (ItemAttributes[i].Stat1 > PossibleAttributes[j].MaxStatPerLvl2) 
    {
      ItemAttributes[i].Stat1 = PossibleAttributes[j].MaxStatPerLvl2;
    }
    
  } else if (PossibleAttributes[j].bSkill) {
    
    / Prepare possible Skill IDs /
    PossibleSkills = default.PossibleSkills;
    
    / Prevent skills from different classes /
    if (ItemAttributes[i].AttributeID == 8) EnsureMatchingSkillClasses();
    
    / Assign random skill ID /
    ItemAttributes[i].Stat2 = PossibleSkills[Rand(PossibleSkills.Length)];
    
  } else {
    ItemAttributes[i].Stat2 = Rand(FFloor(PossibleAttributes[j].MaxStatPerLvl2 * float(ItemLevel))) + 1;
    
    / Add minimum stat to special cases /
    switch (ItemAttributes[i].AttributeID)
    {
      case 4:
        ItemAttributes[i].Stat2 += ItemAttributes[i].Stat1;
        break;
    }
    
  }
  
  PossibleAttributes.Remove(j, 1);
  
}


/ Randomize Graphics /
function RandomizeGraphics()
{
  local array<byte> Colors;
  local int i;
  
  / Random color within bounds of full saturation, full brightness /
  Colors.additem(0);
  Colors.additem(255);
  Colors.additem(Rand(256));
  
  / Assign Red /
  i = Rand(3);
  OrbColor.R = Colors[i];
  Colors.Remove(i, 1);
  
  / Assign Green /
  i = Rand(2);
  OrbColor.G = Colors[i];
  Colors.Remove(i, 1);
  
  / Assign Blue /
  OrbColor.B = Colors[0];
  
  / Set Alpha /
  OrbColor.A = 255;
  
  / gif catch
  if (OrbColor.G > 230)
  {
    OrbColor.G = 210;
    OrbColor.B = 80;
    
  }
  /
  
  / Seven possible auras, 1 through 7 /
  AuraIndex = Rand(7) + 1;
  
  / Two possible overlays, 1 through 2 /
  OverlayIndex = Rand(2) + 1;
}

/ Used to define possible attributes /
function PopulateAttribute(
  byte AttributeID,
  float MaxStatPerLvl1,
  float MaxStatPerLvl2,
  byte MinimumLevel,
  optional bool bCapped = false,
  optional bool bSkill = false )
{
  local int L;
  
  PossibleAttributes.Length = PossibleAttributes.Length + 1;
  L = PossibleAttributes.Length - 1;
  
  PossibleAttributes[L].AttributeID = AttributeID;
  PossibleAttributes[L].MaxStatPerLvl1 = MaxStatPerLvl1;
  PossibleAttributes[L].MaxStatPerLvl2 = MaxStatPerLvl2;
  PossibleAttributes[L].MinimumLevel = MinimumLevel;
  PossibleAttributes[L].bCapped = bCapped;
  PossibleAttributes[L].bSkill = bSkill;
  //PossibleAttributes[L].StatString = StatString;
  
  //grayLog("---");
  //grayLog("Attribute :: #" $ L $ " :: " $ Repl( StatString, "%1", "X"));
  //grayLog("---");
}

/ ========================================================================= **
   Sort Attributes 

   Description: This function standardizes the order of item attributes
   (Mutator Method)
** ========================================================================= /
function SortAttributes()
{
  local int i, j;               // For Iterations
  local array<ItemAttribute> tempAttributes;  // A copy of the ordered result
  
  / Iterate through ordered IDs /
  i = 1; // Valid IDs = [1,16]
  do
  {
    / Iterate through unordered attribute list /
    j = 0;
    do
    {
      if (ItemAttributes[j].AttributeID == i)
      {
        tempAttributes.additem(ItemAttributes[j]);
      }
      j++;
    } until (j >= ItemAttributes.Length);
    
    i++;
  } until (i >= 17); // Valid IDs = [1,16]
  
  / Assign Result /
  ItemAttributes = tempAttributes;
}

function EnsureMatchingSkillClasses()
{
  local int i;
  
  if (ItemAttributes.Length == 0) return;
  
  / Scan thru attributes to find Skill#1 (ID 7) /
  i = 0;
  do
  {
    if (ItemAttributes[i].AttributeID == 7)
    {
      if (ItemAttributes[i].Stat2 >= 30 && ItemAttributes[i].Stat2 <=39) PossibleSkills = default.ValkSkills;
      if (ItemAttributes[i].Stat2 >= 40 && ItemAttributes[i].Stat2 <=49) PossibleSkills = default.GoliathSkills;
      if (ItemAttributes[i].Stat2 >= 50 && ItemAttributes[i].Stat2 <=59) PossibleSkills = default.WizardSkills;
      if (ItemAttributes[i].Stat2 >= 70 && ItemAttributes[i].Stat2 <=79) PossibleSkills = default.TitanSkills;
      
      / Remove duplicate Skill ID, this one is already on the item /
      PossibleSkills.RemoveItem(ItemAttributes[i].Stat2);
    }
    
    i++;
  } until (i >= ItemAttributes.Length);
  
}

defaultProperties
{
  PossibleSkills=(30, 37, 38, 34, 35, 32, 33, 36, 40, 47, 44, 42, 48, 45, 49, 46, 50, 51, 54, 55, 58, 59, 53, 56, 70, 71, 74, 72, 78, 79, 73, 76)
  
  ValkSkills=(30, 37, 38, 34, 35, 32, 33, 36)
  GoliathSkills=(40, 47, 44, 42, 48, 45, 49, 46)
  WizardSkills=(50, 51, 54, 55, 58, 59, 53, 56)
  TitanSkills=(70, 71, 74, 72, 78, 79, 73, 76)
  
  /
  30  Stab
  37  Swift Stance
  38  Holy Valor
  34  Thunder Slash
  35  Purity
  32  Static Paralysis
  33  Purity
  36  Retaliation

  Goliath Skill Tree
  
  40  Daze
  47  Intimidate
  44  Earthquake
  42  Massacre
  48  Counter Glyphs
  45  Taunt
  49  Avalanche
  46  Rampage
  
  Wizard Skill Tree
  
  50  Starbolt
  51  Stardust
  54   Mindsurge
  55  Corpse Implosion
  58  Mystic Devotion
  59  Tachyon Pulse
  53  Plasma Shroud
  56  Blackhole
  
  Assassin Skill Tree
  
  Titan Skill Tree
  
  70  Siphon
  71  Soul Thrasher
  74  Storm
  72  Hope
  78  Oath
  79  Fusion
  73  Meditation
  76  Spirit Nova
  /
  
}








/




*/


