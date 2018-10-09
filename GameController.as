package
{
	//-----------------------
	//Purpose:				Event handling logic for a gameplay session
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class GameController
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _gameRoot:GameRoot;
		private var _gameSession:GameSession;
		private var _uiManager:UIManager;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function GameController(gameRoot:GameRoot, gameSession:GameSession, uiManager:UIManager)
		{
			_gameRoot = gameRoot;
			_gameSession = gameSession;
			_uiManager = uiManager;
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public function Repaint():void
		{
			_uiManager.RepaintAll();
		}
		
		public function ResolveFlingBlocks(blockSwap:BlockSwap):void
		{
			var bHitGravestone:Boolean = GraveService.RemoveGraveAtLocation(_gameSession.gravestones, new GraveLocation(blockSwap.flingSide, blockSwap.flingPosition));
			
			if (bHitGravestone == true)
			{
				GraveService.AddGravestone(_gameSession.gravestones);
			}
			
			var iScore:int = ScoreService.ScoreSwap(blockSwap, bHitGravestone);
			_gameSession.score += iScore;
			_gameSession.gameTicks += iScore;
			
			if (_gameSession.gameTicks > GameSession.MAX_TICKS)
			{
				_gameSession.gameTicks = GameSession.MAX_TICKS;
			}
			
			Repaint();
			
			GridService.InitiateUpdateGrid(this, _uiManager.gridAnimationGraphics, _gameSession.grid, blockSwap);
		}
		
		public function ResolveMatchBlocks(blockSwap:BlockSwap):void
		{
			Repaint();
			
			GridService.InitiateFlingBlocks(this, _uiManager.gridAnimationGraphics, _gameSession.grid, _gameSession.gravestones, blockSwap);
		}
		
		public function ResolveSwapBlock(blockSwap:BlockSwap):void
		{
			Repaint();
			
			GridService.InitiateMatchBlocks(this, _uiManager.gridAnimationGraphics, _gameSession.grid, blockSwap);
			
			if (blockSwap.matchedBlockGridLocations.length == 0)
			{
				_uiManager.acceptingUserEvents = true;
				Repaint();
			}
		}
		
		public function ResolveUpdateGrid(blockSwap:BlockSwap):void
		{
			GridService.ShiftBlocks(_gameSession.grid, blockSwap);
			_uiManager.acceptingUserEvents = true;
			Repaint();
		}
		
		public function SwapBlocks(blockSwap:BlockSwap):void
		{
			blockSwap.originBlock = _gameSession.grid[blockSwap.originGridLocation.x][blockSwap.originGridLocation.y];
			blockSwap.targetBlock = _gameSession.grid[blockSwap.targetGridLocation.x][blockSwap.targetGridLocation.y];
			
			GridService.InitiateSwapBlocks(this, _uiManager.gridAnimationGraphics, _gameSession.grid, blockSwap);
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}