package de.dev_lab.logging.publisher 
{

	/**
	 * Interface for Publishers.
	 *
	 * @author Sebastian Weyrauch 
	 *
	 * LastChanged:
	 * 
	 * $Author: sebastian.weyrauch $
	 * $Revision: 9 $
	 * $LastChangedDate: 2009-02-16 13:00:07 +0100 (Mo, 16 Feb 2009) $
	 * $URL: https://as3logger.googlecode.com/svn/trunk/as3logger/src/de/dev_lab/logging/publisher/IPublisher.as $
	 * 
	 */
	public interface IPublisher 
	{
		/**
		 * Publishs an object or message.
		 * The <code>object</code> parameter is the parsted String to output,
		 * if the publisher is no <code>IComplexPublished</code>
		 * 
		 * @param logLevel Log level
		 * @param * Object to log (If no IComplexPublisher, this is a String)
		 * @param additional Additional Values to output (only for IComplexPublisher)
		 */
		function publish ( logLevel : int , object : * , className:String, methodName:String,...additional ) : void;
		
		function clear () : void;
		
		function destroy () : void;
	}
}
