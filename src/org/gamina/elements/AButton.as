package org.gamina.elements {
   import org.gamina.api.IWidget;
   import org.gamina.api.IWidgetElement;
   import org.gamina.api.logic.BaseInputCMD;
   import org.osflash.signals.natives.NativeSignal;
   import org.osflash.signals.ISignal;

   import flash.display.GradientType;
   import flash.display.InterpolationMethod;
   import flash.display.LineScaleMode;
   import flash.display.SpreadMethod;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;

	public class AButton extends Sprite implements IWidgetElement {
		public var recWidth : Number = 130;
		public  var recHeight : Number = 28;
		
		public var COLOR : uint =   0xFFFFFF;
		public var COLOR2 : uint = 0x000000;

		public var ROUND:uint=7;
		public var COLOR_BORDER:uint= 0XFFFC17;
		
		protected var _colRow:Point;

		
		/**
		 * Listen to this for mouse events in presenter
		 */
		private var _clickedSignal:NativeSignal;
		
		public function drawIt():void {}
		/**
		 * Only if you want the simple button(rarely). If using TextButton use initTextButton
		 */
		protected function initButtonElement(parent : IWidget) : AButton {
			this.x=APanel.PAD;
			this.y=APanel.PAD;
			
			if(parent )
				parent.elementAdds(this);
			select(false);
			
			_clickedSignal = new NativeSignal(this,MouseEvent.MOUSE_DOWN);
			
			return this;
		}
		
		public function handleNavCmd(navCmd:BaseInputCMD):void {
			_clickedSignal.dispatch(new MouseEvent(MouseEvent.MOUSE_DOWN));
			
		}
		
		public function get clickedSignal():ISignal {
			return _clickedSignal;
		}


		
		private function drawDeselected() : void {
			graphics.clear();
			var box : Matrix = new Matrix();
			box.createGradientBox(recWidth * .90, recHeight * .50, Math.PI / 2);

			graphics.lineStyle(1, COLOR_BORDER, 0.4, true, LineScaleMode.NONE);
			graphics.beginGradientFill(GradientType.LINEAR, [COLOR, COLOR2], [1, 1], [1, 255], box, SpreadMethod.PAD, InterpolationMethod.LINEAR_RGB, -0.39);

			graphics.drawRoundRect(0, 0, recWidth, recHeight, ROUND, ROUND);

			graphics.endFill();
			box = null;
		}

		private function drawSelected() : void {
			graphics.clear();
			var box : Matrix = new Matrix();
			box.createGradientBox(recWidth * 2, recHeight, Math.PI / 2, -recWidth * .5, -recHeight * .1);

			graphics.lineStyle(2, 0x000000, 1, true, LineScaleMode.NONE);
			graphics.beginGradientFill(GradientType.RADIAL, [COLOR, COLOR2], [1, 1], [1, 255], box, SpreadMethod.PAD, InterpolationMethod.LINEAR_RGB, -0.39);
			graphics.drawRoundRect(0, 0, recWidth, recHeight, ROUND, ROUND);

			graphics.endFill();
			box = null;
		}


		public function select(sel : Boolean) : void {
			if(sel)
				drawSelected();
			else
				drawDeselected();
		}

		public function get rowColPosition() : Point {
			return _colRow;
		}
		
		public function setRowColPosition(col : uint, row : uint) : void {
			_colRow = new Point(col,row);
		}
		
		
	}
}


	

		