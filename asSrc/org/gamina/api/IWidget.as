package org.gamina.api
{
	import org.gamina.api.logic.IBasicTrait;
	
	// a widget could just be a background
	// you can only talk to a widget via it's trait(s)
	// you normaly do UI first (ie widgets w/o traits) to get the look
	/**
	 * Widget is a Passive View pattern. The parent screen/scene should have no/minimal code
	 * The UI is done first, w/o any traits
	 * */
	public interface IWidget
	{
		
		/**
		 * Widget/Panel adds self on 'screen'screen. Positioning/layout is done by it's trait presenter.
		  ie: PassiveView pattern.
		  * Quality ex. HML: L=720p@24 (maybe you do .js if it is that low),M=1080p@30, H=2K@60 - it should depend on detected GPU. If intel 'GPU', just do .js
		  */
		function initWidget(screen_: Object, quality:int=-1):IWidget
			
		
		/**
		 * Add presenter via composition, code is allways: trait.initWig(this);
		 */
		function addTrait(trait : IBasicTrait ) : void;
	
		
		/**
		 * Similar to add Child, add it to display list, if this is a Sprite, or some similar functionality. Must implemnt this to add elements.
		 */
		function elementAdds(el:IWidgetElement):IWidgetElement;
		
		//function get elements():Vector.<IWidgetElement>;// for advanced nav
	
	
	}
}