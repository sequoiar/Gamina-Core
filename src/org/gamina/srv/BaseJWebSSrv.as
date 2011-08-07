package org.gamina.srv
{
	import org.gamina.api.IMainBus;
	import org.gamina.api.logic.IService;
	import org.gamina.api.logic.VTO;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	public class BaseJWebSSrv implements IService
	{

		public static var T_CONN:String ='conn';
		public static var T_LOGEDIN:String='logedin';
		
		protected static var T_RESP:String='response';
		protected static var TTYPE:String ='type';
		protected static var NS:String='org.jWebSocket.plugins.system';
		
		public static var _ws:AsWebSock;
		
		protected var _signal:Signal;
		
		protected var _connected:Boolean=false;
		public  var _userName:String;
		public  var _clientSId:String;
		
		
		public function BaseJWebSSrv(wsDomain:String='localhost',pagehost:String='http://localhost') {
			_signal = new Signal(VTO);
			_ws = new AsWebSock();
			_ws.asWs_create('localhost', 'http://localhost',onWSCon,onReceived);
		}

		
		protected function onReceived(str:String):void {
			
			var tok:VTO  = new VTO();
			var s:String = unescape(str);
			tok.initByJSON(s);			
			
			if(tok.ttype=='welcome') {//con
				var sessionId:String =String( tok.get('usid'));
				_clientSId = tok.get('sourceId');
				onCon();
				return;
			}
			
			if(tok.ttype==T_RESP) {//loggedin
				if('login'==tok.get('reqType')) {
				dispLogedin(tok);
				return;
				}
			}
			
			_signal.dispatch(tok);
			
		   }
		
		
		public function reqBroadcast(msg:String):void {
			if(!_clientSId||!_userName)
				throw new Error('not logged in');
			var tok:VTO  = new VTO();
			
			tok.initByType('broadcast');
			tok.set('ns',NS);
			tok.set('data',msg);
			tok.set('sourceId',_clientSId);
			tok.set('senderIncluded','false');
			tok.set('responseRequested','false');
			tok.set('sender',_userName);
			
			var data:String = escape(tok.toJSON());
			
			_ws.send(0,data);
		}
			
		
		public function reqLogin(userName_:String,pass:String):void {
			if(!_connected)
				throw new Error('not connected');
			
			var tok:VTO  = new VTO();
		
			_userName=userName_;
			
			tok.initByType('login');
			tok.set('ns',NS);
			tok.set('username',_userName);
			tok.set('password',pass);	
						
			var data:String = tok.toJSON();
			_ws.send(0,escape(data));
			
		}
		

		
		protected function onWSCon():void {
			trace('ws con');
		}
		
		protected function onCon():void {
			_connected = true;
			var tok:VTO = new VTO();
			tok.set(TTYPE,T_CONN);
			_signal.dispatch(tok);
			
		}
		
		protected function dispLogedin(token:VTO):void {
			token.set(TTYPE,T_LOGEDIN);
			_signal.dispatch(token);
			
		}
	
		
		public function get serviceSignal():ISignal
		{
			return _signal;
		}
	}
}