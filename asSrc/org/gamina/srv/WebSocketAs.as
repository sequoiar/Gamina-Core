// Copyright: Hiroshi Ichikawa <http://gimite.net/en/>


package org.gamina.srv {

import flash.display.Sprite;
import flash.system.Security;
import flash.utils.setTimeout;

import mx.utils.URLUtil;

import net.gimite.websocket.*;

/**
  * Provides ActionscriptScript Wrapper for WebSocket.
  */
public class WebSocketAs extends Sprite implements IWebSocketLogger{
  
  private var callerUrl:String;
  private var debug:Boolean = false;
  private var manualPolicyFileLoaded:Boolean = false;
  //** very important, this need to be protected, not private:
  protected var webSockets:Array = [];
  private var eventQueue:Array = [];
  

  
  public function setCallerUrl(url:String):void {
    callerUrl = url;
  }
  
  public function setDebug(val:Boolean):void {
    debug = val;
  }
  
  private function loadDefaultPolicyFile(wsUrl:String):void {
	if (manualPolicyFileLoaded) return;
		
    var policyUrl:String = "xmlsocket://" + URLUtil.getServerName(wsUrl) + ":843";
    log("policy file: " + policyUrl);
    Security.loadPolicyFile(policyUrl);
  }
  
  public function loadManualPolicyFile(policyUrl:String):void {
    log("policy file: " + policyUrl);
    Security.loadPolicyFile(policyUrl);
    manualPolicyFileLoaded = true;
  }
  
  public function log(message:String):void {
    if (debug) {
      trace("WebSocketAs.log:",  message);
    }
  }
  
  public function error(message:String):void {
    trace("WebSocketAs.error:",  message);
  }
  
  private function parseEvent(event:WebSocketEvent):Object {
    var webSocket:WebSocket = event.target as WebSocket;
    var eventObj:Object = {};
    eventObj.type = event.type;
    eventObj.webSocketId = webSocket.getId();
    eventObj.readyState = webSocket.getReadyState();
    eventObj.protocol = webSocket.getAcceptedProtocol();
    if (event.message !== null) {
      eventObj.message = event.message;
    }
    return eventObj;
  }
  
  public function create(
      webSocketId:int,
      url:String, protocols:Array,
      proxyHost:String = null, proxyPort:int = 0,
      headers:String = null):void {
	
	  loadDefaultPolicyFile(url);
  
    var newSocket:WebSocket = new WebSocket(
        webSocketId, url, protocols, getOrigin(), proxyHost, proxyPort,
        getCookie(url), headers, this);
    newSocket.addEventListener("open", onSocketEvent);
    newSocket.addEventListener("close", onSocketEvent);
    newSocket.addEventListener("error", onSocketEvent);
    newSocket.addEventListener("message", onSocketEvent);
    webSockets[webSocketId] = newSocket;
  }
  
  public function send(webSocketId:int, encData:String):int {
    var webSocket:WebSocket = webSockets[webSocketId];
    return webSocket.send(encData);
  }
  
  public function close(webSocketId:int):void {
    var webSocket:WebSocket = webSockets[webSocketId];
    webSocket.close();
  }
  
  protected function receiveEvents():Object {
    var result:Object = eventQueue;
    eventQueue = [];
    return result;
  }
  
  private function getOrigin():String {
    return (URLUtil.getProtocol(this.callerUrl) + "://" +
      URLUtil.getServerNameWithPort(this.callerUrl)).toLowerCase();
  }
  
  [Deprecated]
  private function getCookie(url:String):String {
  	/*if (URLUtil.getServerName(url).toLowerCase() ==
        URLUtil.getServerName(this.callerUrl).toLowerCase()) {
      return ExternalInterface.call("function(){return document.cookie}");
    } else*/ 
      return "";
    
  }
  
  /**
   * Socket event handler.
   */
  protected function onSocketEvent(event:WebSocketEvent):void {
    var eventObj:Object = parseEvent(event);
    eventQueue.push(eventObj);
    processEvents();
  }
  
  /**
   * Process our event queue.  If server is unresponsive, set
   * a timeout and try again.
   */
  protected function processEvents():void {
    if (eventQueue.length == 0) return;
    setTimeout(processEvents, 500);
  }//()  
  
}//class

}//pack
