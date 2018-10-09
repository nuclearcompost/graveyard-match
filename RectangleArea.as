package
{
	//-----------------------
	//Purpose:				A rectangular area on the screen
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class RectangleArea
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get bottom():int
		{
			return _bottom;
		}
		
		public function set bottom(value:int):void
		{
			_bottom = value;
		}
		
		public function get left():int
		{
			return _left;
		}
		
		public function set left(value:int):void
		{
			_left = value;
		}
		
		public function get right():int
		{
			return _right;
		}
		
		public function set right(value:int):void
		{
			_right = value;
		}
		
		public function get top():int
		{
			return _top;
		}
		
		public function set top(value:int):void
		{
			_top = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _bottom:int;
		private var _left:int;
		private var _right:int;
		private var _top:int;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function RectangleArea(top:int = -1, bottom:int = -1, left:int = -1, right:int = -1)
		{
			_top = top;
			_bottom = bottom;
			_left = left;
			_right = right;
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}