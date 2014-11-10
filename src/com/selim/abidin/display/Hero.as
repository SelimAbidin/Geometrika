package com.selim.abidin.display
{
	import com.greensock.OverwriteManager;
	import com.greensock.TweenMax;
	import com.selim.abidin.GeometrikaBase;
	import com.selim.abidin.controller.ClassicController;
	import com.selim.abidin.display.fires.FireQuadBack;
	import com.selim.abidin.display.fires.types.Fire;
	import com.selim.abidin.events.HeroEvent;
	import com.selim.abidin.utils.Config;
	
	import flash.utils.setTimeout;
	
	import starling.animation.Tween;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.filters.FragmentFilter;
	import starling.filters.GodRaysFilter;
	
	public class Hero extends Sprite implements IUpdatable, IMatchable
	{
		private var image:Image;
		public var globalSpeedEffect:Number;
		private var oldGlobalSpeed:Number;
		private var fireQB:FireQuadBack;
		private var flame:Flame;
		public var isValid:Boolean = true;
		private var _effectRange:Number;
		private var updatables:Vector.<IUpdatable> = new Vector.<IUpdatable>();
		
		public var isExplodable:Boolean = true;
		public function Hero()
		{
			super();
			
			var tl:Sprite = new Sprite(); //  due to starling bug 
			this.addChild(tl);
			tl.x = -200;
			tl.y = -200;
			
			
			var rb:Sprite = new Sprite(); //  due to starling bug
			this.addChild(rb);
			rb.x = 200;
			rb.y = 200;
			
			
			
			image = new Image(GeometrikaBase.assetsManager.getTexture("hero"));
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			this.addChild(image);
			
			
			this.y  =  Config.stageHeight +  image.height;
			this.x = Config.stageWidth / 2;
			
			image.width = 28;
			image.scaleY = image.scaleX;
			
			_effectRange = image.width / 2;
		}
		

		public function init():void
		{
			if(!stage)
			{
				throw new Error("Sahneye eklendikten sonra initialize edilmelidir");
			}
			
			if(!fireQB)
			{
				fireQB = new FireQuadBack(this, image.scaleX);
				(this.parent as DisplayObjectContainer).addChildAt(fireQB, this.parent.getChildIndex(this) - 1);
			}
			
			
			uncontrolable();
			this.y  =  Config.stageHeight +  image.height;
			this.x = Config.stageWidth / 2;
			
			this.isValid = true;
			oldGlobalSpeed = globalSpeedEffect = Config.GLOBAL_SPEED;
			
			TweenMax.to(this, 1, {globalSpeedEffect:-2, onUpdate:globalSpeedBalancer, onComplete:heroGetInScene});
			TweenMax.to(this , .5, {y:Config.stageHeight - 50, delay:1});
		}
		
		private function heroGetInScene():void
		{
			TweenMax.to(this,.3,{globalSpeedEffect:oldGlobalSpeed + 2,onUpdate:globalSpeedBalancer, onComplete:controlable});
			fireJets();
		}		
		
		
		private function controlable():void
		{
			if(this.hasEventListener(HeroEvent.CONTROLABLE))
			{
				this.dispatchEvent(new HeroEvent(HeroEvent.CONTROLABLE));
			}
		}
		
		
		private function uncontrolable():void
		{
			if(this.hasEventListener(HeroEvent.UNCONTROLABLE))
			{
				this.dispatchEvent(new HeroEvent(HeroEvent.UNCONTROLABLE));
			}
		}
		
		
		public function getMatchables():Array
		{
			return [fireQB.aliveBodies];	
		}
		
		
		
	
		private function fireJets():void
		{
			flame = new Flame(this);
			this.addChildAt(flame,0);
			updatables.push(flame);
		}
		
		private function globalSpeedBalancer():void
		{
			Config.GLOBAL_SPEED = globalSpeedEffect;
		}
		
		
		public function update():void
		{
	
			for (var i:int = 0; i < updatables.length; i++) 
			{
				updatables[i].update();
			}
			
			
		}
		
		
		public function startFire():void
		{
			if(updatables.indexOf(fireQB) == -1)
			{
				updatables.push(fireQB);
			}
			
			fireQB.play();
		}
		
		
		
		public function get effectRange():Number
		{
			return _effectRange;
		}
		
		public function explode():void
		{
			if(isExplodable)
			{
				this.isValid = false;
			/*	this.y = Config.stageHeight + 30;
				this.x = Config.stageWidth / 2;
				*/
				flame.clear();
				flame.stop();
				fireQB.stop();
				
				this.dispatchEvent(new HeroEvent(HeroEvent.HERO_DIED));
			}
			
			
		}
		
		
		private var immortalTween:TweenMax;
		public function makeImmoralForAWhile(time:Number):void
		{
			isExplodable = false;
			immortalTween = TweenMax.to(this, .4, {yoyo:true, repeat:100, alpha:.2,  overwrite:OverwriteManager.AUTO});
			setTimeout(makeMortal, time);
		}
		
		public function makeMortal():void
		{
			if(immortalTween)
			{
				immortalTween.kill();
				TweenMax.to(this, .2, {alpha:1,  overwrite:OverwriteManager.AUTO});
			}
			
			isExplodable = true;
		}
		
		
		
		
		public function getX():Number{
			return this.x;
		}
		
		public function getY():Number{
			return this.y;
		}
		
	}
}