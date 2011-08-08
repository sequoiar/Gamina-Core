package org.gamina.srv {
   import net.gimite.WebSocketEvent;
   import net.gimite.WebSocket;
   
// https://github.com/puppetMaster3/web-socket-js
public class AsWebSock extends WebSocketMain {
   
   protected var msgCallBack:Function;
   protected var onOpenCallBack:Function;
   
   
   public function AsWebSock() {
     super(false);
   }
   
   public function asWs_create(socketServerUrl:String,callingPage:String,onOpenCallBack_:Function, msgCallBack_:Function=null, 
                               socketPort:uint=8787, protocol:String='ws', inst:uint=0):void {
       
      this.msgCallBack = msgCallBack_;
      this.onOpenCallBack = onOpenCallBack_;
               
      super.setCallerUrl(callingPage);
               
      super.create(inst,protocol+'://'+socketServerUrl+':'+socketPort,[protocol]);   
      
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