package
{
	import flash.display.MovieClip;
	
	//-----------------------
	//Purpose:				A block to be matched
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class Block
	{
		// Constants //
		
		public static const EDGE_TOP:int = 0;
		public static const EDGE_BOTTOM:int = 1;
		public static const EDGE_LEFT:int = 2;
		public static const EDGE_RIGHT:int = 3;
		
		public static const TYPE_ONE:int = 0;
		public static const TYPE_TWO:int = 1;
		public static const TYPE_THREE:int = 2;
		public static const TYPE_FOUR:int = 3;
		public static const TYPE_FIVE:int = 4;
		public static const TYPE_SIX:int = 5;
		public static const NUM_TYPES:int = 6;
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get type():int
		{
			return _type;
		}
		
		public function set type(value:int):void
		{
			_type = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _type:int;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function Block(type:int = 0)
		{
			_type = type;
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public function GetGridGraphics():MovieClip
		{
			var mcBlock:Grid_Block_MC = new Grid_Block_MC();
			mcBlock.gotoAndStop(_type + 1);
			
			return mcBlock;
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}