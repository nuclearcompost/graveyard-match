package
{
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	//-----------------------
	//Purpose:				Base class for animating blocks moving across the screen
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class BlockMoveAnimation
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Protected Properties //
		
		protected var _blocks:Array;
		protected var _blockSwap:BlockSwap;
		protected var _gameController:GameController;
		protected var _graphics:MovieClip;
		protected var _locations:Array;
		protected var _speed:int;
		protected var _timer:Timer;
		
		//- Protected Properties -//
		
	
		// Initialization //
		
		// blocks is a 1-d array of blocks to move
		// locations is a 2-d array of PixelLocations. Index 1 = block index. Index 2 = location index - 0 = current block location, n = waypoint location
		public function BlockMoveAnimation(gameController:GameController, graphics:MovieClip, blocks:Array, locations:Array, speed:int, blockSwap:BlockSwap)
		{
			_gameController = gameController;
			_graphics = graphics;
			_blocks = blocks;
			_locations = locations;
			_speed = speed;
			_blockSwap = blockSwap;
			
			_timer = new Timer(33);
			_timer.addEventListener(TimerEvent.TIMER, OnTimer);
			
			Repaint();
			
			_timer.start();
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		//- Public Methods -//
		
		
		// Protected Methods //
		
		protected function ClearGraphics():void
		{
			var iNumChildren:int = _graphics.numChildren;
			
			for (var i:int = 0; i < iNumChildren; i++)
			{
				_graphics.removeChildAt(0);
			}
		}
		
		// override this method for each child animation type
		protected function CompletionCallback():void
		{
			trace("BlockMoveAnimation's CompletionCallback called!");
		}
		
		protected function OnTimer(event:TimerEvent):void
		{
			var bSomethingMoved:Boolean = false;
			
			for (var b:int = 0; b < _blocks.length; b++)
			{
				if (_locations[b].length <= 1)
				{
					continue;
				}
				
				var oCurPoint:PixelLocation = PixelLocation(_locations[b][0]);
				var oWayPoint:PixelLocation = PixelLocation(_locations[b][1]);
				
				// advance towards the next waypoint
				var iDist:int = _speed;
				
				if (oCurPoint.y > oWayPoint.y)
				{
					if ((oCurPoint.y - oWayPoint.y) < iDist)
					{
						iDist = oCurPoint.y - oWayPoint.y;
					}
					
					oCurPoint.y -= iDist;
					bSomethingMoved = true;
				}
				
				if (oCurPoint.y < oWayPoint.y)
				{
					if ((oWayPoint.y - oCurPoint.y) < iDist)
					{
						iDist = oWayPoint.y - oCurPoint.y;
					}
					
					oCurPoint.y += iDist;
					bSomethingMoved = true;
				}
				
				if (oCurPoint.x > oWayPoint.x)
				{
					if ((oCurPoint.x - oWayPoint.x) < iDist)
					{
						iDist = oCurPoint.x - oWayPoint.x;
					}
					
					oCurPoint.x -= iDist;
					bSomethingMoved = true;
				}
				
				if (oCurPoint.x < oWayPoint.x)
				{
					if ((oWayPoint.x - oCurPoint.x) < iDist)
					{
						iDist = oWayPoint.x - oCurPoint.x;
					}
					
					oCurPoint.x += iDist;
					bSomethingMoved = true;
				}
				
				// see if we're at the current waypoint
				if (oCurPoint.x == oWayPoint.x && oCurPoint.y == oWayPoint.y)
				{
					_locations[b].splice(1, 1);
					continue;
				}
			}
			
			// if nothing moved, then everything is at its destination so the animation is over
			if (bSomethingMoved == false)
			{
				_timer.stop();
				ClearGraphics();
				CompletionCallback();
				return;
			}
			
			Repaint();
		}
		
		protected function Repaint():void
		{
			ClearGraphics();
			
			for (var b:int = 0; b < _blocks.length; b++)
			{
				var oBlock:Block = Block(_blocks[b]);
				
				if (oBlock == null)
				{
					continue;
				}
				
				var oBlockLocation:PixelLocation = PixelLocation(_locations[b][0]);
				
				var mcBlock:MovieClip = oBlock.GetGridGraphics();
				mcBlock.x = oBlockLocation.x;
				mcBlock.y = oBlockLocation.y;
				_graphics.addChild(mcBlock);
			}
		}
		
		//- Protected Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}