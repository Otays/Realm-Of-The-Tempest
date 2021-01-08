/*=============================================================================
 * ROTT_UI_Page_Game_Intro
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * Description: Donations, thank yous, and version notes
 *===========================================================================*/
 
class ROTT_UI_Page_Game_Intro extends ROTT_UI_Page;

// Track time this page has been up
var private float elapsedTime;

// Vertical fade effect time
var private float elapsedEffectTime;
var private bool bTransitionOut;

// Internal references
var private UI_Sprite blackBars[60];

/*============================================================================= 
 * initializeComponent
 *
 * Called once, when the scene is first initialized.
 *===========================================================================*/
public function initializeComponent(optional string newTag = "") {
  local int i;
  
  super.initializeComponent(newTag);
  
  // Column iteration
  for (i = 0; i < 60; i++) {
    // Create sprites
    blackBars[i] = new class'UI_Sprite';
    blackBars[i].images.addItem(new class'UI_Texture_Info');
    blackBars[i].addTexture(Texture2D'GUI.Black_Square');
    componentList.addItem(blackBars[i]);
    blackBars[i].bMandatoryScaleToWindow = true;
    
    // Set position
    blackBars[i].updatePosition(0, i * 15, 1440, (i+1) * 15);
    blackBars[i].setEnabled(false);
    blackBars[i].initializeComponent();
  }
}

/*============================================================================= 
 * onPushPageEvent
 *
 * Description: This event is called every time the page is pushed.
 *===========================================================================*/
event onPushPageEvent() {
  addEffectToComponent(FADE_OUT, "Fade_Component", 0.6);
}

/*============================================================================= 
 * refresh()
 *
 * This function should ensure that any data thats been changed will be 
 * correctly updated on the UI.
 *===========================================================================*/
public function refresh() {
  
}

/*============================================================================= 
 * onSceneActivation
 *
 * Called every time the parent scene is loaded
 *===========================================================================*/
public function onSceneActivation() {
  
}

/*=============================================================================
 * onFocusMenu()
 *
 * Called when a menu is given focus.  Assign controls, and enable graphics.
 *===========================================================================*/
event onFocusMenu() {
  
}

/*=============================================================================
 * elapseTimers()
 *
 * Ticks every frame.  Used to check for joystick navigation.
 *===========================================================================*/
public function elapseTimers(float deltaTime) {
  local int i;
  
  super.elapseTimers(deltaTime);
  
  // Track time that this page has been up
  elapsedTime += deltaTime;
  
  // Column iteration
  if (bTransitionOut) {
    elapsedEffectTime += deltaTime;
    for (i = 0; i < 60; i++) {
      blackBars[i].setEnabled(true);
      blackBars[i].setVerticalMask(elapsedEffectTime);
    }
    
    // Start new game after effect
    if (elapsedEffectTime > 1.5) {
      // Set up a new player profile
      gameInfo.newGameSetup();
      
      // Load the NPC intro
      gameInfo.openNPCDialog(class'ROTT_NPC_Aliskus');
      gameInfo.sfxBox.playSfx(SFX_AMBIENT_OMINOUS);
    }
  }
}

/*=============================================================================
 * Button inputs
 *===========================================================================*/
protected function navigationRoutineA() {
  startTransitionOut();
}

protected function navigationRoutineB() {
  startTransitionOut();
}

/*=============================================================================
 * startTransitionOut()
 *
 * Called to start the transition into a new game
 *===========================================================================*/
protected function startTransitionOut() {
  local int i;
  
  // Column iteration
  for (i = 0; i < 60; i++) {
    blackBars[i].setEnabled(true);
  }
  
  bTransitionOut = true;
  
}

/*=============================================================================
 * Requirements
 *===========================================================================*/
protected function bool requirementRoutineA() { return elapsedTime > 2; }
protected function bool requirementRoutineB() { return elapsedTime > 2; }

/*=============================================================================
 * Default properties
 *===========================================================================*/
