package org.gamina.api.logic
{
	import org.osflash.signals.ISignal;
	import org.gamina.api.*;
	
	//remote
	public interface IService 
	{
		//static function get inst():IService;
		
		function get serviceSignal():ISignal;
				
	}
}