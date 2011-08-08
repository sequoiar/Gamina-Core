package de.dev_lab.logging.publisher 
{
   import de.dev_lab.logging.Logger;

	/**
	 * Simple Trace Publisher.
	 * 
	 * @author Sebastian Weyrauch 
	 *
	 * LastChanged:
	 * 
	 * $Author: sebastian.weyrauch $
	 * $Revision: 9 $
	 * $LastChangedDate: 2009-02-16 13:00:07 +0100 (Mo, 16 Feb 2009) $
	 * $URL: https://as3logger.googlecode.com/svn/trunk/as3logger/src/de/dev_lab/logging/publisher/TracePublisher.as $
	 * 
	 */
	public class TracePublisher implements IPublisher 
	{
		/**
		 * Traces the message to the console.
		 * 
		 * @param logLevel Log level
		 * @param message Message
		 */
		public function publish ( logLevel : int , object : * , className:String,methodName:String,...additional ) : void
		{
			trace( Logger.getLogType ( logLevel ) + ": " + object +'-'+className+'-'+methodName);
		}
		
		/**
		 * No implementation.
		 */
		public function clear () : void
		{
		}
		
		/**
		 * No implementation.
		 */
		public function destroy () : void
		{
		}
	}
}
