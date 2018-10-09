package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	//-----------------------
	//Purpose:				End of game screen
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class GameOver extends MovieClip
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _application:Application;
		private var _score:int;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function GameOver(application:Application, score:int)
		{
			_application = application;
			_score = score;
			
			Paint();
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		private function Paint():void
		{
			var mcBackground:GameOver_Background_MC = new GameOver_Background_MC();
			mcBackground.x = UIManager.SCREEN_WIDTH / 2;
			mcBackground.y = UIManager.SCREEN_HEIGHT / 2;
			
			mcBackground.Score.text = String(_score);
			
			this.addChild(mcBackground);
			
			var btnPlayAgain:GameOver_PlayAgain_Btn = new GameOver_PlayAgain_Btn();
			btnPlayAgain.x = (UIManager.SCREEN_WIDTH - btnPlayAgain.width) / 2;
			btnPlayAgain.y = 600;
			btnPlayAgain.addEventListener(MouseEvent.CLICK, OnPlayAgainBtnClick, false, 0, true);
			this.addChild(btnPlayAgain);
		}
		
		private function OnPlayAgainBtnClick(event:MouseEvent):void
		{
			event.stopPropagation();
			
			_application.ModeSwapGameOverToGame();
		}
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}