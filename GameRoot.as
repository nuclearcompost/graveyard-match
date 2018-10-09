package
{
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	//-----------------------
	//Purpose:				The application root for a GameSession
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class GameRoot extends MovieClip
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get controller():GameController
		{
			return _gameController;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _application:Application;
		private var _gameController:GameController;
		private var _gameSession:GameSession;
		private var _gameTimer:Timer;
		private var _uiManager:UIManager;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function GameRoot(application:Application, backgroundToggle:MusicToggle)
		{
			_application = application;
			
			_gameSession = new GameSession();
			_uiManager = new UIManager(backgroundToggle);
			_gameController = new GameController(this, _gameSession, _uiManager);
			
			this.addChild(_uiManager);
			_uiManager.gameSession = _gameSession;
			_uiManager.gameController = _gameController;
			_uiManager.RepaintAll();
			
			_gameTimer = new Timer(33);
			_gameTimer.addEventListener(TimerEvent.TIMER, OnGameTimer);
			_gameTimer.start();
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		private function OnGameTimer(event:TimerEvent):void
		{
			event.stopPropagation();
			
			_gameSession.gameTicks--;
			
			if (_gameSession.gameTicks <= 0)
			{
				_gameTimer.stop();
				_application.ModeSwapGameToGameOver(_gameSession.score);
				return;
			}
			
			_uiManager.RepaintGameTimer();
		}
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}