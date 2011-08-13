package org.gamina.api.logic
{
	import org.gamina.api.IMainBus;
	import org.gamina.api.IWidget;
	
	/**
	 * The main class of the architecture.
.
	 * All functionality is in these granual behaviors. Ex: Resize, Tween, Navigate, State(Model), etc.
	 * Traits dirrectly manipulate widgets, ie: presenter pattern.
	 * High granularity of traits is perfered over a trait per widget, this will help w/ re-use.
	 * Each trait has only one widget normaly, and a widget has mutiple traits.
	 */
	public interface IBasicTrait
	{
		function initTrait(wig_:IWidget):IBasicTrait;

		// for bus
		function get traitId():String;
		//function get traitType():String;//enum: Nav, State, Layout
		
		function get mainBus():IMainBus;
	
	}
}