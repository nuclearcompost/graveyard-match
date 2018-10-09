package
{
	//-----------------------
	//Purpose:				A location in the 2-d grid of blocks
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class GridLocation
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
		
		public function GridLocation(x:int = 0, y:int = 0)
		{
			_x = x;
			_y = y;
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public function ToPixel():PixelLocation
		{
			var iX:int = UIManager.GRID_X + (_x * UIManager.BLOCK_WIDTH);
			var iY:int = UIManager.GRID_Y + (_y * UIManager.BLOCK_HEIGHT);
			var oPixelLocation:PixelLocation = new PixelLocation(iX, iY);
			
			return oPixelLocation;
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}