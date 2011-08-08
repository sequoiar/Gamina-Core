package org.gamina.api.logic
{
	import org.osflash.signals.ISignal;

	//Holds state(model), usualy of the entire screen, ie state of all the traits and the traits widget position's, etc.
	public interface IState
	{
		function get stateChangedSignal():ISignal;
		
		function get state():VTO;
	}
}