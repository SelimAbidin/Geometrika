package com.selim.abidin.controller
{
	import com.selim.abidin.display.Hero;
	import com.selim.abidin.utils.Config;
	
	import flash.display.BitmapData;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class ClassicController extends Sprite
	{
		private var target:Hero;
		public var isDisabled:Boolean = false;
		public function ClassicController(target:Hero, parent:DisplayObjectContainer)
		{
			this.target = target;
			var image:Image = new Image(Texture.fromBitmapData(new BitmapData(2,2,true,0), false));
			this.addChild(image);
			this.width = Config.stageWidth;
			this.height = Config.stageHeight;
			
			this.addEventListener(TouchEvent.TOUCH, onMouseDown);
		}
		
		public function disable(b:Boolean):void
		{
			isDisabled  = b;
			if(isDisabled)
			{
				this.removeEventListener(TouchEvent.TOUCH, onMouseDown);
				this.removeEventListener(Event.ENTER_FRAME, onFrame);
			}
			else
			{
				this.addEventListener(TouchEvent.TOUCH, onMouseDown);
			}
		}
		
		private var mouseX:Number = 0;
		private var mouseY:Number = 0;
		protected function onMouseDown(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this);
			
			if(touch)
			{
				if(touch.phase == TouchPhase.BEGAN)
				{
					this.addEventListener(Event.ENTER_FRAME, onFrame);
				}
				else if(touch.phase == TouchPhase.ENDED)
				{
					this.removeEventListener(Event.ENTER_FRAME, onFrame);
				}
			
				mouseX = touch.globalX;
				mouseY = touch.globalY;
			}
			
			
			//stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		/*protected function onMouseUp(event:MouseEvent):void
		{
			stage.removeEventListener(Event.ENTER_FRAME, onFrame);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);			
		}*/
		
		protected function onFrame(event:Event):void
		{
			if(target.isValid)
			{
				target.x += (mouseX - target.x) / 8;
				target.y += ((mouseY - 60) - target.y) / 8;
			}
		}
	}
}