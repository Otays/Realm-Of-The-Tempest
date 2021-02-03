/*=============================================================================
 * ROTT_Descriptor_Skill_Glyph_Mana
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * This is a glyph skill, collected in combat to provide Mana boost.
 *===========================================================================*/

class ROTT_Descriptor_Skill_Glyph_Mana extends ROTT_Descriptor_Hero_Skill;

/*=============================================================================
 * initialize()
 *
 * this function should be called by the descriptor container to set headers
 * and paragraph formatting info
 *===========================================================================*/
public function setUI() {
  // Set header
  h1(
    "Mana",
  );
  
  // Set header
  h2(
    "",
  );
  
  // Set paragraph information
  p1(
    "Collect this glyph during",
    "combat to refill your mana pool.",
    "",
  );
  
  // Set skill information for p2 and p3
  skillInfo(      
    "Chance to spawn: %spawn%",
    "Recover %min to %max MP per Glyph",
    ""
  );
}


/*=============================================================================
 * attributeInfo()
 *
 * This function should hold all equations pertaining to the skill's behavior.
 *===========================================================================*/
protected function float attributeInfo
(
  AttributeTypes type, 
  ROTT_Combat_Hero hero, 
  int level
) 
{
  local float attribute; attribute = 0;
  
  if (level == 0) return 0;
  
  switch (type) {
    case GLYPH_SPAWN_CHANCE:
      attribute = 100;
      break;
    case GLYPH_MIN_MANA_BOOST:
      attribute = 24 * level * 1.1 ** (level - 1);
      attribute /= (1 + int((loge(level) / (loge(2))) / 3.f) / 2.90);
      
      //attribute = round(7.7747 + 16.2165 * level + 0.0172936 * level * level + 0.000405144 * level * level * level);
      break;
    case GLYPH_MAX_MANA_BOOST:
      attribute = 32 * level * 1.1 ** (level - 1);
      attribute /= (1 + int((loge(level) / (loge(2))) / 3.f) / 2.90);
      
      //attribute = round(8.30583 + 23.3621 * level + 0.0484918 * level * level + 0.000194527 * level * level * level);
      break;
  }
  
  return attribute;
}

/**
function debugStat() {
  local int i;
  local string out;
  
  for (i = 0; i < 40; i++) {
    out $= string(m2(i)) $ " ";
  }
  
  cyanlog(out);
  
  out = "";
  for (i = 0; i < 40; i++) {
    out $= string(m3(i)) $ " ";
  }
  
  greenlog(out);
  
}

function float fRoundUp(float a)
{
  a = float (int (a + 0.49999));
  
  return a;
}

function int m3(int level) { // this equation is accurate from 1.05 and is slightly different than the current
  return 0;
}

function int m2(int level) { // this equation is accurate from 1.05 and is slightly different than the current
  local float b;
  b = float(level);
  return Round( fRoundUp(2.4 ** (b ** 0.44)) + (b ** 1.25) + (21.0 * b) + 8.0);
}

function int m1(int level) { // this equation is accurate from 1.05 and is slightly different than the current
  local float b;
  b = float(level);
  return Round( fRoundUp(2.4 ** (b ** 0.43)) + (b ** 1.15) + (14.0 * b) + 7.0);
}
**/

/*============================================================================= 
 * Default Properties
 *===========================================================================*/
defaultProperties 
{
  // Level lookup info
  skillIndex=GLYPH_TREE_MANA
  parentTree=GLYPH_TREE

  // Glyph Attributes
  skillAttributes.add((attributeSet=GLYPH_SET,mechanicType=GLYPH_SPAWN_CHANCE,tag="%spawn",font=DEFAULT_SMALL_BLUE,returnType=INTEGER));
  skillAttributes.add((attributeSet=GLYPH_SET,mechanicType=GLYPH_MIN_MANA_BOOST,tag="%min",font=DEFAULT_SMALL_GREEN,returnType=INTEGER));
  skillAttributes.add((attributeSet=GLYPH_SET,mechanicType=GLYPH_MAX_Mana_BOOST,tag="%max",font=DEFAULT_SMALL_GREEN,returnType=INTEGER));
  
}

/**

function int GetMPBoost(string StatType, int SkillLevel)
{
  local float iMinimum, iMaximum, b;
  
  b = float(SkillLevel);
  
  iMinimum = Round( fRoundUp(2.4 ** (b ** 0.43)) + (b ** 1.15) + (14.0 * b) + 7.0);
  iMaximum = Round( fRoundUp(2.4 ** (b ** 0.44)) + (b ** 1.25) + (21.0 * b) + 8.0);
  
  // Return type 
  switch (StatType)
  {
    case "Minimum":
      return int(iMinimum);
    case "Maximum":
      return int(iMaximum);
  }
  
}

**/


















