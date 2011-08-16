package org.gamina.srv {
   
import mx.utils.URLUtil;
   
import net.gimite.websocket.*;

public class WebSock extends WebSocketAs {

	
   protected var msgCallBack:Function;
   protected var onOpenCallBack:Function;
   
   
   public function asWs_create(socketServerUrl:String, socketPort:uint,callingPage:String,onOpenCallBack_:Function, msgCallBack_:Function=null, 
                              protocol:String='ws', inst:uint=0):void {
       
      this.msgCallBack = msgCallBack_;
      this.onOpenCallBack = onOpenCallBack_;
               
	  this.setDebug(true);
	  
      setCallerUrl(callingPage);
     
      create(inst,protocol+'://'+socketServerUrl+':'+socketPort,['*']);   
      
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