package org.gamina.elements {
   import org.gamina.api.IWidget;
   import org.gamina.api.IWidgetElement;
   import flash.utils.getQualifiedClassName;

	public class ATextButton extends AButton implements IWidgetElement {
		public var text : AText;

		public var HMID:int=10//middle offset
		
		public function initTextButton(parent : IWidget, txt : String = 'Blank', locale : String = 'en_US') : ATextButton {
			
			super.initButtonElement(parent);
			text = new AText();
			text.initText(null, txt, locale);
			addChild(text);
			layout();
			return this;
		}

		public function layout() : void {
			var txtMiddle : uint = text.textWidth / 2;
			var butMiddle : uint = width / 2;
			text.x = butMiddle - txtMiddle-HMID;

			var txtHMiddle : uint = text.textHeight / 2;
			var butHMiddle : uint = height / 2;
			text.y = txtHMiddle - butHMiddle;
		}

		public  function get className():String {
			return getQualifiedClassName(this)+text.text+_colRow.x+'/'+_colRow.y;
		}

		
	

	}
}