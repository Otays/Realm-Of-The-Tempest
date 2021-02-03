/*=============================================================================
 * ROTT_Descriptor_Skill_Glyph_Accuracy
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * This is a glyph skill, collected in combat to provide Accuracy boost.
 *===========================================================================*/

class ROTT_Descriptor_Skill_Glyph_Accuracy extends ROTT_Descriptor_Hero_Skill;
 
/*=============================================================================
 * initialize()
 *
 * this function should be called by the descriptor container to set headers
 * and paragraph formatting info
 *===========================================================================*/
public function setUI() {
  // Set header
  h1(
    "Accuracy",
  );
  
  // Set header
  h2(
    "",
  );
  
  // Set paragraph information
  p1(
    "Collect this glyph during",
    "combat to increase accuracy.",
    "",
  );
  
  // Set skill information for p2 and p3
  skillInfo(      
    "Chance to spawn: %spawn%",
    "+%accuracy Accuracy rating per Glyph",
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
      attribute = 50;
      break;
    case GLYPH_ACCURACY_BOOST:
      attribute = 15 * level + (level / 2) * 5 + (level / 4) * 5;
      break;
  }
  
  return attribute;
}

/**
private function int accuracyRating(int level) {
  local int i, delta, accuracy;
  
  delta = 6;
  accuracy = 6;
  
  for (i = 0; i < level; i++) {
    accuracy += delta;
    
    if (i % 3 == 0 && i != 0)  {
      delta = delta + 4;
    } else {
      delta = delta + 2;
    }
  }
  
  return accuracy;
}
**/

/*============================================================================= 
 * Default Properties
 *===========================================================================*/
defaultProperties 
{
  // Level lookup info
  skillIndex=GLYPH_TREE_ACCURACY
  parentTree=GLYPH_TREE

  // Glyph Attributes
  skillAttributes.add((attributeSet=GLYPH_SET,mechanicType=GLYPH_SPAWN_CHANCE,tag="%spawn",font=DEFAULT_SMALL_BLUE,returnType=INTEGER));
  skillAttributes.add((attributeSet=GLYPH_SET,mechanicType=GLYPH_ACCURACY_BOOST,tag="%accuracy",font=DEFAULT_SMALL_GREEN,returnType=INTEGER));
  
}

/**
  
function int GetAccuracy(string StatType, int SkillLevel)
{
  local int i, j, iAccuracy, iChance;
  //(Rand(Max - Min) + Min)
  
  i = 0;
  j = 0;
  iAccuracy = 6;
  iChance = 60;
  do
  {
    iAccuracy = iAccuracy + 6 + j;
    
    if (i%3 == 0 && i != 0)
    {
      j = j + 4;
    } else {
      j = j + 2;
    }
    
    i++;
  } until (i >= SkillLevel);
  
  // Return type 
  switch (StatType)
  {
    case "Stat":
      return iAccuracy;
    case "Chance":
      return iChance;
  }
}

**/


















