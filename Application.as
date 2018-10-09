package
{
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
//package
//{
//	//-----------------------
//	//Purpose:				
//	//Properties:
//	//	
//	//Methods:
//	//	
//	//-----------------------
//	public class Main
//	{
//		// Constants //
//		
//		//- Constants -//
//		
//		
//		// Public Properties //
//		
//		//- Public Properties -//
//		
//		
//		// Private Properties //
//		
//		//- Private Properties -//
//		
//	
//		// Initialization //
//		
//		public function Main()
//		{
//			
//		}
//	
//		//- Initialization -//
//		
//		
//		// Public Methods //
//		
//		//- Public Methods -//
//		
//		
//		// Private Methods //
//		
//		//- Private Methods -//
//		
//		
//		// Testing Methods //
//		
//		//- Testing Methods -//
//	}
//}
	
	
	//-----------------------
	//Purpose:				
	//Public Properties:
	//	
	//Public Methods:
	//	
	//-----------------------
	
		//---------------
		//Purpose:		
		//Parameters:
		//	
		//Returns:		
		//---------------
	
	//-----------------------
	//Purpose:				The document class for the swf movie, called on startup
	//
	//Public Properties:
	//
	//Public Methods:
	//	
	//-----------------------
	public class Application extends MovieClip
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _backgroundMusic:Sound;
		private var _backgroundMusicChannel:SoundChannel;
		private var _game:GameRoot;
		private var _gameOver:GameOver;
		private var _title:Title;
		private var _tutorial:Tutorial;
		
		//- Private Properties -//
	
	
		// Initialization //
		
		public function Application()
		{
			var iUnitTestOutputType:int = UnitTest.OUTPUT_NONE;
			
			if (iUnitTestOutputType != UnitTest.OUTPUT_NONE)
			{
				UnitTest.RunTests(iUnitTestOutputType);
			}
			
			ClearStage();
			PutUpTitle();
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public function ModeSwapTitleToTutorial():void
		{
			TakeDownTitle();
			PutUpTutorial();
		}
		
		public function ModeSwapTutorialToGame():void
		{
			TakeDownTutorial();
			PutUpGame();
		}
		
		public function ModeSwapGameToGameOver(score:int):void
		{
			TakeDownGame();
			PutUpGameOver(score);
		}
		
		public function ModeSwapGameOverToGame():void
		{
			TakeDownGameOver();
			PutUpGame();
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		private function ClearStage():void
		{
			for (var m:int = 0; m < this.numChildren; m++)
			{
				this.removeChildAt(0);
			}
		}
		
		private function PutUpGame():void
		{
			_game = new GameRoot(this, new MusicToggle(_backgroundMusic, _backgroundMusicChannel));
			stage.addChild(_game);
		}
		
		private function PutUpGameOver(score:int):void
		{
			_gameOver = new GameOver(this, score);
			stage.addChild(_gameOver);
		}
		
		private function PutUpTitle():void
		{
			_title = new Title(this);
			stage.addChild(_title);
		}
		
		private function PutUpTutorial():void
		{
			_tutorial = new Tutorial(this);
			stage.addChild(_tutorial);
		}
		
		private function TakeDownGame():void
		{
			stage.removeChild(_game);
		}
		
		private function TakeDownGameOver():void
		{
			stage.removeChild(_gameOver);
		}
		
		private function TakeDownTitle():void
		{
			stage.removeChild(_title);
		}
		
		private function TakeDownTutorial():void
		{
			stage.removeChild(_tutorial);
		}
		
		//- Private Methods -//
	}
}