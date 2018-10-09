package
{
	//-----------------------
	//Purpose:				Information about a block shift operation
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class BlockShift
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get deltaGridX():int
		{
			return _deltaGridX;
		}
		
		public function set deltaGridX(value:int):void
		{
			_deltaGridX = value;
		}
		
		public function get deltaGridY():int
		{
			return _deltaGridY;
		}
		
		public function set deltaGridY(value:int):void
		{
			_deltaGridY = value;
		}
		
		public function get startGridX():int
		{
			return _startGridX;
		}
		
		public function set startGridX(value:int):void
		{
			_startGridX = value;
		}
		
		public function get startGridY():int
		{
			return _startGridY;
		}
		
		public function set startGridY(value:int):void
		{
			_startGridY = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _deltaGridX:int;
		private var _deltaGridY:int;
		private var _startGridX:int;
		private var _startGridY:int;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function BlockShift(startGridX:int, startGridY:int, deltaGridX:int, deltaGridY:int)
		{
			_startGridX = startGridX;
			_startGridY = startGridY;
			_deltaGridX = deltaGridX;
			_deltaGridY = deltaGridY;			
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public function Equals(other:BlockShift):Boolean
		{
			if (_startGridX != other.startGridX)
			{
				return false;
			}
			
			if (_startGridY != other.startGridY)
			{
				return false;
			}
			
			if (_deltaGridX != other.deltaGridX)
			{
				return false;
			}
			
			if (_deltaGridY != other.deltaGridY)
			{
				return false;
			}
			
			return true;
		}
		
		public static function PrettyPrintBlockShiftList(list:Array):String
		{
			var sOutput:String = "";
			
			if (list == null)
			{
				return "";
			}
			
			for (var i:int = 0; i < list.length; i++)
			{
				var oObject:Object = list[i];
				
				if (oObject == null)
				{
					continue;
				}
				
				if (!(oObject is BlockShift))
				{
					continue;
				}
				
				var oBlockShift:BlockShift = BlockShift(oObject);
				
				sOutput += (oBlockShift.startGridX + "," + oBlockShift.startGridY + "," + oBlockShift.deltaGridX + "," + oBlockShift.deltaGridY + "\n");
			}
			
			return sOutput;
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}