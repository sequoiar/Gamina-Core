package org.gamina.api
{
	import org.gamina.api.logic.*;
	import flash.geom.Point;
	import org.osflash.signals.ISignal;


	
	/**
	 * Widget may have elements, ex: A widget 'monster' has an element 'eye'
	 */
	public interface IWidgetElement
	{
		
		function get rowColPosition():Point;
		function setRowColPosition(col : uint, row : uint) : void 

		//function handleNavCmd(navCmd:BaseInputCMD):void;
		
		/**
		 * When an element is selected, draw the 'highlight border'
		 */
		function select(sel:Boolean):void;
		
		
	}
}