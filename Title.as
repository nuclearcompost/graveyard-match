package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	//-----------------------
	//Purpose:				The title screen
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class Title extends MovieClip
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _application:Application;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function Title(application:Application)
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
			var mcBackground:Title_Background_MC = new Title_Background_MC();
			mcBackground.x = mcBackground.width / 2;
			mcBackground.y = mcBackground.height / 2;
			this.addChild(mcBackground);
			
			var mcPlayButton:Title_Play_Btn = new Title_Play_Btn();
			mcPlayButton.x = 475;
			mcPlayButton.y = 500;
			mcPlayButton.addEventListener(MouseEvent.CLICK, OnPlayButtonClick, false, 0, true);
			this.addChild(mcPlayButton);
		}
		
		private function OnPlayButtonClick(event:MouseEvent):void
		{
			event.stopPropagation();
			
			_application.ModeSwapTitleToTutorial();
		}
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}