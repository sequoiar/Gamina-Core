package de.dev_lab.logging.publisher 
{
   import de.dev_lab.logging.Logger;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.XMLSocket;

	/**
	 * Publisher for Powerflasher Socket Output Server (SOS).
	 * 
	 * http://sos.powerflasher.com/
	 * 
	 * @author Sebastian Weyrauch 
	 *
	 * LastChanged:
	 * 
	 * $Author: sebastian.weyrauch $
	 * $Revision: 10 $
	 * $LastChangedDate: 2010-07-04 20:34:28 +0200 (So, 04 Jul 2010) $
	 * $URL: https://as3logger.googlecode.com/svn/trunk/as3logger/src/de/dev_lab/logging/publisher/SOSPublisher.as $
	 * 
	 */
	public class SOSPublisher implements IPublisher
	{
		private var _socket : XMLSocket;
		
		private var _queue : Array;
		
		private var _clearOnConnect : Boolean;
		
		/**
		 * Constructor. Creates the socket and the connects to it.
		 * 
		 * @param clearOnConnect <code>true</code> if the output shall be reset on connect,
		 * 						 <code>false</code> if not
		 * @param hostname The hostname to connect
		 * @param port The port to connect
		 */
		public function SOSPublisher( clearOnConnect : Boolean = true , hostname : String = "localhost" , port : int = 4445 )
		{
			_clearOnConnect = clearOnConnect;
			_queue = [];
			
			_socket = new XMLSocket;
			_socket.addEventListener( Event.CONNECT , onConnect );
			_socket.addEventListener( IOErrorEvent.IO_ERROR , onError );
			_socket.addEventListener( SecurityErrorEvent.SECURITY_ERROR , onError );
			_socket.connect( hostname , port );
		}
		
		/**
		 * Publishs a message. If the socket is not connect yet,
		 * it will be added to a queue.
		 * 
		 * @param logLevel Log level
		 * @param message Message
		 */
		public function publish ( logLevel : int , object : *, className:String, methodName:String, ...additional ) : void
		{
			var message : String = String ( object );
			
			if( message.length == 0 ) return;
			
			if ( _socket.connected )
			{
				sendToSocket ( logLevel , message,className+'-'+methodName );
			}
			else
			{
				if ( _queue ) _queue.push ( new LogObject ( logLevel , message ) );
			}
		}
		
		/**
		 * Resets the output of SOS.
		 */
		public function clear () : void
		{
			_socket.send( "<clear/>\n" );
		}
		
		/**
		 * Disconnects from the socket.
		 */
		public function destroy () : void
		{
			_socket.removeEventListener( IOErrorEvent.IO_ERROR , onError );
			_socket.removeEventListener( SecurityErrorEvent.SECURITY_ERROR , onError );
			_socket.removeEventListener( Event.CONNECT , onConnect );
			
			try
			{
				_socket.close();
			}
			catch ( error : Error )
			{
				trace( error );
			}
		}
		
		/**
		 * Sends a message to the socket.
		 * 
		 * @param logLevel Log level
		 * @param message Message
		 */
		private function sendToSocket ( logLevel : int, message : String, className:String ) : void
		{
			var xmlMessage : String = "<showMessage key=\"" + Logger.getLogType ( logLevel ) + "\"/> " + message + '-'+className;
			_socket.send( xmlMessage +  "\n");
		}
		
		/**
		 * Handler for Socket connect.
		 * Sends all messages in the queue.
		 * 
		 * @param event
		 */
		private function onConnect ( event : Event ) : void
		{
			if ( _clearOnConnect ) clear();
			
			for each ( var logObject : LogObject in _queue )
			{
				sendToSocket ( logObject.logLevel , logObject.message,'' );
			}
			
			_queue = null;
		}
		
		/**
		 * Handler for Socker errors.
		 * Destroys the publisher.
		 */
		private function onError ( event : Event ) : void
		{
			_queue = null;
			
			destroy();
		}
	}
}

internal class LogObject
{
	public var logLevel : int;
	public var message : String;
	
	public function LogObject ( logLevel_ : int , message_ : String )
	{
		this.logLevel = logLevel_;
		this.message = message_;
	}
}
