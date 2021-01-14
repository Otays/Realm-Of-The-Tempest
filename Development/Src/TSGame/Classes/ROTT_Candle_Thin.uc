/*============================================================================= 
 * ROTT_Candle_Thin
 *
 * Author: Otay
 * Bramble Gate Studios (All rights reserved)
 *
 * Description: A candle object that will automatically light a flame at the 
 * wick.
 *===========================================================================*/

class ROTT_Candle_Thin extends Actor
	ClassGroup(ROTT_Objects)
	placeable;

var private SkeletalMeshComponent candleSkeleton;
var private ParticleSystemComponent candleLight;

function postBeginPlay() {
	super.postBeginPlay();
  
	activateEmitter();
}

function activateEmitter() {
	candleSkeleton.attachComponentToSocket(candleLight, 'Flame_Socket');
  
	candleLight.activateSystem();
}

/*============================================================================= 
 * Default Properties
 *===========================================================================*/
defaultproperties
{
	// Candle skeletal mesh
	Begin Object Class=SkeletalMeshComponent Name=Candle_Skeletal_Mesh
    SkeletalMesh=SkeletalMesh'ROTT_Decorations.Candles.SK_Candle_1B'
	End Object
	candleSkeleton=Candle_Skeletal_Mesh
  components.add(Candle_Skeletal_Mesh)
  
  // Flame
	Begin Object Class=ParticleSystemComponent Name=PSC_Candle_Light
    Template=ParticleSystem'ROTT_Decorations.Candles.PS_CandleLight_1A'
	End Object
	candleLight=PSC_Candle_Light
  components.add(PSC_Candle_Light)
  
}














