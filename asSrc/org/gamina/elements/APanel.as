package org.gamina.elements {


   import flash.display.DisplayObject;
   import flash.display.GradientType;
   import flash.display.InterpolationMethod;
   import flash.display.LineScaleMode;
   import flash.display.SpreadMethod;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   import org.gamina.api.*;
   import org.gamina.api.logic.*;

/**
 * Implement a Widget so we can add elements. When using Panel, make sure you set the mask
 */
	public class APanel extends Sprite implements IWidget, IWidgetElement {
	
		public var BACK_COLOR:uint= 0x003366;
		public var BACK_COLOR2:uint= 0x151B54;
		public var COLOR_BORDER:uint= 0XFFFFF0;
		
		public static var  PAD:uint=6;
		
		protected var _mask:Sprite;
		
		/**
		 * The secret part here:
		 */
		public var content:Sprite;
		

		/***
		 * Elements in the panel for  scrolling
		 */
		public var scrollItems:Array;
		

		/**
		 * Similar to Minimal Components. You must re-draw mask
		 */
		public function APanel() {
			this.x=PAD;
			this.y=PAD;
		
			scrollItems = new Array();
			
			_mask = new Sprite();
			_mask.mouseEnabled = false;
			super.addChild(_mask);
			
			content = new Sprite();
			super.addChild(content);
			content.mask = _mask;
			this.drawMask();
		
		}
		
		public function initWidget(screen: Object, quality:int=-1):IWidget {
			throw new Error('must implenent initwig');
		}
		
		public function elementAdds(el:IWidgetElement):IWidgetElement
		{
			this.addChild(DisplayObject(el));
			return el;
		}
		
		

		public function addTrait(trait:IBasicTrait):void
		{
			trait.initTrait(this);
		}
		
		

		public static function placeV(o:DisplayObject, relativeTo:DisplayObject):void {
			o.x=relativeTo.x;
			o.y=relativeTo.y+relativeTo.height+PAD;
		}
		
		public static function placeH(o:DisplayObject, relativeTo:DisplayObject):void {
			o.y=relativeTo.y;
			o.x=relativeTo.x+relativeTo.width+PAD;
		}
		
		public function handleNavCmd(navCmd:BaseInputCMD):void {
			throw new Error('U normaly dont nav a panel');

		}

	

		/**
		 * required to set mask when using Panel. If you draw rectangles it is set for you
		 */
		public  function drawMask(w_:uint=1024,h_:uint=600):void {
			_mask.graphics.clear();
			_mask.graphics.beginFill(0x000000);
			_mask.graphics.drawRect(0, 0, w_,h_);
			_mask.graphics.endFill();
		}
		
		public override function addChild(child:DisplayObject):DisplayObject
		{
			content.addChild(child);
			return child;
			
		}
		
		
		public function drawRectBackground(w_:uint=1024,h_:uint=600):void {
			graphics.clear();
			var box : Matrix = new Matrix();
			box.createGradientBox(w_*.5,h_*.5,0,-w_/8,-h_/8);
			
			graphics.beginGradientFill(GradientType.RADIAL,[BACK_COLOR,BACK_COLOR2],[1,1],[1,255],box,SpreadMethod.REFLECT,InterpolationMethod.RGB);
		    graphics.drawRect(0,0,w_,h_);
			graphics.endFill();
			cacheAsBitmap=true;
			drawMask(w_,h_);
		}

		
		public function drawRoundBackground(w_:uint=1024,h_:uint=600):void {
			graphics.clear();
			var box : Matrix = new Matrix();
			box.createGradientBox(w_*.5,h_*.5,0,-w_/8,-h_/8);
			
			graphics.lineStyle(2, COLOR_BORDER, 0.8, true, LineScaleMode.NONE);
			graphics.beginGradientFill(GradientType.RADIAL,[BACK_COLOR,BACK_COLOR2],[.2,.6],[1,255],box,SpreadMethod.REFLECT,InterpolationMethod.RGB);
			graphics.drawRoundRect(0,0,w_,h_,8,8);
			graphics.endFill();
			cacheAsBitmap=true;
			drawMask(w_,h_);
		}
		
		public function get rowColPosition() : Point {
			return null;
		}

		public function setRowColPosition(col_ : uint, row_ : uint) : void {
			throw new Error('U normaly dont select a panel');

		}

		public function select(sel : Boolean) : void {
			throw new Error('U normaly dont select a panel');
		}
	


  }
}
