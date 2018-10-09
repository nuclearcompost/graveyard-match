package
{
	import flash.display.MovieClip;
	
	//-----------------------
	//Purpose:				Animation of 2 blocks swapping positions on the board
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class FlingBlocksAnimation extends BlockMoveAnimation
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function FlingBlocksAnimation(gameController:GameController, graphics:MovieClip, blocks:Array, locations:Array, speed:int, blockSwap:BlockSwap)
		{
			super(gameController, graphics, blocks, locations, speed, blockSwap);
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		protected override function CompletionCallback():void
		{
			_gameController.ResolveFlingBlocks(_blockSwap);
		}
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}