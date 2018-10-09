package
{
	//-----------------------
	//Purpose:				The results of a single unit test
	//
	//Public Properties:
	//	
	//Public Methods:
	//	
	//-----------------------
	public class UnitTestResult
	{
		// Constants //
		
		public static const STATUS_COLORS:Array = [ "999999", "00FF00", "FF0000" ];
		public static const STATUS_NAMES:Array = [ "Not Run", "Pass", "Fail" ];
		public static const STATUS_NOT_RUN:int = 0;
		public static const STATUS_PASS:int = 1;
		public static const STATUS_FAIL:int = 2;
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get actual():String
		{
			return _actual;
		}
		
		public function set actual(value:String):void
		{
			_actual = value;
		}
		
		public function get className():String
		{
			return _className;
		}
		
		public function set className(value:String):void
		{
			_className = value;
		}
		
		public function get expected():String
		{
			return _expected;
		}
		
		public function set expected(value:String):void
		{
			_expected = value;
		}
		
		public function get message():String
		{
			return _message;
		}
		
		public function set message(value:String):void
		{
			_message = value;
		}
		
		public function get status():int
		{
			return _status;
		}
		
		public function set status(value:int):void
		{
			_status = value;
		}
		
		public function get testName():String
		{
			return _testName;
		}
		
		public function set testName(value:String):void
		{
			_testName = value;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _actual:String;
		private var _className:String;
		private var _expected:String;
		private var _message:String;
		private var _testName:String;
		private var _status:int;
		
		
		//- Private Properties -//
		
	
		// Initialization //
		
		//---------------
		//Purpose:		
		//Parameters:
		//	
		//Returns:		
		//---------------
		public function UnitTestResult(className:String, testName:String)
		{
			_className = className;
			_testName = testName;
			
			_actual = "";
			_expected = "";
			_message = "";
			_status = UnitTestResult.STATUS_NOT_RUN;
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public function TestEquals():void
		{
			if (_expected == _actual)
			{
				_status = UnitTestResult.STATUS_PASS;
			}
			else
			{
				_status = UnitTestResult.STATUS_FAIL;
			}
		}
		
		public function TestFalse(testValue:Boolean):void
		{
			_expected = "false";
			
			if (testValue == false)
			{
				_actual = "false";
				_status = UnitTestResult.STATUS_PASS;
			}
			else
			{
				_actual = "true";
				_status = UnitTestResult.STATUS_FAIL;
			}
		}
		
		public function TestNotNull(target:Object):void
		{
			_expected = "not null";
			
			if (target == null)
			{
				_actual = "null";
				_status = UnitTestResult.STATUS_FAIL;
			}
			else
			{
				_actual = "not null";
				_status = UnitTestResult.STATUS_PASS;
			}
		}
		
		public function TestNull(target:Object):void
		{
			_expected = "null";
			
			if (target == null)
			{
				_actual = "null";
				_status = UnitTestResult.STATUS_PASS;
			}
			else
			{
				_actual = "not null";
				_status = UnitTestResult.STATUS_FAIL;
			}
		}
		
		public function TestTrue(testValue:Boolean):void
		{
			_expected = "true";
			
			if (testValue == true)
			{
				_actual = "true";
				_status = UnitTestResult.STATUS_PASS;
			}
			else
			{
				_actual = "false";
				_status = UnitTestResult.STATUS_FAIL;
			}
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}