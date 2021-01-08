/*=============================================================================
 * NPC - Etzland Wilderness (A)
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * A wilderness NPC in Etzland.
 *===========================================================================*/

class ROTT_NPC_Etzland_Wild_A extends ROTT_NPC_Container;

// Macros for formatting dialog content
`DEFINE NEW_NODE(TOPIC, MODE)           addDialogNode(`TOPIC, `MODE, 
`DEFINE ADD_OPTIONS(TOPIC, MODE)        addOptions(`TOPIC, `MODE, 
`DEFINE ADD_REPLY(TOPIC, MODE, INDEX)   addReplyChain(`TOPIC, `MODE, `INDEX,

`DEFINE ENDNODE );

/*=============================================================================
 * initDialogue()
 * 
 * This sets all the dialog content
 *===========================================================================*/
public function initDialogue() {
  super.initDialogue();
  
	// Intro
	`NEW_NODE(GREETING, NUETRAL)
    "With the roots as my feet, and wings off my back.",
    "I am as the priestess was, an angel of the dirt."
  `ENDNODE
  
  // ----------------------------------------------------------------------- //
  
  setInquiry(
    "Goodnight",
    "",
    "",
    "",
    
    BEHAVIOR_GOODBYE,
    BEHAVIOR_NONE,
    BEHAVIOR_NONE,
    BEHAVIOR_NONE
  );
  
}

/*=============================================================================
 * Default properties
 *===========================================================================*/
defaultProperties
{
  // NPC identity
  npcName=GENERIC
  
  // Background
	begin object class=UI_Texture_Info Name=NPC_Background_Texture
		componentTextures.add(Texture2D'GUI_NPC_Dialog.NPC_Background_Dark_Gray'
	end object
	
  // Sprite container for transfer
	begin object class=UI_Texture_Storage Name=NPC_Background
		tag="NPC_Background"
		images(0)=NPC_Background_Texture
	end object
  npcBackground=NPC_Background
  
  // NPC Texture
	begin object class=UI_Texture_Info Name=NPC_Sprite_Texture
    componentTextures.add(Texture2D'NPCs.Witches.NPC_Portrait_Witch_Green_360')
  end object
	
  // Sprite container for transfer
	begin object class=UI_Texture_Storage Name=NPC_Sprites
		tag="NPC_Sprites"
		images(0)=NPC_Sprite_Texture
	end object
  npcSprites=NPC_Sprites
}





