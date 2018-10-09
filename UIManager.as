package
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	//-----------------------
	//Purpose:				Drawing logic for a game session
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class UIManager extends MovieClip
	{
		// Constants //
		
		public static const BLOCK_WIDTH:int = 64;
		public static const BLOCK_HEIGHT:int = 64;
		public static const GRID_X:int = 94;
		public static const GRID_Y:int = 94;
		
		private static const GRAVE_TOP_Y:int = 2;
		private static const GRAVE_BOTTOM_Y:int = 621;
		private static const GRAVE_LEFT_X:int = 15;
		private static const GRAVE_RIGHT_X:int = 621;
		
		private static const UI_TOP = 686;
		private static const UI_LEFT = 0;
		
		public static const SCREEN_WIDTH:int = 700;
		public static const SCREEN_HEIGHT:int = 750;
		
		private static const GAME_TIMER_BAR_WIDTH:int = 300;
		
		private static const BG_TILE_BOTTOM = 1;
		private static const BG_TILE_TOP_LEFT = 2;
		private static const BG_TILE_TOP_RIGHT = 3;
		private static const BG_TILE_RIGHT = 4;
		private static const BG_TILE_GRASS = 5;
		private static const BG_TILE_LEFT = 6;
		private static const BG_TILE_BOTTOM_LEFT = 7;
		private static const BG_TILE_BOTTOM_RIGHT = 8;
		private static const BG_TILE_TOP = 9;
		private static const BG_TILE_DIRT = 10;
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get acceptingUserEvents():Boolean
		{
			return _acceptingUserEvents;
		}
		
		public function set acceptingUserEvents(value:Boolean):void
		{
			_acceptingUserEvents = value;
		}
		
		public function set gameController(value:GameController):void
		{
			_gameController = value;
		}
		
		public function set gameSession(value:GameSession):void
		{
			_gameSession = value;
		}
		
		public function get gridAnimationGraphics():MovieClip
		{
			return _gridAnimationGraphics;
		}
		
		public function get soundToggle():MusicToggle
		{
			return _soundToggle;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _acceptingUserEvents:Boolean;
		private var _gameController:GameController;
		private var _gameSession:GameSession;
		private var _soundToggle:MusicToggle;
		private var _swapArea:RectangleArea;
		
		private var _backgroundGraphics:MovieClip;
		private var _gameTimerGraphics:MovieClip;
		private var _graphics:MovieClip;
		private var _gravestoneGraphics:MovieClip;
		private var _gridGraphics:MovieClip;
		private var _gridAnimationGraphics:MovieClip;
		private var _scoreGraphics:MovieClip;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function UIManager(backgroundToggle:MusicToggle)
		{
			_soundToggle = backgroundToggle;
			
			_acceptingUserEvents = true;
			ClearSwapArea();
			
			_graphics = new MovieClip();
			this.addChild(_graphics);
			
			_backgroundGraphics = new MovieClip();
			_graphics.addChild(_backgroundGraphics);
			
			_gravestoneGraphics = new MovieClip();
			_graphics.addChild(_gravestoneGraphics);
			
			_gridGraphics = new MovieClip();
			_gridGraphics.addEventListener(MouseEvent.MOUSE_DOWN, OnGridMouseDown, false, 0, true);
			_gridGraphics.addEventListener(MouseEvent.MOUSE_UP, OnGridMouseUp, false, 0, true);
			_gridGraphics.addEventListener(MouseEvent.MOUSE_MOVE, OnGridMouseMove, false, 0, true);
			_graphics.addChild(_gridGraphics);
			
			_gridAnimationGraphics = new MovieClip();
			_graphics.addChild(_gridAnimationGraphics);
			
			_scoreGraphics = new MovieClip();
			_graphics.addChild(_scoreGraphics);
			
			_gameTimerGraphics = new MovieClip();
			_graphics.addChild(_gameTimerGraphics);
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public function RepaintAll():void
		{
			RepaintBackground();
			RepaintGravestones();
			RepaintGrid();
			RepaintScore();
		}
		
		public function RepaintGameTimer():void
		{
			var iNumChildren:int = _gameTimerGraphics.numChildren;
			
			for (var i:int = 0; i < iNumChildren; i++)
			{
				_gameTimerGraphics.removeChildAt(0);
			}
			
			_gameTimerGraphics.graphics.clear();
			
			_gameTimerGraphics.graphics.beginFill(0x93AE19);
			_gameTimerGraphics.graphics.moveTo(620, 705);
			
			var nPercentFull:Number = (_gameSession.gameTicks / GameSession.MAX_TICKS) * 100;
			var iBarWidth:int = (nPercentFull / 100) * UIManager.GAME_TIMER_BAR_WIDTH;
			
			_gameTimerGraphics.graphics.lineTo(620 - iBarWidth, 705);
			_gameTimerGraphics.graphics.lineTo(620 - iBarWidth, 735);
			_gameTimerGraphics.graphics.lineTo(620, 735);
			_gameTimerGraphics.graphics.lineTo(620, 705);
			_gameTimerGraphics.graphics.endFill();
		}
		
		public static function GetGravestonePixelLocation(side:int, position:int):PixelLocation
		{
			var oPixelLocation:PixelLocation = new PixelLocation(0, 0);
			
			switch(side)
			{
				case GraveLocation.SIDE_TOP:
					oPixelLocation.x = UIManager.GRID_X + (UIManager.BLOCK_WIDTH * position);
					oPixelLocation.y = UIManager.GRAVE_TOP_Y;
					break;
				case GraveLocation.SIDE_BOTTOM:
					oPixelLocation.x = UIManager.GRID_X + (UIManager.BLOCK_WIDTH * position);
					oPixelLocation.y = UIManager.GRAVE_BOTTOM_Y;
					break;
				case GraveLocation.SIDE_LEFT:
					oPixelLocation.x = UIManager.GRAVE_LEFT_X;
					oPixelLocation.y = UIManager.GRID_Y + (UIManager.BLOCK_HEIGHT * position);
					break;
				case GraveLocation.SIDE_RIGHT:
					oPixelLocation.x = UIManager.GRAVE_RIGHT_X;
					oPixelLocation.y = UIManager.GRID_Y + (UIManager.BLOCK_HEIGHT * position);
					break;
				default:
					break;
			}
			
			return oPixelLocation;
		}
		
		public static function GetOffscreenPixelLocation(side:int, position:int):PixelLocation
		{
			var oPixelLocation:PixelLocation = new PixelLocation(0, 0);
			
			switch(side)
			{
				case GraveLocation.SIDE_TOP:
					oPixelLocation.x = UIManager.GRID_X + (UIManager.BLOCK_WIDTH * position);
					oPixelLocation.y = -1 * UIManager.BLOCK_HEIGHT;
					break;
				case GraveLocation.SIDE_BOTTOM:
					oPixelLocation.x = UIManager.GRID_X + (UIManager.BLOCK_WIDTH * position);
					oPixelLocation.y = UIManager.SCREEN_HEIGHT;
					break;
				case GraveLocation.SIDE_LEFT:
					oPixelLocation.x = -1 * UIManager.BLOCK_WIDTH;
					oPixelLocation.y = UIManager.GRID_Y + (UIManager.BLOCK_HEIGHT * position);
					break;
				case GraveLocation.SIDE_RIGHT:
					oPixelLocation.x = UIManager.SCREEN_WIDTH;
					oPixelLocation.y = UIManager.GRID_Y + (UIManager.BLOCK_HEIGHT * position);
					break;
				default:
					break;
			}
			
			return oPixelLocation;
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		/// Core Functionality ///
		
		private function ClearSwapArea():void
		{
			_swapArea = new RectangleArea(-1, -1, -1, -1);
		}
		
		private function IsSwapAreaSet():Boolean
		{
			if (_swapArea.left == -1)
			{
				return false;
			}
			
			return true;
		}
		
		private function SetSwapAreaForGridLocation(gridLocation:GridLocation):void
		{
			var oSwapArea:RectangleArea = new RectangleArea();
			
			oSwapArea.left = UIManager.GRID_X + (gridLocation.x * UIManager.BLOCK_WIDTH);
			oSwapArea.right = oSwapArea.left + UIManager.BLOCK_WIDTH;
			oSwapArea.top = UIManager.GRID_Y + (gridLocation.y * UIManager.BLOCK_HEIGHT);
			oSwapArea.bottom = oSwapArea.top + UIManager.BLOCK_HEIGHT;
			
			_swapArea = oSwapArea;
		}
		
		///- Core Functionality -///
		
		
		/// Event Handlers ///
		
		private function OnGridMouseDown(event:MouseEvent):void
		{
			event.stopPropagation();
			
			if (_acceptingUserEvents == false)
			{
				return;
			}
			
			var oPixelLocation:PixelLocation = new PixelLocation(event.stageX, event.stageY);
			var oGridLocation:GridLocation = oPixelLocation.ToGrid();
			
			if (GridService.IsValidGridLocation(oGridLocation) == true)
			{
				SetSwapAreaForGridLocation(oGridLocation);
			}
		}
		
		private function OnGridMouseUp(event:MouseEvent):void
		{
			event.stopPropagation();
			
			if (_acceptingUserEvents == false)
			{
				return;
			}
			
			ClearSwapArea();
		}
		
		private function OnGridMouseMove(event:MouseEvent):void
		{
			event.stopPropagation();
			
			if (_acceptingUserEvents == false)
			{
				return;
			}
			
			if (IsSwapAreaSet() == false)
			{
				return;
			}
			
			var oPixelLocation:PixelLocation = new PixelLocation(_swapArea.left + 1, _swapArea.top + 1);
			var oGridLocation:GridLocation = oPixelLocation.ToGrid();
			
			var oSwapBlockCoords:GridLocation = null;
			
			if (event.stageX < _swapArea.left)
			{
				oSwapBlockCoords = new GridLocation(oGridLocation.x - 1, oGridLocation.y);
			}
			else if (event.stageX > _swapArea.right)
			{
				oSwapBlockCoords = new GridLocation(oGridLocation.x + 1, oGridLocation.y);
			}
			else if (event.stageY < _swapArea.top)
			{
				oSwapBlockCoords = new GridLocation(oGridLocation.x, oGridLocation.y - 1);
			}
			else if (event.stageY > _swapArea.bottom)
			{
				oSwapBlockCoords = new GridLocation(oGridLocation.x, oGridLocation.y + 1);
			}
			
			if (oSwapBlockCoords == null)
			{
				return;
			}
			
			if (GridService.IsValidGridLocation(oSwapBlockCoords) == false)
			{
				return;
			}
			
			_acceptingUserEvents = false;
			
			var oBlockSwap:BlockSwap = new BlockSwap();
			oBlockSwap.originGridLocation = new GridLocation(oGridLocation.x, oGridLocation.y);
			oBlockSwap.targetGridLocation = new GridLocation(oSwapBlockCoords.x, oSwapBlockCoords.y);
			
			_gameController.SwapBlocks(oBlockSwap);
			
			ClearSwapArea();
		}
		
		private function OnMusicToggleClick(event:MouseEvent):void
		{
			event.stopPropagation();
			
			_soundToggle.Toggle();
			RepaintBackground();
		}
		
		///- Event Handlers -///
		
		
		/// Graphics ///
		
		private function RepaintBackground():void
		{
			var iNumChildren:int = _backgroundGraphics.numChildren;
			
			for (var i:int = 0; i < iNumChildren; i++)
			{
				_backgroundGraphics.removeChildAt(0);
			}
			
			// dirt behind tiles
			for (var x:int = -1; x < GameSession.GRID_WIDTH + 1; x++)
			{
				for (var y:int = -1; y < GameSession.GRID_HEIGHT + 1; y++)
				{
					var mapTile:MovieClip = new BackgroundTile();
					mapTile.x = UIManager.GRID_X + (x * UIManager.BLOCK_WIDTH);
					mapTile.y = UIManager.GRID_Y + (y * UIManager.BLOCK_HEIGHT);
					mapTile.gotoAndStop(UIManager.BG_TILE_DIRT);
					_backgroundGraphics.addChild(mapTile);
				}
			}
			
			// grass on top of dirt
			for (x = -2; x < GameSession.GRID_WIDTH + 2; x++)
			{
				for (y = -2; y < GameSession.GRID_HEIGHT + 3; y++)
				{
					if (x >= 0 && x < GameSession.GRID_WIDTH && y >= 0 && y < GameSession.GRID_HEIGHT)
					{
						continue;
					}
					
					mapTile = new BackgroundTile();
					mapTile.x = UIManager.GRID_X + (x * UIManager.BLOCK_WIDTH);
					mapTile.y = UIManager.GRID_Y + (y * UIManager.BLOCK_HEIGHT);
					
					if (x == -1 && y == -1)
					{
						mapTile.gotoAndStop(UIManager.BG_TILE_TOP_LEFT);
					}
					else if (x == -1 && y == GameSession.GRID_HEIGHT)
					{
						mapTile.gotoAndStop(UIManager.BG_TILE_BOTTOM_LEFT);
					}
					else if (x == GameSession.GRID_WIDTH && y == -1)
					{
						mapTile.gotoAndStop(UIManager.BG_TILE_TOP_RIGHT);
					}
					else if (x == GameSession.GRID_WIDTH && y == GameSession.GRID_HEIGHT)
					{
						mapTile.gotoAndStop(UIManager.BG_TILE_BOTTOM_RIGHT);
					}
					else if (x == -1 && y >=0 && y < GameSession.GRID_HEIGHT)
					{
						mapTile.gotoAndStop(UIManager.BG_TILE_LEFT);
					}
					else if (x == GameSession.GRID_WIDTH && y >=0 && y < GameSession.GRID_HEIGHT)
					{
						mapTile.gotoAndStop(UIManager.BG_TILE_RIGHT);
					}
					else if (y == -1 && x >= 0 && x < GameSession.GRID_WIDTH)
					{
						mapTile.gotoAndStop(UIManager.BG_TILE_TOP);
					}
					else if (y == GameSession.GRID_HEIGHT && x >= 0 && x < GameSession.GRID_WIDTH)
					{
						mapTile.gotoAndStop(UIManager.BG_TILE_BOTTOM);
					}
					else
					{
						mapTile.gotoAndStop(UIManager.BG_TILE_GRASS);
					}
					
					_backgroundGraphics.addChild(mapTile);
				}
			}
			
			// ui background
			var ui_mc:MovieClip = new UI_MC();
			ui_mc.x = UIManager.UI_LEFT;
			ui_mc.y = UIManager.UI_TOP;
			_backgroundGraphics.addChild(ui_mc);
		}
		
		private function RepaintGravestones():void
		{
			var iNumChildren:int = _gravestoneGraphics.numChildren;
			
			for (var i:int = 0; i < iNumChildren; i++)
			{
				_gravestoneGraphics.removeChildAt(0);
			}
			
			for (i = 0; i < _gameSession.gravestones.length; i++)
			{
				var oGravestone:Gravestone = Gravestone(_gameSession.gravestones[i]);
				
				var mcGravestone:MovieClip = oGravestone.GetGraphics();
				
				var oPixelLocation:PixelLocation = UIManager.GetGravestonePixelLocation(oGravestone.graveLocation.side, oGravestone.graveLocation.position);
				
				mcGravestone.x = oPixelLocation.x;
				mcGravestone.y = oPixelLocation.y;
				
				_gravestoneGraphics.addChild(mcGravestone);
			}
		}
		
		private function RepaintGrid():void
		{
			var iNumChildren:int = _gridGraphics.numChildren;
			
			for (var i:int = 0; i < iNumChildren; i++)
			{
				_gridGraphics.removeChildAt(0);
			}
			
			for (var x:int = 0; x < GameSession.GRID_WIDTH; x++)
			{
				for (var y:int = 0; y < GameSession.GRID_HEIGHT; y++)
				{
					var oObject:Object = _gameSession.grid[x][y];
					
					if (oObject == null)
					{
						continue;
					}
					
					if (!(oObject is Block))
					{
						continue;
					}
					
					var oBlock:Block = Block(oObject);
					
					var mcBlock:MovieClip = oBlock.GetGridGraphics();
					mcBlock.x = UIManager.GRID_X + (x * UIManager.BLOCK_WIDTH);
					mcBlock.y = UIManager.GRID_Y + (y * UIManager.BLOCK_HEIGHT);
					_gridGraphics.addChild(mcBlock);
				}
			}
		}
		
		private function RepaintScore():void
		{
			var iNumChildren:int = _scoreGraphics.numChildren;
			
			for (var i:int = 0; i < iNumChildren; i++)
			{
				_scoreGraphics.removeChildAt(0);
			}
			
			var lDigits:Array = ScoreService.ParseScore(_gameSession.score);
			var iX:int = 275;
			
			for (var iDigit:int = (lDigits.length - 1); iDigit >= 0; iDigit--)
			{
				var iValue:int = lDigits[iDigit];
				
				var mcDigit:Score_Number_MC = new Score_Number_MC();
				mcDigit.gotoAndStop(iValue + 1);
				mcDigit.x = iX;
				mcDigit.y = 695;
				_scoreGraphics.addChild(mcDigit);
				
				iX -= 35;
			}
		}
		
		///- Graphics -///
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}