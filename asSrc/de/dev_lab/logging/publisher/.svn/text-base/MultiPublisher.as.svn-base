package de.dev_lab.logging.publisher 
{

	/**
	 * The MultiPublisher is a simple publisher, which holds
	 * the reference to multiple publishers and delegates
	 * everything.
	 *
	 * @author Sebastian Weyrauch 
	 *
	 * LastChanged:
	 * 
	 * $Author: sebastian.weyrauch $
	 * $Revision: 10 $
	 * $LastChangedDate: 2010-07-04 20:34:28 +0200 (So, 04 Jul 2010) $
	 * $URL: https://as3logger.googlecode.com/svn/trunk/as3logger/src/de/dev_lab/logging/publisher/MultiPublisher.as $
	 * 
	 */
	public class MultiPublisher implements IPublisher 
	{
		private var _publisherList : Array;
		
		/**
		 * Constructor.
		 * 
		 * @param publisherList Default List with IPublishers
		 */
		public function MultiPublisher ( publisherList : Array = null )
		{
			_publisherList = publisherList || [];
		}
		
		/**
		 * The length of the publisher list.
		 */
		public function get length () : int
		{
			return _publisherList.length;
		}
		
		/**
		 * Sends the output to all publishers in the list.
		 * 
		 * @param logLevel Log level
		 * @param message Message
		 */
		public function publish ( logLevel : int , object : * , className:String, methodName:String,...additional ) : void
		{
			for each ( var publisher : IPublisher in _publisherList )
			{
				publisher.publish( logLevel , object , className, methodName,additional );
			}
		}
		
		/**
		 * Adds a new publisher to the list.
		 * 
		 * @param publisher Publisher
		 */
		public function add ( publisher : IPublisher ) : void
		{
			_publisherList.push( publisher );
		}
		
		/**
		 * Clears all publishers in the list.
		 */
		public function clear () : void
		{
			for each ( var publisher : IPublisher in _publisherList )
			{
				publisher.clear();
			}
		}
		
		/**
		 * Destroys all publishers in the list.
		 */
		public function destroy () : void
		{
			for each ( var publisher : IPublisher in _publisherList )
			{
				publisher.destroy();
			}
		}
		
		public function getPublisherList () : Array
		{
			return _publisherList;
		}
	}
}
