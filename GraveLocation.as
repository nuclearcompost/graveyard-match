package
{
	//-----------------------
	//Purpose:				
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class GraveLocation
	{
		// Constants //
		
		public static const SIDE_TOP:int = 0;
		public static const SIDE_BOTTOM:int = 1;
		public static const SIDE_LEFT:int = 2;
		public static const SIDE_RIGHT:int = 3;
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get position():int
		{
			return _position;
		}
		
		public function set position(value:int):void
		{
			_position = value;
		}
		
		public function get side():int
		{
			return _side;
		}
		
		public function set side(value:int):void
		{
			_side = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _position:int;
		private var _side:int;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function GraveLocation(side:int = 0, position:int = 0)
		{
			_side = side;
			_position = position;
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public function Equals(other:GraveLocation):Boolean
		{
			if (other == null)
			{
				return false;
			}
			
			if (_side == other.side && _position == other.position)
			{
				return true;
			}
			
			return false;
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}