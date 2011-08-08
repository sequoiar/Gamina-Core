package org.gamina.api
{
	import org.gamina.api.logic.*;
	import flash.geom.Point;
	import org.osflash.signals.ISignal;


	
	public interface IWidgetElement
	{
		
		//function get clickedSignal():ISignal;
		
		function get rowColPosition():Point;
		function setRowColPosition(col : uint, row : uint) : void 

		//function handleNavCmd(navCmd:BaseInputCMD):void;
		
		function select(sel:Boolean):void;
		
		//function reDrawIt():void;
		
		
	}
}