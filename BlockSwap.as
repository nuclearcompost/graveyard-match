package
{
	//-----------------------
	//Purpose:				State object for all the information processed when blocks are swapped on the grid
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class BlockSwap
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get blockShiftBlocks():Array
		{
			return _blockShiftBlocks;
		}
		
		public function set blockShiftBlocks(value:Array):void
		{
			_blockShiftBlocks = value;
		}
		
		public function get blockShifts():Array
		{
			return _blockShifts;
		}
		
		public function set blockShifts(value:Array):void
		{
			_blockShifts = value;
		}
		
		public function get flingPosition():int
		{
			return _flingPosition;
		}
		
		public function set flingPosition(value:int):void
		{
			_flingPosition = value;
		}
		
		public function get flingSide():int
		{
			return _flingSide;
		}
		
		public function set flingSide(value:int):void
		{
			_flingSide = value;
		}
		
		public function get matchedBlockGridLocations():Array
		{
			return _matchedBlockGridLocations;
		}
		
		public function set matchedBlockGridLocations(value:Array):void
		{
			_matchedBlockGridLocations = value;
		}
		
		public function get matchedBlocks():Array
		{
			return _matchedBlocks;
		}
		
		public function set matchedBlocks(value:Array):void
		{
			_matchedBlocks = value;
		}
		
		public function get originBlock():Block
		{
			return _originBlock;
		}
		
		public function set originBlock(value:Block):void
		{
			_originBlock = value;
		}
		
		public function get originGridLocation():GridLocation
		{
			return _originGridLocation;
		}
		
		public function set originGridLocation(value:GridLocation):void
		{
			_originGridLocation = value;
		}
		
		public function get originMatchCount():int
		{
			return _originMatchCount;
		}
		
		public function set originMatchCount(value:int):void
		{
			_originMatchCount = value;
		}
		
		public function get originMatched():Boolean
		{
			return _originMatched;
		}
		
		public function set originMatched(value:Boolean):void
		{
			_originMatched = value;
		}
		
		public function get targetBlock():Block
		{
			return _targetBlock;
		}
		
		public function set targetBlock(value:Block):void
		{
			_targetBlock = value;
		}
		
		public function get targetGridLocation():GridLocation
		{
			return _targetGridLocation;
		}
		
		public function set targetGridLocation(value:GridLocation):void
		{
			_targetGridLocation = value;
		}
		
		public function get targetMatchCount():int
		{
			return _targetMatchCount;
		}
		
		public function set targetMatchCount(value:int):void
		{
			_targetMatchCount = value;
		}
		
		public function get targetMatched():Boolean
		{
			return _targetMatched;
		}
		
		public function set targetMatched(value:Boolean):void
		{
			_targetMatched = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _blockShiftBlocks:Array;
		private var _blockShifts:Array;
		private var _flingPosition:int;
		private var _flingSide:int;
		private var _matchedBlockGridLocations:Array;
		private var _matchedBlocks:Array;
		private var _originBlock:Block;
		private var _originGridLocation:GridLocation;
		private var _originMatchCount:int;
		private var _originMatched:Boolean;
		private var _targetBlock:Block;
		private var _targetGridLocation:GridLocation;
		private var _targetMatchCount:int;
		private var _targetMatched:Boolean;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function BlockSwap()
		{
			_blockShiftBlocks = new Array();
			_blockShifts = new Array();
			_matchedBlockGridLocations = new Array();
			_matchedBlocks = new Array();
			_originMatched = false;
			_targetMatched = false;
			_originMatchCount = 0;
			_targetMatchCount = 0;
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