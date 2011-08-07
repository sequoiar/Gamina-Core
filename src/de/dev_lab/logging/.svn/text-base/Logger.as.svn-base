package de.dev_lab.logging 
{
   import de.dev_lab.logging.publisher.IComplexPublisher;
   import de.dev_lab.logging.publisher.IPublisher;
   import de.dev_lab.logging.publisher.MultiPublisher;
   import de.dev_lab.logging.publisher.SOSPublisher;
   import de.dev_lab.logging.publisher.TracePublisher;
   import flash.utils.describeType;
   import flash.xml.XMLNode;

	/**
	 * This logger system is inspired by the concept of Zeroi AS2.
	 * You can output the logs on different publishers, e.g.
	 * SOS, a simple TextField or maybe your own output system.
	 * 
	 * All methods are static, so no instantiation is required.
	 * 
	 * The aim of this logger is too keep the usage as simple
	 * as possible.
	 * 
	 * To develop your own publisher, just implement the IPublisher
	 * interface.
	 * 
	 * Simple example:
	 * <code>
	 * var field : TextField = TextFieldPublisher.getLoggerField();
	 * addChild ( field );
	 * 			
	 * Logger.publisher = new TextFieldPublisher ( field );
	 * Logger.addPublisher ( new SOSPublisher );
	 * 	
	 * Logger.info( "It works" );
	 * </code>
	 *
	 *
	 * @author Sebastian Weyrauch 
	 *
	 * LastChanged:
	 * 
	 * $Author: sebastian.weyrauch $
	 * $Revision: 10 $
	 * $LastChangedDate: 2010-07-04 20:34:28 +0200 (So, 04 Jul 2010) $
	 * $URL: https://as3logger.googlecode.com/svn/trunk/as3logger/src/de/dev_lab/logging/Logger.as $
	 * 
	 */
	public class Logger
	{
		public static const VERSION : String = "Version 0.8.0";
		
		public static const DEBUG : int = 0;
		public static const PROD_INFO : int = 1;
		public static const WARN : int = 2;
		public static const ERROR : int = 3;

		
		/**
		 * Instance of a Multipublisher to which the publishers will be registered.
		 */	
		private static var _multiPublisher : MultiPublisher = new MultiPublisher;
		
		private static var _minLogLevel : int = DEBUG;
		private static var _enabled : Boolean = true;
		
		/**
		 * Constructor. No instantiation is required.
		 */
		public function Logger ()
		{
			throw new Error ( "No instantiation is required. All methods are class methods." );
		}
		
		/**
		 * The default publisher for the output. To use multiple outputs,
		 * see <code>addPublisher()</code> or use the <code>MultiPublisher</code>.
		 * 
		 * @see #addPublisher()
		 */
		public static function set publisher ( value : IPublisher ) : void
		{
			if ( _multiPublisher ) _multiPublisher.destroy();
			
			_multiPublisher.add( value );
		}

		/**
		 * @private
		 */
		public static function get publisher () : IPublisher
		{
			return _multiPublisher;
		}
		
		/**
		 * If Logger is enabled or not. Set to <code>false</code> if nothing
		 * shall be published.
		 */
		public static function set enabled ( value : Boolean ) : void
		{
			_enabled = value;
		}
		
		/**
		 * @private
		 */
		public static function get enabled () : Boolean
		{
			return _enabled;
		}
		
		/**
		 * The minimum log level. All log levels below this value
		 * won't be outputed.
		 * 
		 * E.g. <code>Logger.logLevel = Logger.ERROR;</code> will
		 * not show DEBUG messages.
		 */
		public static function set logLevel ( value : int ) : void
		{
			_minLogLevel = value;
		}
		
		/**
		 * @private
		 */
		public static function get logLevel () : int
		{
			return _minLogLevel;
		}
		
		/**
		 * Logs an object or message with type Logger.DEBUG.
		 * 
		 * @param object Object or message to output
		 * @param additional Additional Values to output
		 */
		public static function debug ( object : * ,className:String, methodName:String, ...additional ) : void
		{
			log.apply( Logger , ([ Logger.DEBUG , object, className, methodName ]).concat( additional ) );
		}

		
		/**
		 * Logs an object with more info, higher than debug
		 * 
		 * @param object Object or message to output
		 * @param additional Additional Values to output
		 */
		//public static function prodInfo ( object : * , className:String, methodName:String,...additional ) : void
		//{
		//	log.apply( Logger , ([ Logger.PROD_INFO , object, className, methodName ]).concat( additional ) );
		//}
		
		/**
		 * Logs an object or message with type Logger.WARN.
		 * 
		 * @param object Object or message to output
		 * @param additional Additional Values to output
		 */
		//public static function warn ( object : * , className:String, methodName:String, ...additional ) : void
		//{
		//	log.apply( Logger , ([ Logger.WARN , object, className, methodName]).concat( additional ) );
		//}
		
		
		/**
		 * Logs an object or message with type Logger.ERROR.
		 * 
		 * @param object Object or message to output
		 * @param additional Additional Values to output
		 */
		public static function error ( object : *, className:String, methodName:String,...additional ) : void
		{
			log.apply( Logger , ([ Logger.ERROR , object, className, methodName ]).concat( additional ) );
		}
		

		
		/**
		 * Sends the log values to the publishers, if the logLevel
		 * matches.
		 * 
		 * @param logLevel Log level
		 * @param object Object or message to output
		 * @param additional Additional Values to output
		 */
		public static function log ( logLevel : int , object : * , className:String, methodName:String,...additional ) : void
		{
			if ( !_enabled || logLevel < _minLogLevel ) return;
			if ( _multiPublisher.length == 0 ) 
			{
				Logger.publisher = new MultiPublisher([ new SOSPublisher, new TracePublisher]);
				
			}
		
			var publisherList : Array = _multiPublisher.getPublisherList();
			
			for each ( var publisher : IPublisher in publisherList )
			{
				// Complex publishers
				if ( publisher is IComplexPublisher )
				{
					publisher.publish( logLevel , object ,className, methodName, additional );
					continue;
				}
				
				// Simple publishers
				var message : String = "";
				var outputList : Array = [].concat( object , additional );
				for each ( var obj : * in outputList )
				{
					if ( message != "" ) message += "\n";
					message += parseObject ( obj );
				}
				publisher.publish( logLevel , message, className, methodName);
			}
		}
		
		/**
		 * Adds a further publisher.
		 * 
		 * @param publisher The publisher to add.
		 */
		public static function addPublisher ( publisher : IPublisher ) : void
		{
			_multiPublisher.add( publisher );
		}
		
		/**
		 * Returns a String representation of the log levels.
		 * 
		 * @param logLevel Log level
		 * @return String representation of the log level
		 */
		public static function getLogType ( logLevel : int ) : String
		{
			switch( logLevel )
            {
            	case DEBUG :
					return "DEBUG";
                case PROD_INFO :
                	return "PROD_INFO";
                case WARN :
                	return "WARN";
                case ERROR :
                	return "ERROR";
           
            }
			
			return "";
		}
		
		/**
		 * Parses an object an returns a string output.
		 * 
		 * @return String output for object
		 */
		private static function parseObject ( obj : * , depth : int = 0 ) : String
		{
			var output : String = "";
			var description : XML = new XML;
			var type : String = "";
			
			var shiftingString : String = "";
			for ( var i : int = 0 ; i< depth ; i++ ) shiftingString += "\t";
			
			try
			{
				description = describeType( obj );
				type = getClass ( description.@name );
			}
			catch ( error : Error )
			{
				
			}
			
			if ( type == "String" )
			{
				output += String( obj );
			}
			else if( type == "Boolean" || type == "Number" || type == "int" || type == "uint" )
			{
				output += String( obj );
			}
			else if ( type == "Array" )
			{
				output +=  "[" + obj["toString"]() + "]";
			}
			else if( type == "undefined" || type == "null" ) 
			{
				output += "(" + type + ")";
			}
			else if( type == "Date" )
			{
				output +=  obj["toString"]();
			}
			else if( type == "XML" )
			{
				output += XML ( obj ).toXMLString();
			}
			else if( type == "XMLNode" )
			{
				output += XMLNode ( obj ).toString();
			}
			else if( type == "Object" )
			{
//				var shiftingString : String = getShiftingString ( depth );
				
				output += "Object\n";
				output += shiftingString + "{\n";
				for ( var s : String in obj )
				{
					output += shiftingString +  "\t" + s + ": " +  parseObject( obj[s] , depth+1 ) + "\n";
				}
				output += shiftingString + "}";
			}
			else if( description.hasOwnProperty("variable") )
			{				
				output += type + ":\n";
				output += shiftingString + "{\n";
				
				for each ( var variableData : XML in description["variable"] )
				{
					output += shiftingString + "\t" + variableData.@name + ": " +  parseObject( obj[ variableData.@name ] , depth+1 ) + "\n";
				}
				
				output += shiftingString + "}";
			}
			else if( obj["toString"] )
			{
				output += obj["toString"](); 
			}
						
			return output;
		}
		
		/**
		 * Returns a class name without the package.
		 * @param type Full class path (with package)
		 * @return The Class name
		 */
		private static function getClass ( type : String ) : String
		{
			return type;
		}
	}
}
