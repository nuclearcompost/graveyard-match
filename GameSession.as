package
{
	//-----------------------
	//Purpose:				Initialization and data for a gameplay session
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class GameSession
	{
		// Constants //
		
		public static const MAX_TICKS:int = 1800;
		
		public static const GRID_WIDTH:int = 8;
		public static const GRID_HEIGHT:int = 8;
		
		public static const NUM_GRAVESTONES:int = 12;
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get gameTicks():int
		{
			return _gameTicks;
		}
		
		public function set gameTicks(value:int):void
		{
			_gameTicks = value;
		}
		
		public function get gravestones():Array
		{
			return _gravestones;
		}
		
		public function set gravestones(value:Array):void
		{
			_gravestones = value;
		}
		
		public function get grid():Array
		{
			return _grid;
		}
		
		public function set grid(value:Array):void
		{
			_grid = value;
		}
		
		public function get score():int
		{
			return _score;
		}
		
		public function set score(value:int):void
		{
			_score = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _gameTicks:int;
		private var _gravestones:Array;
		private var _grid:Array;
		private var _score:int;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function GameSession()
		{
			_score = 0;
			_gameTicks = GameSession.MAX_TICKS;
			_gravestones = new Array();
			InitializeGravestones();
			
			_grid = new Array(GameSession.GRID_WIDTH);
			for (var x:int = 0; x < GameSession.GRID_WIDTH; x++)
			{
				_grid[x] = new Array(GameSession.GRID_HEIGHT);
			}
			
			RandomizeGrid();
		}
		
		private function InitializeGravestones():void
		{
			for (var i:int = 0; i < GameSession.NUM_GRAVESTONES; i++)
			{
				GraveService.AddGravestone(_gravestones);
			}
		}
		
		//- Initialization -//
		
		
		// Public Methods //
		
		public function RandomizeGrid():void
		{
			for (var x:int = 0; x < GameSession.GRID_WIDTH; x++)
			{
				for (var y:int = 0; y < GameSession.GRID_HEIGHT; y++)
				{
					var iType:int = Math.floor(Math.random() * Block.NUM_TYPES);
					_grid[x][y] = new Block(iType);
				}
			}
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}