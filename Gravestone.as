package
{
	import flash.display.MovieClip;
	
	//-----------------------
	//Purpose:				Gravestone to be knocked down by flinging matches
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class Gravestone
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get graveLocation():GraveLocation
		{
			return _graveLocation;
		}
		
		public function set graveLocation(value:GraveLocation):void
		{
			_graveLocation = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _graveLocation:GraveLocation;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function Gravestone(side:int, position:int)
		{
			_graveLocation = new GraveLocation(side, position);
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public function GetGraphics():MovieClip
		{
			var mcGrave:Grid_Gravestone_MC = new Grid_Gravestone_MC();
			
			return mcGrave;
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}