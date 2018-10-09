package
{
	import flash.display.MovieClip;
	
	//-----------------------
	//Purpose:				Service logic for the gravestones
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class GraveService
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function GraveService()
		{
			
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public static function AddGravestone(gravestones:Array):void
		{
			if (gravestones == null)
			{
				gravestones = new Array();
			}
			
			var iStartLength:int = gravestones.length;
			
			while (gravestones.length == iStartLength)
			{
				var iSide:int = Math.floor(Math.random() * 4);
				
				if (iSide == GraveLocation.SIDE_TOP || iSide == GraveLocation.SIDE_BOTTOM)
				{
					var iPosition:int = Math.floor(Math.random() * GameSession.GRID_WIDTH);
				}
				else
				{
					iPosition = Math.floor(Math.random() * GameSession.GRID_HEIGHT);
				}
				
				var bAlreadyExists = false;
				for (var i:int = 0; i < gravestones.length; i++)
				{
					var oGravestone:Gravestone = Gravestone(gravestones[i]);
					
					if (oGravestone.graveLocation.side == iSide && oGravestone.graveLocation.position == iPosition)
					{
						bAlreadyExists = true;
						break;
					}
				}
				
				if (bAlreadyExists == false)
				{
					gravestones.push(new Gravestone(iSide, iPosition));
				}
			}
		}
		
		public static function IsGraveAtLocation(gravestones:Array, location:GraveLocation):Boolean
		{
			if (gravestones == null || location == null)
			{
				return false;
			}
			
			var bIsGraveAtLocation:Boolean = false;
			
			for (var i:int = 0; i < gravestones.length; i++)
			{
				var oGravestone:Gravestone = Gravestone(gravestones[i]);
				
				if (oGravestone.graveLocation.Equals(location) == true)
				{
					bIsGraveAtLocation = true;
					break;
				}
			}
			
			return bIsGraveAtLocation;
		}
		
		public static function RemoveGraveAtLocation(gravestones:Array, location:GraveLocation):Boolean
		{
			if (gravestones == null || location == null)
			{
				return false;
			}
			
			var bHitGravestone:Boolean = false;
			
			for (var i:int = 0; i < gravestones.length; i++)
			{
				var oGravestone:Gravestone = Gravestone(gravestones[i]);
				
				if (oGravestone.graveLocation.Equals(location) == true)
				{
					gravestones.splice(i, 1);
					bHitGravestone = true;
					break;
				}
			}
			
			return bHitGravestone;
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		
		//- Testing Methods -//
	}
}