package de.dev_lab.logging.publisher 
{
   import de.dev_lab.logging.Logger;
   import flash.text.TextField;

	/**
	 * The TextField publisher outputs the Log to a textfield.
	 * 
	 * A default textfield can be used:
	 * <code>
	 * var field : TextField = TextFieldPublisher.getLoggerField();
	 * addChild ( field );
	 * 
	 * Logger.publisher = new TextFieldPublisher;
	 * </code>
	 *
	 * @author Sebastian Weyrauch 
	 *
	 * LastChanged:
	 * 
	 * $Author: sebastian.weyrauch $
	 * $Revision: 9 $
	 * $LastChangedDate: 2009-02-16 13:00:07 +0100 (Mo, 16 Feb 2009) $
	 * $URL: https://as3logger.googlecode.com/svn/trunk/as3logger/src/de/dev_lab/logging/publisher/TextFieldPublisher.as $
	 * 
	 */
	public class TextFieldPublisher implements IPublisher 
	{
		private var _field : TextField;
		
		/**
		 * Constructor.
		 * 
		 * @param field TextField for the output
		 */
		public function TextFieldPublisher ( field : TextField )
		{
			_field = field;	
		}
		
		/**
		 * Returns a default TextField.
		 * 
		 * @param width Width of the Field
		 * @param height Height of the Field
		 * 
		 * @return The generated TextField
		 */
		public static function getLoggerField ( width : int = 200 , height : int = 200 ) : TextField
		{
			var loggerField : TextField = new TextField;
			loggerField.width = width;
			loggerField.height = height;
			loggerField.background = true;
			loggerField.backgroundColor = 0xFFFFFF;
			loggerField.border = true;
			loggerField.multiline = true;
			
			return loggerField;
		}
		
		/**
		 * Outputs the message to the textfield.
		 * 
		 * @param logLevel Log level
		 * @param message Message
		 */
		public function publish ( logLevel : int , object : * , className:String,methodName:String,...additional ) : void
		{
			var message : String = String ( object );
			
			var output : String = "<font color=\"#" + getColor ( logLevel ).toString( 16 )+ "\">" + getPrefix ( logLevel ) + ": "
				+ message + ':'+className+'-'+methodName+"</font>\n";
			//_field.appendText( output );
			_field.htmlText += output;
		}
		
		/**
		 * Clears the field.
		 */
		public function clear () : void
		{
			_field.text = "";
		}

		/**
		 * Destructor.
		 */
		public function destroy () : void
		{
			clear();
		}
		
		/**
		 * Returns a special prefix for trace output.
		 * 
		 * @param logLevel Log level
		 * @return Prefix
		 */
		private function getPrefix ( logLevel : int ) : String
		{
			switch ( logLevel )
			{
				case Logger.DEBUG :
					return "_";
                case Logger.PROD_INFO :
                	return "-";
                case Logger.WARN :
                	return "!";
                case Logger.ERROR :
                	return "#";
             
			}
			
			return "";
		}
		
		/**
		 * Returns a color for the log level.
		 * 
		 * @param logLevel Log level
		 * @return Color code
		 */
		private function getColor ( logLevel : int ) : int
		{
			switch ( logLevel )
			{
				case Logger.DEBUG :
					return 0x48A0FF;
                case Logger.PROD_INFO :
                	return 0xD2A946;
                case Logger.WARN :
                	return 0xFF9934;
                case Logger.ERROR :
                	return 0xFF1313;
            
			}
			
			return 0x000000;
		}
	}
}
