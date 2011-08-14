package org.gamina.srv {
   
   import mx.utils.URLUtil;
   
   import net.gimite.websocket.*;

// https://github.com/puppetMaster3/web-socket-js
public class WebSock extends WebSocketAs {
  
	
	
	/*
	public class Ws 
	{
	protected var wss:BaseJWebSSrv
	
	public function Ws()
	{
	
	wss = new BaseJWebSSrv();
	wss.serviceSignal.add(onWss)
	
	}
	
	protected function onWss(tok:VTO):void {
	
	if(BaseJWebSSrv.T_CONN==tok.ttype) {
	wss.reqLogin('guest','guest');
	}
	if(BaseJWebSSrv.T_LOGEDIN==tok.ttype) {
	wss.reqBroadcast('oh hi');	
	}
	}
	
	
	}*/
	

	
   protected var msgCallBack:Function;
   protected var onOpenCallBack:Function;
   
   
   public function asWs_create(socketServerUrl:String,callingPage:String,onOpenCallBack_:Function, msgCallBack_:Function=null, 
                               socketPort:uint=8787, protocol:String='ws', inst:uint=0):void {
       
      this.msgCallBack = msgCallBack_;
      this.onOpenCallBack = onOpenCallBack_;
               
      setCallerUrl(callingPage);
     
      create(inst,protocol+'://'+socketServerUrl+':'+socketPort,[protocol]);   
      
      var ws:WebSocket =webSockets[inst];
      
      ws.addEventListener("open", onWSocketEvent,false,0,true);
      ws.addEventListener("close", onWSocketEvent,false,0,true);
      ws.addEventListener("error", onWSocketEvent,false,0,true);
      ws.addEventListener("message", onWSocketEvent,false,0,true);
      
      }//create 
   
   
   private function onWSocketEvent(ctx:WebSocketEvent):void {
      this.dispatchEvent(ctx);
      
      if(msgCallBack!=null) {
         if("message"==ctx.type) msgCallBack(ctx.message); 
      return;
      }//fi
      if("message"==ctx.type)
         onOpenCallBack();
      
   }//()
   
   
         
   
}//class   
   
}//pack