defaultProperties
{
	/** ===== Input ===== **/
	begin object class=ROTT_Input_Handler Name=Input_A
    inputName="XBoxTypeS_A"
		buttonComponent=none
	end object
  inputList.add(Input_A)
  
	begin object class=ROTT_Input_Handler Name=Input_B
    inputName="XBoxTypeS_B"
    buttonComponent=none
	end object
  inputList.add(Input_B)
  
  /** ===== UI Components ===== **/
  // Version
	begin object class=UI_Label Name=H1_Label
		tag="H1_Label"
		posX=0
		posY=60
		posXEnd=NATIVE_WIDTH
		posYEnd=NATIVE_HEIGHT
		alignX=CENTER
		alignY=TOP
		fontStyle=DEFAULT_LARGE_TAN
		labelText="Realm of the Tempest's Expanding ! ! !"
	end object
	componentList.add(H1_Label)
  
	begin object class=UI_Label Name=P1_Label
		tag="P1_Label"
		posX=0
		posY=108
		posXEnd=NATIVE_WIDTH
		posYEnd=NATIVE_HEIGHT
		alignX=CENTER
		alignY=TOP
		fontStyle=DEFAULT_MEDIUM_WHITE
		labelText="This game still has work in progress, expanding indefinitely."
	end object
	componentList.add(P1_Label)
  
	begin object class=UI_Label Name=P2_Label
		tag="P2_Label"
		posX=0
		posY=188
		posXEnd=NATIVE_WIDTH
		posYEnd=NATIVE_HEIGHT
		alignX=CENTER
		alignY=TOP
		fontStyle=DEFAULT_LARGE_TAN
		labelText="Bramble Gate Studios will be recruiting !"
	end object
	componentList.add(P2_Label)
	begin object class=UI_Label Name=P3_Label
		tag="P3_Label"
		posX=0
		posY=228
		posXEnd=NATIVE_WIDTH
		posYEnd=NATIVE_HEIGHT
		alignX=CENTER
		alignY=TOP
		fontStyle=DEFAULT_MEDIUM_WHITE
		labelText="Artists, Programmers, Musicians, Designers, Management, etc."
	end object
	componentList.add(P3_Label)
  
	begin object class=UI_Label Name=P4_Label
		tag="P4_Label"
		posX=0
		posY=308
		posXEnd=NATIVE_WIDTH
		posYEnd=NATIVE_HEIGHT
		alignX=CENTER
		alignY=TOP
		fontStyle=DEFAULT_LARGE_GREEN
		labelText="Realm of the Tempest now open source on Github.com/Otays ! ! !"
	end object
	componentList.add(P4_Label)
	begin object class=UI_Label Name=P5_Label
		tag="P5_Label"
		posX=0
		posY=348
		posXEnd=NATIVE_WIDTH
		posYEnd=NATIVE_HEIGHT
		alignX=CENTER
		alignY=TOP
		fontStyle=DEFAULT_MEDIUM_WHITE
		labelText="Thank you for sharing in this experience with Me !"
	end object
	componentList.add(P5_Label)
  
	begin object class=UI_Label Name=H2_Donor_Label
		tag="H2_Donor_Label"
		posX=0
		posY=448
		posXEnd=NATIVE_WIDTH
		posYEnd=NATIVE_HEIGHT
		alignX=CENTER
		alignY=TOP
		fontStyle=DEFAULT_LARGE_TAN
		labelText="- Donation Squad ! ! -"
	end object
	componentList.add(H2_Donor_Label)
	begin object class=UI_Label Name=Donor_List_Label_1
		tag="Donor_List_Label_1"
		posX=0
		posY=508
		posXEnd=NATIVE_WIDTH
		posYEnd=NATIVE_HEIGHT
		alignX=CENTER
		alignY=TOP
		fontStyle=DEFAULT_MEDIUM_CYAN
		labelText="Xenopher, val, formerfuture, Dustin Pundt, Gaiashield, cydy"
	end object
	componentList.add(Donor_List_Label_1)
  
	begin object class=UI_Label Name=P6_Label
		tag="P6_Label"
		posX=0
		posY=748
		posXEnd=NATIVE_WIDTH
		posYEnd=NATIVE_HEIGHT
		alignX=CENTER
		alignY=TOP
		fontStyle=DEFAULT_MEDIUM_WHITE
		labelText="Contact realmofthetempest@gmail.com"
	end object
	componentList.add(P6_Label)
	begin object class=UI_Label Name=P7_Label
		tag="P7_Label"
		posX=0
		posY=788
		posXEnd=NATIVE_WIDTH
		posYEnd=NATIVE_HEIGHT
		alignX=CENTER
		alignY=TOP
		fontStyle=DEFAULT_MEDIUM_GRAY
		labelText=" ~~~ Free download  ~~~  www.RealmoftheTempest.com  ~~~ "
	end object
	componentList.add(P7_Label)

  // Black Texture
  begin object class=UI_Texture_Info Name=Black_Texture
    componentTextures.add(Texture2D'GUI.Stat_Tube_Black_Cover')
  end object
  
  // Fade effects
	begin object class=UI_Sprite Name=Fade_Component
		tag="Fade_Component"
		posX=0
		posY=0
		posXEnd=NATIVE_WIDTH
		posYEnd=NATIVE_HEIGHT
		images(0)=Black_Texture
	end object
	componentList.add(Fade_Component)
  
}



