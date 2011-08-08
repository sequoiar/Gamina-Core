package org.gamina.elements {
   import de.dev_lab.logging.Logger;
   
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.text.AntiAliasType;
   import flash.text.Font;
   import flash.text.GridFitType;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.getQualifiedClassName;
   
   import org.gamina.api.IWidget;
   import org.gamina.api.IWidgetElement;
   import org.gamina.api.logic.BaseInputCMD;
   import org.osflash.signals.Signal;


	public class AText extends TextField implements IWidgetElement {
		public var dropShadow : DropShadowFilter;
		public var textFormat : TextFormat;
		
		public var FONT_NAME : String = 'Verdana';
		// 'DejaVu Sans';
		public var FONT_SIZE : uint = 24;
		public var COLOR : uint =   0XFFFFF0;
		public var COLOR2 : uint = 0XFFFC17;
		public var COLOR_INPUT : uint = 0x151B54;
		public var COLOR_BORDER:uint= 0XFFFC17;
		
		protected var focusable:Boolean=false;
		
		protected var _colRow:Point;
		
				
		public function initText(parent : IWidget=null, txt : String = 'Blank', locale : String = 'en_US') : AText {
			this.x=APanel.PAD;
			this.y=APanel.PAD;
			
			dropShadow = new DropShadowFilter();
			dropShadow.color = 0x000000;
			dropShadow.distance = 1.75;
			dropShadow.quality = BitmapFilterQuality.MEDIUM;
			dropShadow.strength = 1.25;
			dropShadow.angle = 110;
			dropShadow.blurX = 3;
			dropShadow.blurY = 3;

			textFormat = new TextFormat();
			textFormat.font = FONT_NAME;
			textFormat.color = COLOR;
			textFormat.size = FONT_SIZE;
			textFormat.kerning = true;
			textFormat.letterSpacing = -0.2;
			textFormat.align = TextFormatAlign.LEFT;
			textFormat.bold = true;

			this.selectable=false;
			this.autoSize = TextFieldAutoSize.LEFT;
			this.antiAliasType = AntiAliasType.ADVANCED;
			this.sharpness=200;
			this.gridFitType = GridFitType.SUBPIXEL;
			// this.embedFonts = true;

			this.defaultTextFormat = textFormat;
			this.setTextFormat(textFormat);

			this.filters = [dropShadow];

			this.text = txt;
			if(parent)
				parent.elementAdds(this);
			
			this.addEventListener(FocusEvent.FOCUS_IN,onFocus,false,0,true);
			this.addEventListener(FocusEvent.FOCUS_OUT,onLostFocus,false,0,true);
			
	
			return this;
		}
	

		public function handleNavCmd(navCmd:BaseInputCMD):void {
			if(navCmd.cmdEnum!=BaseInputCMD.OTHER_CHAR)
				return ;
			this.text = this.text+navCmd.char;

		}
		
		protected function onFocus(fevt:FocusEvent):void {
			select(true);
		}
		
		protected function onLostFocus(fevt:FocusEvent):void {
			select(false);
		}
		
		public function setToInputMode():void {
			this.focusable=true;
			this.selectable=true;
			this.borderColor=COLOR_BORDER;
			this.textColor = COLOR_INPUT;
			this.autoSize = TextFieldAutoSize.NONE;
			this.width=204;
			this.height=32
			this.background=true;
			
			this.type=TextFieldType.INPUT;
			
		}
		
		public function deleteLastChar():void {
			text = text.substr(0,text.length-1);
		}
		
		public function resetFormat() : void {
			setTextFormat(textFormat);
		}

		public static function enumFonts() : void {
			var embeddedFonts : Array = Font.enumerateFonts(false);
			embeddedFonts.sortOn("fontName", Array.CASEINSENSITIVE);
			
		for (var i : int = 0; i < embeddedFonts.length; i++) {
				Logger.debug(embeddedFonts[i].fontName,'Text', 'enumFonts');
			}
		}//()

		public  function get className():String {
			return getQualifiedClassName(this)+text+_colRow.x+'/'+_colRow.y;
		}

		public function select(sel : Boolean) : void {
			if(focusable)
				border=sel;
		}

		public function get rowColPosition() : Point {
			if(!_colRow)
				throw new Error('Col/Row not Set');
			return _colRow;
		}
		
		public function setRowColPosition(col : uint, row : uint) : void {
			_colRow = new Point(col,row);
		}
		
	}//class
}