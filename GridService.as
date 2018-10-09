package
{
	import flash.display.MovieClip;
	
	//-----------------------
	//Purpose:				Service logic for the block grid
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class GridService
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function GridService()
		{
			
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public static function FillEmptyBlocks(grid:Array):void
		{
			if (grid == null)
			{
				return;
			}
			
			for (var x:int = 0; x < grid.length; x++)
			{
				for (var y:int = 0; y < grid[x].length; y++)
				{
					if (grid[x][y] == null)
					{
						grid[x][y] = new Block(Math.floor(Math.random() * Block.NUM_TYPES));
					}
				}
			}
		}
		
		public static function GetBlockShiftList(grid:Array):Array
		{
			if (grid == null)
			{
				return new Array();
			}
			
			var lBlockShifts:Array = new Array();
			
			for (var x:int = 0; x < grid.length; x++)
			{
				var iColumnShiftCount:int = 0;
				
				for (var y:int = grid[x].length - 1; y >= 0; y--)
				{
					var oObject:Object = grid[x][y];
					
					if (oObject == null)
					{
						iColumnShiftCount++;
						continue;
					}
					
					if (iColumnShiftCount > 0)
					{
						lBlockShifts.push(new BlockShift(x, y, 0, iColumnShiftCount));
					}
				}
				
				// additional blockShifts for blocks that need to be spawned above the grid and move down with gravity
				if (iColumnShiftCount > 0)
				{
					for (var i:int = 1; i <= iColumnShiftCount; i++)
					{
						lBlockShifts.push(new BlockShift(x, -1 * i, 0, iColumnShiftCount));
					}
				}
			}
			
			return lBlockShifts;
		}
		
		public static function GetMatchList(grid:Array, origin:GridLocation):Array
		{
			if (grid == null || origin == null)
			{
				return new Array();
			}
			
			if (GridService.IsValidGridLocation(origin) == false)
			{
				return new Array();
			}
			
			var lMatches:Array = new Array();
			
			var oOrigin:Block = Block(grid[origin.x][origin.y]);
			var iMatchType:int = oOrigin.type;
			var lCheck:Array = [ origin ];
			
			var lXOffset:Array = [ 0, 0, -1, 1 ];
			var lYOffset:Array = [ -1, 1, 0, 0 ];
			
			var iCount:int = 0;
			
			while (lCheck.length > 0 && iCount < 100)
			{
				var oCheckLocation:GridLocation = GridLocation(lCheck.shift());
				
				if (GridService.IsValidGridLocation(oCheckLocation) == false)
				{
					continue;
				}
				
				var oCheckBlock:Block = Block(grid[oCheckLocation.x][oCheckLocation.y]);
				
				if (oCheckBlock == null)
				{
					continue;
				}
				
				if (oCheckBlock.type != iMatchType)
				{
					continue;
				}
				
				if (GridService.IsLocationInList(lMatches, oCheckLocation) == true)
				{
					continue;
				}
				
				AddUniqueLocationToList(lMatches, oCheckLocation);
				
				for (var i:int = 0; i < 4; i++)
				{
					var oNewCheckLocation:GridLocation = new GridLocation(oCheckLocation.x + lXOffset[i], oCheckLocation.y + lYOffset[i]);
					AddUniqueLocationToList(lCheck, oNewCheckLocation);
					iCount++;
				}
			}
			
			return lMatches;
		}
		
		public static function InitiateFlingBlocks(gameController:GameController, graphics:MovieClip, grid:Array, gravestones:Array, blockSwap:BlockSwap):void
		{
			// set the fling position
			var iOriginX:int = blockSwap.originGridLocation.x;
			var iOriginY:int = blockSwap.originGridLocation.y;
			var iTargetX:int = blockSwap.targetGridLocation.x;
			var iTargetY:int = blockSwap.targetGridLocation.y;
			
			// NOTE: this probably looks like the opposite of what it should be, but it's b/c at this point the origin and target have already swapped locations :)
			if (iOriginX == iTargetX && iOriginY < iTargetY)
			{
				blockSwap.flingSide = 0;
				blockSwap.flingPosition = iOriginX;
			}
			else if (iOriginX == iTargetX && iOriginY > iTargetY)
			{
				blockSwap.flingSide = 1;
				blockSwap.flingPosition = iOriginX;
			}
			else if (iOriginX < iTargetX && iOriginY == iTargetY)
			{
				blockSwap.flingSide = 2;
				blockSwap.flingPosition = iOriginY;
			}
			else if (iOriginX > iTargetX && iOriginY == iTargetY)
			{
				blockSwap.flingSide = 3;
				blockSwap.flingPosition = iOriginY;
			}
			
			// pull the blocks to be swapped out of the grid and put them into a flingBlocksAnimation if they were part of a match
			var oOriginBlock:Block = blockSwap.originBlock;
			var oTargetBlock:Block = blockSwap.targetBlock;
			
			if (blockSwap.originMatched == true)
			{
				grid[blockSwap.originGridLocation.x][blockSwap.originGridLocation.y] = null;
			}
			
			if (blockSwap.targetMatched == true)
			{
				grid[blockSwap.targetGridLocation.x][blockSwap.targetGridLocation.y] = null;
			}
			
			// update the static graphics
			gameController.Repaint();
			
			// start the animation
			var lBlocks:Array = new Array();
			var lLocations:Array = new Array();
			var oOrigin:PixelLocation = blockSwap.originGridLocation.ToPixel();
			var oTarget:PixelLocation = blockSwap.targetGridLocation.ToPixel();
			var oDestination:PixelLocation = null;
			
			if (GraveService.IsGraveAtLocation(gravestones, new GraveLocation(blockSwap.flingSide, blockSwap.flingPosition)) == true)
			{
				oDestination = UIManager.GetGravestonePixelLocation(blockSwap.flingSide, blockSwap.flingPosition);
			}
			else
			{
				oDestination = UIManager.GetOffscreenPixelLocation(blockSwap.flingSide, blockSwap.flingPosition);
			}
			
			// only fling blocks if they were part of a match
			if (blockSwap.originMatched == true)
			{
				lBlocks.push(oOriginBlock);
				lLocations.push([ new PixelLocation(oOrigin.x, oOrigin.y), new PixelLocation(oDestination.x, oDestination.y) ]);
			}
			
			if (blockSwap.targetMatched == true)
			{
				lBlocks.push(oTargetBlock);
				lLocations.push([ new PixelLocation(oTarget.x, oTarget.y), new PixelLocation(oDestination.x, oDestination.y) ]);
			}
			
			var oAnimation:FlingBlocksAnimation = new FlingBlocksAnimation(gameController, graphics, lBlocks, lLocations, 15, blockSwap);
		}
		
		public static function InitiateMatchBlocks(gameController:GameController, graphics:MovieClip, grid:Array, blockSwap:BlockSwap):void
		{
			// get the list of matched blocks for origin and target
			var lOriginMatches:Array = GridService.GetMatchList(grid, new GridLocation(blockSwap.originGridLocation.x, blockSwap.originGridLocation.y));
			
			var lTargetMatches:Array = new Array();
			
			// only get matches if the target block is NOT in the match group with the origin, otherwise you'll get the same list of matches with all locations duplicated
			var bTargetMatchedWithOrigin:Boolean = false;
			
			for (var i:int = 0; i < lOriginMatches.length; i++)
			{
				var oGridLocation:GridLocation = GridLocation(lOriginMatches[i]);
				
				if (oGridLocation.x == blockSwap.targetGridLocation.x && oGridLocation.y == blockSwap.targetGridLocation.y)
				{
					bTargetMatchedWithOrigin = true;
					break;
				}
			}
			
			if (bTargetMatchedWithOrigin == false)
			{
				lTargetMatches = GridService.GetMatchList(grid, new GridLocation(blockSwap.targetGridLocation.x, blockSwap.targetGridLocation.y));
			}
			
			// create a list of all matched blocks that does NOT include the origin and target
			if (lOriginMatches.length >= 3)
			{
				blockSwap.originMatchCount = lOriginMatches.length;
				blockSwap.originMatched = true;
				lOriginMatches.splice(0, 1);
			}
			else
			{
				blockSwap.originMatched = false;
				lOriginMatches = new Array();
			}
			
			if (lTargetMatches.length >= 3)
			{
				blockSwap.targetMatchCount = lTargetMatches.length;
				blockSwap.targetMatched = true;
				lTargetMatches.splice(0, 1);
			}
			else
			{
				blockSwap.targetMatched = false;
				lTargetMatches = new Array();
			}
			
			blockSwap.matchedBlockGridLocations = lOriginMatches.concat(lTargetMatches);
			
			// if there's no match, just return;
			if (blockSwap.matchedBlockGridLocations.length == 0)
			{
				return;
			}
			
			// pull matched blocks (NOT including origin and target) out of the grid
			blockSwap.matchedBlocks = new Array();
			for (i = 0; i < blockSwap.matchedBlockGridLocations.length; i++)
			{
				var oLocation:GridLocation = GridLocation(blockSwap.matchedBlockGridLocations[i]);
				
				blockSwap.matchedBlocks.push(Block(grid[oLocation.x][oLocation.y]));
				grid[oLocation.x][oLocation.y] = null;
			}
			
			// update static graphics
			gameController.Repaint();
			
			// start the animation
			var oAnimation:MatchBlocksAnimation = new MatchBlocksAnimation(gameController, graphics, 10, blockSwap);
		}
		
		public static function InitiateSwapBlocks(gameController:GameController, graphics:MovieClip, grid:Array, blockSwap:BlockSwap):void
		{
			// pull the blocks to be swapped out of the grid and put them into a swapBlockAnimation
			var oOriginBlock:Block = blockSwap.originBlock;
			var oTargetBlock:Block = blockSwap.targetBlock;
			
			grid[blockSwap.originGridLocation.x][blockSwap.originGridLocation.y] = null;
			grid[blockSwap.targetGridLocation.x][blockSwap.targetGridLocation.y] = null;
			
			// update the static graphics
			gameController.Repaint();
			
			// flip the blocks in the static state - since we don't repaint the static graphics until after the animation is complete, it should be legit to do here
			grid[blockSwap.originGridLocation.x][blockSwap.originGridLocation.y] = blockSwap.targetBlock;
			grid[blockSwap.targetGridLocation.x][blockSwap.targetGridLocation.y] = blockSwap.originBlock;
			
			// start the animation
			var lBlocks:Array = [ oOriginBlock, oTargetBlock ];
			var oOrigin:PixelLocation = blockSwap.originGridLocation.ToPixel();
			var oTarget:PixelLocation = blockSwap.targetGridLocation.ToPixel();
			var lLocations:Array = [ [ new PixelLocation(oOrigin.x, oOrigin.y), new PixelLocation(oTarget.x, oTarget.y) ],
								     [ new PixelLocation(oTarget.x, oTarget.y), new PixelLocation(oOrigin.x, oOrigin.y) ]
								   ];
			var oAnimation:SwapBlockAnimation = new SwapBlockAnimation(gameController, graphics, lBlocks, lLocations, 10, blockSwap);
			
			// update the blockSwap state to have the new locations of the origin and target since they flipped positions
			var oOriginGridLocation:GridLocation = new GridLocation(blockSwap.originGridLocation.x, blockSwap.originGridLocation.y);
			blockSwap.originGridLocation.x = blockSwap.targetGridLocation.x;
			blockSwap.originGridLocation.y = blockSwap.targetGridLocation.y;
			blockSwap.targetGridLocation.x = oOriginGridLocation.x;
			blockSwap.targetGridLocation.y = oOriginGridLocation.y;			
		}
		
		public static function InitiateUpdateGrid(gameController:GameController, graphics:MovieClip, grid:Array, blockSwap:BlockSwap):void
		{
			blockSwap.blockShifts = GridService.GetBlockShiftList(grid);
			
			var lBlocks:Array = new Array();
			var lLocations:Array = new Array();
			
			for (var i:int = 0; i < blockSwap.blockShifts.length; i++)
			{
				var oBlockShift:BlockShift = BlockShift(blockSwap.blockShifts[i]);
				
				var oStartGrid:GridLocation = new GridLocation(oBlockShift.startGridX, oBlockShift.startGridY);
				var oStartPixel:PixelLocation = oStartGrid.ToPixel();
				
				var oEndGrid:GridLocation = new GridLocation(oBlockShift.startGridX + oBlockShift.deltaGridX, oBlockShift.startGridY + oBlockShift.deltaGridY);
				var oEndPixel:PixelLocation = oEndGrid.ToPixel();
				
				if (oStartGrid.y < 0)
				{
					var iType:int = Math.floor(Math.random() * Block.NUM_TYPES);
					var oNewBlock:Block = new Block(iType);
					lBlocks.push(oNewBlock);
					blockSwap.blockShiftBlocks.push(oNewBlock);
				}
				else
				{
					lBlocks.push(Block(grid[oStartGrid.x][oStartGrid.y]));
					blockSwap.blockShiftBlocks.push(Block(grid[oStartGrid.x][oStartGrid.y]));
					grid[oStartGrid.x][oStartGrid.y] = null;
				}
				
				var lBlockLocations:Array = [ oStartPixel, oEndPixel ];
				lLocations.push(lBlockLocations);
			}
			
			gameController.Repaint();
			
			var oAnimation:UpdateGridAnimation = new UpdateGridAnimation(gameController, graphics, lBlocks, lLocations, 15, blockSwap);
		}
		
		public static function IsValidGridLocation(location:GridLocation):Boolean
		{
			if (location.x >= 0 && location.x < GameSession.GRID_WIDTH && location.y >= 0 && location.y < GameSession.GRID_HEIGHT)
			{
				return true;
			}
			
			return false;
		}
		
		public static function ShiftBlocks(grid:Array, blockSwap:BlockSwap):void
		{
			for (var i:int = 0; i < blockSwap.blockShifts.length; i++)
			{
				var oBlockShift:BlockShift = BlockShift(blockSwap.blockShifts[i]);
				
				var oEndGrid:GridLocation = new GridLocation(oBlockShift.startGridX + oBlockShift.deltaGridX, oBlockShift.startGridY + oBlockShift.deltaGridY);
				grid[oEndGrid.x][oEndGrid.y] = blockSwap.blockShiftBlocks[i];
			}
		}
		
		public static function SwapBlocks(grid:Array, origin:GridLocation, target:GridLocation):void
		{
			var oSaveBlock:Block = grid[origin.x][origin.y];
			grid[origin.x][origin.y] = grid[target.x][target.y];
			grid[target.x][target.y] = oSaveBlock;
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		private static function AddUniqueLocationToList(list:Array, gridLocation:GridLocation):void
		{
			if (list == null || gridLocation == null)
			{
				return;
			}
			
			var bFound:Boolean = false;
			
			for (var i:int = 0; i < list.length; i++)
			{
				var oObject:Object = list[i];
				
				if (oObject == null)
				{
					continue;
				}
				
				if (!(oObject is GridLocation))
				{
					continue;
				}
				
				var oLocation:GridLocation = GridLocation(oObject);
				
				if (oLocation.x == gridLocation.x && oLocation.y == gridLocation.y)
				{
					bFound = true;
					break;
				}
			}
			
			if (bFound == false)
			{
				list.push(gridLocation);
			}
		}
		
		private static function IsLocationInList(list:Array, gridLocation:GridLocation):Boolean
		{
			if (list == null || gridLocation == null)
			{
				return false;
			}
			
			var bFound:Boolean = false;
			
			for (var i:int = 0; i < list.length; i++)
			{
				var oObject:Object = list[i];
				
				if (oObject == null)
				{
					continue;
				}
				
				if (!(oObject is GridLocation))
				{
					continue;
				}
				
				var oLocation:GridLocation = GridLocation(oObject);
				
				if (oLocation.x == gridLocation.x && oLocation.y == gridLocation.y)
				{
					bFound = true;
					break;
				}
			}
			
			return bFound;
		}
		
		private static function PrettyPrintGrid(grid:Array):String
		{
			var sOutput:String = "";
			
			if (grid == null)
			{
				sOutput = "Grid is null";
				return sOutput;
			}
			
			for (var x:int = 0; x < grid.length; x++)
			{
				if (grid[x] == null)
				{
					sOutput += ("Column " + x + " is null\n");
					continue;
				}
				
				if (!(grid[x] is Array))
				{
					sOutput += ("Column " + x + " is not an array\n");
					continue;
				}
				
				for (var y:int = 0; y < grid[x].length; y++)
				{
					var oObject:Object = grid[x][y];
					
					if (oObject == null)
					{
						sOutput += (x + "," + y + " is null\n");
						continue;
					}
					
					if (!(oObject is Block))
					{
						sOutput += (x + "," + y + " is not a Block\n");
						continue;
					}
					
					var oBlock:Block = Block(grid[x][y]);
					
					sOutput += (x + "," + y + " = " + oBlock.type + "\n");
				}
			}
			
			return sOutput;
		}
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		public static function RunTests():Array
		{
			var lResults:Array = new Array();
			
			lResults.push(GridService.PrettyPrintGridNull());
			lResults.push(GridService.PrettyPrintGridCorrect());
			
			lResults.push(GridService.GetBlockShiftListEmptyIfNull());
			lResults.push(GridService.GetBlockShiftListCorrect());
			
			return lResults;
		}
		
		private static function PrettyPrintGridNull():UnitTestResult
		{
			var oResult:UnitTestResult = new UnitTestResult("GridService", "PrettyPrintGridNull");
			oResult.expected = "Grid is null";
			oResult.actual = GridService.PrettyPrintGrid(null);
			oResult.TestEquals();
			
			return oResult;
		}
		
		private static function PrettyPrintGridCorrect():UnitTestResult
		{
			var oResult:UnitTestResult = new UnitTestResult("GridService", "PrettyPrintGridCorrect");
			var oGrid:Array = [ null, new GridLocation(), [ null, new GridLocation(), new Block(1)]];
			
			oResult.expected = "Column 0 is null\nColumn 1 is not an array\n2,0 is null\n2,1 is not a Block\n2,2 = 1\n";
			oResult.actual = GridService.PrettyPrintGrid(oGrid);
			oResult.TestEquals();
			
			return oResult;
		}
		
		private static function GetBlockShiftListEmptyIfNull():UnitTestResult
		{
			var oResult:UnitTestResult = new UnitTestResult("GridService", "GetBlockShiftListEmptyIfNull");
			
			oResult.expected = "0";
			
			var lResults:Array = GridService.GetBlockShiftList(null);
			oResult.actual = String(lResults.length);
			
			oResult.TestEquals();
			
			return oResult;
		}
		
		private static function GetBlockShiftListCorrect():UnitTestResult
		{
			var oResult:UnitTestResult = new UnitTestResult("GridService", "GetBlockShiftListCorrect");
			
			var lColumn1:Array = [ null, new Block(1), null ];
			var lColumn2:Array = [ null, null, null ];
			var lColumn3:Array = [ new Block(1), null, new Block(2) ];
			var oGrid:Array = [ lColumn1, lColumn2, lColumn3 ];
			
			oResult.expected = "0,1,0,1\n2,0,0,1\n";
			
			var lBlockShifts:Array = GridService.GetBlockShiftList(oGrid);
			oResult.actual = BlockShift.PrettyPrintBlockShiftList(lBlockShifts);
			
			oResult.TestEquals();
			
			return oResult;
		}
		
		//- Testing Methods -//
	}
}