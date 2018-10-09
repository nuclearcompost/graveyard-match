package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	//-----------------------
	//Purpose:				The game's tutorial
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class Tutorial extends MovieClip
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _application:Application;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function Tutorial(application:Application)
		{
			_application = application;
			
			Paint();
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		private function Paint():void
		{
			var mcBackground:Tutorial_Background_MC = new Tutorial_Background_MC();
			mcBackground.x = UIManager.SCREEN_WIDTH / 2;
			mcBackground.y = UIManager.SCREEN_HEIGHT / 2;
			this.addChild(mcBackground);
			
			var mcOkButton:Tutorial_Ok_Btn = new Tutorial_Ok_Btn();
			mcOkButton.x = (UIManager.SCREEN_WIDTH - mcOkButton.width) / 2;
			mcOkButton.y = 625;
			mcOkButton.addEventListener(MouseEvent.CLICK, OnOkButtonClick, false, 0, true);
			this.addChild(mcOkButton);
		}
		
		private function OnOkButtonClick(event:MouseEvent):void
		{
			event.stopPropagation();
			
			var iNumChildren:int = this.numChildren;
			for (var i:int = 0; i < iNumChildren; i++)
			{
				this.removeChildAt(0);
			}
			
			_application.ModeSwapTutorialToGame();
		}
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}