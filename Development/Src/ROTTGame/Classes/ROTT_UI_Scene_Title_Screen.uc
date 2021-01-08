/*=============================================================================
 * ROTT_UI_Scene_Title_Screen
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * Description: The title screen is the first scene displayed when the game 
 * starts.
 *===========================================================================*/

class ROTT_UI_Scene_Title_Screen extends ROTT_UI_Scene;

// Camera controls
var float currentCameraStep, maxCameraStep;
var float yawOffset, softClipSteps, cameraDirection;

var private ROTT_UI_Page_Title_Screen titlePage;
var private ROTT_UI_Page_Game_Intro introPage;
var private ROTT_UI_Page_Transition transitionOnContinuePage;

/*=============================================================================
 * initScene()
 *
 * Called when this scene is created
 *===========================================================================*/
event initScene() {
  super.initScene();
  
  titlePage = ROTT_UI_Page_Title_Screen(findComp("Page_Title_Screen"));
  introPage = ROTT_UI_Page_Game_Intro(findComp("Page_Game_Intro"));
  transitionOnContinuePage = ROTT_UI_Page_Transition(findComp("Page_Transition_Continue"));
  
}

/*=============================================================================
 * loadScene()
 *
 * Called when switching to this scene
 *===========================================================================*/
event loadScene() {
  super.loadScene();
  
  pushPage(titlePage);
}


/*=============================================================================
 * elapseTimers()
 *
 * Increments time every engine tick.
 *===========================================================================*/
public function elapseTimer(float deltaTime, float gameSpeedOverride) {
  titleCameraTick(deltaTime);
}

/*=============================================================================
 * titleCameraTick()
 *
 * Called every frame to move the camera's view of the 3D world
 *===========================================================================*/
public function transitionContinue() {
  // Load last town
  transitionOnContinuePage.destinationWorld = gameInfo.getMapFileName(MAP_TALONOVIA_TOWN);
  /* to do ... replace talonovia with last town */
  
  // Execute transition
  pushPage(transitionOnContinuePage);
}

/*=============================================================================
 * titleCameraTick()
 *
 * Called every frame to move the camera's view of the 3D world
 *===========================================================================*/
private function titleCameraTick(float deltaTime) {
	local float softCut;
	
	if (currentCameraStep > maxCameraStep - softClipSteps) {
		softCut = (maxCameraStep - currentCameraStep) / softClipSteps;
	} else if (currentCameraStep < softClipSteps) {
		softCut = (currentCameraStep / softClipSteps);
	} else {
		softCut = 1;
	}
	
	/** 250 = Amplitude, currentCameraStep = time elapsed, maxCameraStep = total time **/
	yawOffset += cameraDirection * (deltaTime * softCut * 120.0);	
	
  // Set camera position and rotation
	overrideCamRot.pitch = 62126;
	overrideCamRot.yaw = 61826 + yawOffset;
	overrideCamRot.roll = 0;
	
  // Override camera control
  gameInfo.tempestPawn.overrideCamera(overrideCamLoc, overrideCamRot);
  
	currentCameraStep += cameraDirection;
	if (currentCameraStep >= maxCameraStep)	{
		cameraDirection = -1;
	}
	
	if (currentCameraStep <= 0)	{
		cameraDirection = 1;
	}
}

/*=============================================================================
 * Default Properties
 *===========================================================================*/
defaultProperties 
{
  // Controls
  bAllowOverWorldControl=false
  
  // Camera controls
  maxCameraStep=1700
  yawOffset=61826
  softClipSteps=240
  ///currentCameraStep=800
  
  bOverrideCamera=true
  overrideCamLoc=(x=74944.0,y=32678.0,z=902.0)
  
  // Title Page
  begin object class=ROTT_UI_Page_Title_Screen Name=Page_Title_Screen
    tag="Page_Title_Screen"
    bEnabled=true
  end object
  pageComponents.add(Page_Title_Screen)
  
  // Intro Page
  begin object class=ROTT_UI_Page_Game_Intro Name=Page_Game_Intro
    tag="Page_Game_Intro"
    bEnabled=false
  end object
  pageComponents.add(Page_Game_Intro)
  
  // Transition for continue
  begin object class=ROTT_UI_Page_Transition Name=Page_Transition_Continue
    tag="Page_Transition_Continue"
    bEnabled=false
    
    // Transition speed
    tilesPerTick=18
    
    // Sorter effect config
    effectConfig=NPC_TRANSITION_OUT
    
    // Destination
    destinationScene=NO_SCENE
  end object
  pageComponents.add(Page_Transition_Continue)
  
}














