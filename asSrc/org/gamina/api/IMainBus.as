package org.gamina.api
{
	
	import flash.display.Stage;
	import flash.events.Event;
	
	import org.gamina.api.logic.*;
	import org.osflash.signals.ISignal;

	// in simple apps, this would be the main sprite, otherwise it's separte from screen
	/**
	* Main purpose is to find traits so they can signal to each other
	*/
	public interface IMainBus
	{
		
		function init(stage_:Stage):void;//get a reference
		function doInit2(evt:Event):void;// on 2nd frame
		
		function get stageReference() : Stage;
		function get resizeSignal() : ISignal;

		function registerTrait(trait:IBasicTrait):void;
		/**
		 * If you want to talk to other widgets, you do so via traits
		 */
		function getTrait(id:String):IBasicTrait;// you normaly talk trait to trait via signals
		
		//advanced 
		function get frameSignal() : ISignal;
		function get entireState():IState;// lets the app be determenistic
		function routeNavCmd(navCmd:BaseInputCMD):void
		function set selectedWig(sel:INavTrait):void
		function showSpinner(duration : uint = 666) : void
	}
}