package org.gamina.api.logic
{
	import org.osflash.signals.ISignal;

	/**
	 * For simple apps you should use IBasicTrait
	 */
	public interface ITrait extends IBasicTrait
	{
		/**
		 * Allows you to get all registered traits of concern from the bus. Ex, get me all renderTraits
		 */
		function get traitConcern():String;

		/**
		You mostly talk to traits via signals
		**/	
		function getSignal(id:String):ISignal;
	}
}