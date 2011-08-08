package org.gamina.api
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import org.gamina.api.logic.*;
	import org.gamina.api.logic.IBasicTrait;
	import org.osflash.signals.*;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.natives.NativeSignal;

	/*
	A convinience class
	*/
	public class AbsSimpleMain extends Sprite
	{
		
		protected var _stageReference:Stage;
		protected var _frameSignal:ISignal;
		protected var _resizeSignal:Signal;
		
		protected var _curSelected:INavTrait;
		
		protected var _traits:Vector.<IBasicTrait>;

		
		public function init(stage_:Stage):void
		{
			_stageReference=stage_;
			
			_stageReference.align=StageAlign.TOP_LEFT;
			_stageReference.scaleMode=StageScaleMode.NO_SCALE;
			_stageReference.quality=StageQuality.MEDIUM;
			_stageReference.frameRate=50;
			
			_resizeSignal = new Signal(uint,uint);
			_stageReference.addEventListener(Event.RESIZE,onResize);
			
			_traits = new Vector.<IBasicTrait>();
			
			_frameSignal = new NativeSignal(_stageReference,Event.ENTER_FRAME);
			_frameSignal.addOnce(doInit2);
			
		}
		
		public function doInit2(evt:Event):void {
			throw new Error('Must implement in concrete Main');
		}
		
		
		public function routeNavCmd(navCmd:BaseInputCMD):void
		{
			throw new Error('Must implement in concrete Main');
		}
		
		public function set selectedWig(sel:INavTrait):void
		{
			_curSelected=sel;
		}
		
		public function showSpinner(duration:uint=666):void
		{
			throw new Error('Must implement in concrete Main');
		}
		
		public function get stageReference():Stage
		{
			return _stageReference;
		}
		
		public function get resizeSignal() : ISignal {
			return _resizeSignal;
		}
		
		
		protected function onResize(evt:Event=null):void {
			
			var w_:uint=_stageReference.stageWidth;
			var h_:uint=_stageReference.stageHeight;
			
			_resizeSignal.dispatch(w_,h_);
		}
		
			
		public function registerTrait(trait:IBasicTrait):void
		{
			_traits.push(trait);
		}
		
		public function getTrait(id:String):IBasicTrait
		{
			var ret:IBasicTrait;
			
			for (var i:uint=0;i<_traits.length;i++) {
				var t:IBasicTrait=_traits[i];
				if(id==t.traitId) {
					ret=t;
					return ret;
				}//fi
			}//for
			
		throw new Error('No trait ' + id);
		
		}//()
	
		
		
	}
}