package
{
	
	public class ScoreService
	{
		// Initialization //
		public function ScoreService() { }
	
		// Public Methods //
		
		public static function GetScoreForMatch(numBlocks:int, hitGravestone:Boolean):int
		{
			var iScore:int = Math.pow(numBlocks, 2);
			
			if (hitGravestone == true)
			{
				iScore *= 3;
			}
			
			return iScore;
		}
		
		public static function ParseScore(score:int):Array
		{
			var iTest:int = score;
			
			var iPower:int = 0;
			
			while (true)
			{
				var iCompare:int = Math.pow(10, iPower);
				
				if (iCompare > iTest)
				{
					break;
				}
				
				iPower++;
			}
			
			if (iPower == 0)
			{
				iPower = 1;
			}
			
			iPower--;
			
			var lDigits:Array = new Array();
			
			while (iPower >= 0)
			{
				var iValue:int = Math.pow(10, iPower);
				
				var iDigit:int = Math.floor(iTest / iValue);
				
				lDigits.push(iDigit);
				iTest -= (iDigit * iValue);
				
				iPower--;
			}
			
			return lDigits;
		}
		
		public static function ScoreSwap(blockSwap:BlockSwap, hitGravestone:Boolean):int
		{
			var iScore:int = 0;
			
			iScore += ScoreService.GetScoreForMatch(blockSwap.originMatchCount, hitGravestone);
			iScore += ScoreService.GetScoreForMatch(blockSwap.targetMatchCount, hitGravestone);
			
			return iScore;
		}
		
		//- Public Methods -//
	}
}