/*=============================================================================
 * ROTT_Descriptor_Skill_Valkyrie_Solar_Shock
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * One of the valkyries skill descriptors.
 *===========================================================================*/

class ROTT_Descriptor_Skill_Valkyrie_Solar_Shock extends ROTT_Descriptor_Hero_Skill;

/*=============================================================================
 * initialize()
 *
 * this function should be called by the descriptor container to set headers
 * and paragraph formatting info
 *===========================================================================*/
public function setUI() {
  // Set header
  h1(
    "Solar Shock"
  );
  
  // Set header
  h2(
    getHeader(targetingLabel)
  );
  
  // Set paragraph information
  p1(
    "Mana that overflows beyond the max",
    "eventually triggers an atmospheric",
    "attack on all enemies."
  );
  
  // Set skill information for p2 and p3
  skillInfo(      
    "Mana Cost: %mana",
    "%min to %max damage",
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
  local float attribute; 
  
  switch (type) {
    case MANA_OVERFLOW_COST:
      ///max = attributeInfo(ATMOSPHERIC_DAMAGE_MIN, hero, level);
      ///min = attributeInfo(ATMOSPHERIC_DAMAGE_MAX, hero, level);
      ///
      ///attribute = ((max - min) / 2 + min) * 42 - level * 30;
      attribute = 275 * 2 ** (level - 1);
      break;
      
    case ATMOSPHERIC_DAMAGE_MIN:
      ///attribute = (level * 1) + (level / 2.0 * (level - 1)) + 2 - 1;
      attribute = 2 * 2.25 ** (level - 1);
      break;
    case ATMOSPHERIC_DAMAGE_MAX:
      ///attribute = (level * 7) + (level / 2.0 * (level - 1)) + 6;
      attribute = 13 * 2.25 ** (level - 1);
      break;
      
      /**
    case MANA_OVERFLOW_COST:
      attribute = getManaEquation(level, 1.29, 0.915, 2.69, 87.0, 3.0);
      break;
    case MANA_TRANSFER_RATE:
      attribute = 5.0; // length in seconds of mana cost transfer 
      break;
      
    case ATMOSPHERIC_DAMAGE_MIN:
      attribute = (level * 1) + (level / 2.0 * (level - 1)) + 2;
      break;
    case ATMOSPHERIC_DAMAGE_MAX:
      attribute = (level * 7) + (level / 2.0 * (level - 1)) + 6;
      break;
      
      **/
  }
  
  return attribute;
}

/*============================================================================= 
 * onPoolOverflow()
 *
 * This is called when the mana cost for a passive mana draining skill is met
 *===========================================================================*/
public function onPoolOverflow(ROTT_Combat_Hero hero) {
  local array<ROTT_Combat_Unit> targets;
  local ROTT_Mob mob;
  local int i;
  
  // Get targets
  mob = gameInfo.enemyEncounter; 
  
  // Multi target attack
  for (i = 0; i < 3; i++) {
    if (mob.getEnemy(i) != none) {
      targets.addItem(mob.getEnemy(i));
    }
  }
  
  // Execute the skill and play sfx
  if (skillAction(targets, hero, ATMOSPHERIC_SET)) {
    gameInfo.sfxBox.playSfx(combatSfx);
  }
}

/*=============================================================================
 * Default Properties
 *===========================================================================*/
defaultProperties
{
  targetingLabel=MULTI_TARGET_AURA
  
  // Level lookup info
  skillIndex=VALKYRIE_SOLAR_SHOCK
  parentTree=CLASS_TREE

  // Sound effect
  combatSfx=SFX_COMBAT_AURA_ATTACK
  
  // Skill Attributes
  skillAttributes.add((attributeSet=INACTIVE_SET,mechanicType=MANA_OVERFLOW_COST,tag="%mana",font=DEFAULT_SMALL_BLUE,returnType=INTEGER));
  //skillAttributes.add((attributeSet=ON_TICK_SET,mechanicType=MANA_TRANSFER_RATE,tag="n/a",font=DEFAULT_SMALL_BLUE,returnType=DECIMAL));
  
  skillAttributes.add((attributeSet=ATMOSPHERIC_SET,mechanicType=ATMOSPHERIC_DAMAGE_MIN,tag="%min",font=DEFAULT_SMALL_ORANGE,returnType=INTEGER));
  skillAttributes.add((attributeSet=ATMOSPHERIC_SET,mechanicType=ATMOSPHERIC_DAMAGE_MAX,tag="%max",font=DEFAULT_SMALL_ORANGE,returnType=INTEGER));

  // Skill Animation
  begin object class=UI_Texture_Info Name=SkillAnim_SolarShock_F1
    componentTextures.add(Texture2D'GUI_Skills.SkillAnim_SolarShock_F1')
  end object
  begin object class=UI_Texture_Info Name=SkillAnim_SolarShock_F2
    componentTextures.add(Texture2D'GUI_Skills.SkillAnim_SolarShock_F2')
  end object
  begin object class=UI_Texture_Info Name=SkillAnim_SolarShock_F3
    componentTextures.add(Texture2D'GUI_Skills.SkillAnim_SolarShock_F3')
  end object
  begin object class=UI_Texture_Info Name=SkillAnim_SolarShock_F4
    componentTextures.add(Texture2D'GUI_Skills.SkillAnim_SolarShock_F4')
  end object
  begin object class=UI_Texture_Info Name=SkillAnim_SolarShock_F5
    componentTextures.add(Texture2D'GUI_Skills.SkillAnim_SolarShock_F5')
  end object
  
  // Skill Animation Container
  begin object class=UI_Texture_Storage Name=Skill_Animation_Container
    tag="Skill_Animation_Container"
    textureWidth=240
    textureHeight=240
    images(0)=SkillAnim_SolarShock_F1
    images(1)=SkillAnim_SolarShock_F2
    images(2)=SkillAnim_SolarShock_F3
    images(3)=SkillAnim_SolarShock_F4
    images(4)=SkillAnim_SolarShock_F5
  end object
  skillAnim=Skill_Animation_Container
  
  
}





















