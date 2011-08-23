package org.gamina.api.logic
{
	import org.osflash.signals.ISignal;

	public interface IConfigurable extends ITrait
	{
		function get configurationChangedSignal():ISignal
	}
}