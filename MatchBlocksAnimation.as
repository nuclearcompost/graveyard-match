package
{
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	//-----------------------
	//Purpose:				Animation for when a group of blocks is matched
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class MatchBlocksAnimation
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Protected Properties //
		
		protected var _blockSwap:BlockSwap;
		protected var _gameController:GameController;
		protected var _graphics:MovieClip;
		protected var _size:int;
		protected var _speed:int;
		protected var _timer:Timer;
		
		//- Protected Properties -//
		
	
		// Initialization //
		
		// blocks is a 1-d array of blocks to move
		// locations is a 1-d array of GridLocations where blocks are located
		public function MatchBlocksAnimation(gameController:GameController, graphics:MovieClip, speed:int, blockSwap:BlockSwap)
		{
			_gameController = gameController;
			_graphics = graphics;
			_speed = speed;
			_blockSwap = blockSwap;
			
			_size = 100;
			
			_timer = new Timer(33);
			_timer.addEventListener(TimerEvent.TIMER, OnTimer);
			
			Repaint();
			
			_timer.start();
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		private function ClearGraphics():void
		{
			var iNumChildren:int = _graphics.numChildren;
			
			for (var i:int = 0; i < iNumChildren; i++)
			{
				_graphics.removeChildAt(0);
			}
		}
		
		private function CompletionCallback():void
		{
			_gameController.ResolveMatchBlocks(_blockSwap);
		}
		
		private function OnTimer(event:TimerEvent):void
		{
			if (_size <= _speed)
			{
				_timer.stop();
				ClearGraphics();
				CompletionCallback();
				return;
			}
			
			_size -= _speed;
			
			Repaint();
		}
		
		private function Repaint():void
		{
			ClearGraphics();
			
			for (var b:int = 0; b < _blockSwap.matchedBlocks.length; b++)
			{
				var oBlock:Block = Block(_blockSwap.matchedBlocks[b]);
				var oGridLocation:GridLocation = GridLocation(_blockSwap.matchedBlockGridLocations[b]);
				var oBlockLocation:PixelLocation = oGridLocation.ToPixel();
				
				var mcBlock:MovieClip = oBlock.GetGridGraphics();
				
				var iSize:Number = Number(_size) / 100.0;
				mcBlock.width *= iSize;
				mcBlock.height *= iSize;
				
				mcBlock.x = oBlockLocation.x + ((UIManager.BLOCK_WIDTH / 2) * (1 - iSize));
				mcBlock.y = oBlockLocation.y + ((UIManager.BLOCK_HEIGHT / 2) * (1 - iSize));
				
				_graphics.addChild(mcBlock);
			}
		}
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}