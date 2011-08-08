package org.gamina.srv {
   
   import de.dev_lab.logging.Logger;
   
   import flash.events.Event;
   import flash.events.NetStatusEvent;
   import flash.events.TimerEvent;
   import flash.media.Video;
   import flash.net.GroupSpecifier;
   import flash.net.NetConnection;
   import flash.net.NetGroup;
   import flash.net.NetStream;
   import flash.utils.Timer;
   
   import org.gamina.api.IMainBus;
   import org.gamina.api.logic.AbsTrait;
   import org.osflash.signals.natives.NativeSignal;
	

	public class AbstractP2PGroup 
	{
		
		
		public static var P2P_INTRO_SRV:String='rtmfp://p2p.rtmfp.net/';
		
		protected var _nc:NetConnection;
		
		protected var _groupspec:GroupSpecifier;
		
		protected var _groupQOS:NetGroup;
		
		public  var _multicastAddress:String = "225.225.0.1:30303";
		
		public var _groupName:String='lobby';

		protected var _netSCh:NetStream;//Channel
		
		protected var nsClient:Object;
	
		
		protected var _ncSignal:NativeSignal;
		public var _streamSignal:NativeSignal;
		
		protected var _bus:IMainBus;
			
		
		
		public function AbstractP2PGroup()
		{
	
			_nc = new NetConnection();
			_ncSignal = new NativeSignal(_nc,NetStatusEvent.NET_STATUS);
			_ncSignal.add(onNetStatus);
			
			nsClient = new Object();
			nsClient.onMetaData = onMetaData;
			nsClient.onCuePoint = onCuePoint;
		}
	
		public function get mainBus():IMainBus
		{
			return _bus;
		}
		
		
		protected function onMetaData(data:Object):void {
			trace(data);
		}
		
		protected function onCuePoint(cue:Object):void {
			trace(cue);
		}
		

		/**
		 * p2p ID
		 */
		protected function get p2pID():String {
			if(_nc.connected)
				return _nc.nearNonce;
			else
				return null;
		}

		
		
		protected  function onNetStatus(event:NetStatusEvent):void{
			
			switch(event.info.code){
				case "NetConnection.Connect.Success":
					configGroup();
					break;
				case 'NetGroup.Neighbor.Connect':
					onPeer();
					break;
				case 'NetStream.Connect.Success':
					onConnect();
					break;
				
			}//s
			
		}//()

		protected function onConnect():void {
			//throw new Error('must implement p2p');
		}
		
		
		protected function configGroup():void{//1
			
			_groupspec = new GroupSpecifier(_groupName);
			
			_groupspec.serverChannelEnabled = true;
			_groupspec.multicastEnabled = true;
			_groupspec.routingEnabled=true;
			_groupspec.ipMulticastMemberUpdatesEnabled=true;
			 _groupspec.addIPMulticastAddress(_multicastAddress);
			
			_groupQOS = new NetGroup(_nc,_groupspec.groupspecWithAuthorizations());
			_groupQOS.addEventListener(NetStatusEvent.NET_STATUS,onNetStatus);
			
			_netSCh = new NetStream(_nc,_groupspec.groupspecWithAuthorizations());

			_streamSignal = new NativeSignal(_netSCh,NetStatusEvent.NET_STATUS);
			_streamSignal.add(onNetStatus);
			
	
		}
		
		protected function onPeer():void{
			//throw new Error('must implement p2p ');
		}
		

		
	}
}