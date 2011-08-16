package org.gamina.api.logic
{
	import org.gamina.api.IMainBus;
	import org.gamina.api.IWidget;
	import flash.utils.*;
	
	/**
	 * A convenience class
	 */
	public class AbsTrait 
	{
		
		protected var _bus:IMainBus;
		
		public function AbsTrait(bus_:IMainBus)
		{
			_bus=bus_;
		}
		
		
		public function get mainBus():IMainBus
		{
			return _bus;
		}
	
		public function get traitId():String
		{
			return getQualifiedClassName(this);
		}
	
		public function get traitConcern():String {
			return "NOT_SET";	
		}
	
	}
		
}