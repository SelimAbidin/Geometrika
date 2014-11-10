package com.selim.abidin.display
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.selim.abidin.GeometrikaBase;
	import com.selim.abidin.events.MenuEvents;
	import com.selim.abidin.utils.Config;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchPhase;
	
	public class Menu extends Sprite
	{
		private var start_btn:Button;
		private var menuBanner:Image;
		public function Menu()
		{
			super();
			
			menuBanner = new Image(GeometrikaBase.assetsManager.getTexture("menuBanner"));
			menuBanner.pivotX = menuBanner.width / 2;
			menuBanner.pivotY = menuBanner.height / 2;
			menuBanner.x = Config.stageWidth / 2;
			menuBanner.y = 150;
			menuBanner.width = Config.stageWidth - 20;
			menuBanner.scaleY = menuBanner.scaleX;
			this.addChild(menuBanner);
				
			start_btn = new Button(GeometrikaBase.assetsManager.getTexture("startGame"));
			start_btn.pivotX = start_btn.width / 2;
			start_btn.pivotY = start_btn.height / 2;
			start_btn.scaleY = start_btn.scaleX = menuBanner.scaleX;
			start_btn.x = menuBanner.x;
			start_btn.y = 260;
			
			
			
			this.addChild(start_btn);
			
			
			start_btn.addEventListener(Event.TRIGGERED, onClickStart);
			
		}
		
		private function onClickStart(evt:Event):void
		{
			this.touchable = false;
			TweenMax.to(start_btn, .5, {scaleX:0, scaleY:0, ease:Back.easeIn, delay:.2, onComplete:disappearAnimationComplated});
			TweenMax.to(menuBanner, .5, {scaleX:0, scaleY:0, ease:Back.easeIn});
			
		}
		
		
		private function disappearAnimationComplated():void
		{
			if(this.hasEventListener(MenuEvents.DISAPPEAR_ANIMATION_COMPLATE))
			{
				this.dispatchEvent(new MenuEvents(MenuEvents.DISAPPEAR_ANIMATION_COMPLATE));
			}
		}
		
	}
}