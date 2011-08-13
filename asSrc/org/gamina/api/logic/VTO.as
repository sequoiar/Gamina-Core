package org.gamina.api.logic {
   import com.adobe.serialization.json.JSON;
   
   import de.dev_lab.logging.Logger;
	

	
	/**
	 * Value transfer object.
	 * In some case, when it is not the state, you may want to pool VTO. 
	 * aka DTO, Bean, NameValuePairs, Value Object
	 */
	public class VTO 
	{
		protected var rawData:Object
		
		public function VTO() {
			clear();
		}
		
		/**
		 * Type of message or class (ex: state), needed for websocket
		 */
		public function initByType(type_:String):VTO {
			rawData = new Object();
			rawData['type']=type_
			return this;
		}
		
		public function initByJSON(json:String):VTO {
			try{
			var j:Object=JSON.decode(json);
			} catch (e:Error) {
				Logger.error(json,'VTOs','initByJSON');
				return null;
			}
			clone(j);
			
			if((String(rawData['type']).length)<2) 
				throw new Error ('VTO JSON not decoded');
			return this;
		}

	
		protected function clone(original:Object):void {
			rawData = new Object();
			for(var key:String in original) {
				rawData[key] = original[key];
			}

		}
		
		public function get ttype():String {
			return rawData['type'];
		}
		
		
		/**
		 * Send in NVP, name value pairs
		 */
		public function initByObject(obj:Object):VTO {
			clear()
			for(var key:String in obj) {
				rawData[key] = obj[key];
			}
			return this;
		}

		

		public function clear():void {
			rawData = new Object();
		}
		
		public function  getKeys():Vector.<String>
		{
			var keys_:Vector.<String> = new Vector.<String>();
			for(var k:String in rawData) {
				keys_.push(k);
			}
			return keys_;
		}
		
		public function get(key:String):String
		{
			return rawData[key];
		}
		
		public function set(key:String, value:Object):void
		{
				if(!rawData) clear();
				rawData[key]=value;
		}
		
		public function toJSON():String
		{
			var j:String =JSON.encode(rawData)
			return j
		}
		
		public function toString():String {
			return toJSON();
		}
		
	}//class
}