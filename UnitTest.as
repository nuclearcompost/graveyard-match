package
{
	
	//-----------------------
	//Purpose:				Unit testing framework for the application
	//
	//Public Properties:
	//	
	//Public Methods:
	//	
	//-----------------------
	public class UnitTest
	{
		// Constants //
		
		public static const OUTPUT_NONE:int = 0;
		public static const OUTPUT_TEXT:int = 1;
		public static const OUTPUT_HTML:int = 2;
		
		//- Constants -//
		
		
		// Public Properties //
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function UnitTest()
		{
			
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public static function RunTests(outputType:int = 0):void
		{
			var lResults:Array = new Array();
			
			lResults = lResults.concat(GridService.RunTests());
			
			var sFormattedResults:String = "";
			
			if (outputType == UnitTest.OUTPUT_TEXT)
			{
				sFormattedResults = UnitTest.FormatResultsAsText(lResults);
			}
			else if (outputType == UnitTest.OUTPUT_HTML)
			{
				sFormattedResults = UnitTest.FormatResultsAsHtml(lResults);
			}
			
			trace(sFormattedResults);
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		private static function FormatResultsAsText(resultList:Array):String
		{
			var sText:String = "Plotz Unit Tests\n";
			
			var sClassName:String = "";
			
			for (var i:int = 0; i < resultList.length; i++)
			{
				var oResult:UnitTestResult = UnitTestResult(resultList[i]);
				
				if (oResult.className != sClassName)
				{
					sClassName = oResult.className;
					sText += "\n\n";
					sText += sClassName;
					sText += "\n";
				}
				
				sText += "\t";
				sText += UnitTestResult.STATUS_NAMES[oResult.status];
				sText += "\t";
				sText += oResult.testName;
				sText += "\n";
				
				if (oResult.message != "")
				{
					sText += "\t\t\t\tMessage: ";
					sText += oResult.message;
					sText += "\n";
				}
				
				if (oResult.status == UnitTestResult.STATUS_FAIL)
				{
					sText += "\t\t\t\tExpected: ";
					sText += oResult.expected;
					sText += "\n";
					sText += "\t\t\t\tActual: ";
					sText += oResult.actual;
					sText += "\n";
				}
			}
			
			return sText;
		}
		
		private static function FormatResultsAsHtml(resultList:Array):String
		{
			var sHtml:String = "<html><body>";
			
			sHtml += "<h2><p>Plotz Unit Tests</p></h2>";
			sHtml += "</br>";
			sHtml += "<ul>";
			
			
			var sClassName:String = "";
			
			for (var i:int = 0; i < resultList.length; i++)
			{
				var oResult:UnitTestResult = UnitTestResult(resultList[i]);
				
				if (oResult.className != sClassName)
				{
					// close the tags for the previous class name block unless it's the first class
					if (sClassName != "")
					{
						sHtml += "</ul></div></li>";
					}
					
					sClassName = oResult.className;
					
					sHtml += "<li>";
					sHtml += "<div id=\"TestClass\">";
					sHtml += "<h2>";
					sHtml += sClassName;
					sHtml += "</h2>";
					sHtml += "<ul>";
				}
				
				sHtml += "<li>";
				sHtml += "<div id=\"TestName\">";
				sHtml += "<h3>";
				sHtml += "<span id=\"TestStatus\" style=\"color:";
				sHtml += UnitTestResult.STATUS_COLORS[oResult.status];
				sHtml += "\">";
				sHtml += UnitTestResult.STATUS_NAMES[oResult.status];
				sHtml += "</span>";
				sHtml += "\t";
				sHtml += oResult.testName;
				
				if (oResult.message != "")
				{
					sHtml += "<ul><li>";
					sHtml += oResult.message;
					sHtml += "</li></ul>";
				}
				
				if (oResult.status == UnitTestResult.STATUS_FAIL)
				{
					sHtml += "<ul><li>Expected: ";
					sHtml += oResult.expected;
					sHtml += "</li><li>Actual: ";
					sHtml += oResult.actual;
					sHtml += "</li></ul>";
				}
				
				sHtml += "</h3>";
			}
			
			sHtml += "</ul>";
			sHtml += "</body></html>";
			
			return sHtml;
		}
		
		//- Private Methods -//
	}
}