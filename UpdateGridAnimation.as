package
{
	import flash.display.MovieClip;
	
	//-----------------------
	//Purpose:				Animation of blocks shifting via gravity
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class UpdateGridAnimation extends BlockMoveAnimation
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function UpdateGridAnimation(gameController:GameController, graphics:MovieClip, blocks:Array, locations:Array, speed:int, blockSwap:BlockSwap)
		{
			super(gameController, graphics, blocks, locations, speed, blockSwap);
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		protected override function CompletionCallback():void
		{
			_gameController.ResolveUpdateGrid(_blockSwap);
		}
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}