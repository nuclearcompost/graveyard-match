package
{
	//-----------------------
	//Purpose:				A pixel location on the stage
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class PixelLocation
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get x():int
		{
			return _x;
		}
		
		public function set x(value:int):void
		{
			_x = value;
		}
		
		public function get y():int
		{
			return _y;
		}
		
		public function set y(value:int):void
		{
			_y = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _x:int;
		private var _y:int;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function PixelLocation(x:int = 0, y:int = 0)
		{
			_x = x;
			_y = y;
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public function ToGrid():GridLocation
		{
			var iX:int = Math.floor((_x - UIManager.GRID_X) / UIManager.BLOCK_WIDTH);
			var iY:int = Math.floor((_y - UIManager.GRID_Y) / UIManager.BLOCK_HEIGHT);
			var oGridLocation:GridLocation = new GridLocation(iX, iY);
			
			return oGridLocation;
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}