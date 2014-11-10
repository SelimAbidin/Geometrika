package com.selim.abidin.display.enemies
{
	import com.selim.abidin.display.EnemyProvider;
	import com.selim.abidin.display.ParticleProvider;
	import com.selim.abidin.utils.Config;
	
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class DeltaWingWithCannon extends Enemy
	{
	
		
		private var fireCounter:uint = 0;
		public function DeltaWingWithCannon(enemyProvider:EnemyProvider,texture:Texture, explodeCallBack:Function ,particleLayer:ParticleProvider, param:Object=null)
		{
			
			super(enemyProvider,particleLayer, texture,explodeCallBack, param);
			this.scorePoint = 10;
			this.width = 25;
			this.height = 22;
			_effectRange = 12;
			this.setTexCoordsTo(0, 107 / 512, 0);
			this.setTexCoordsTo(1, 158 / 512, 0);
			this.setTexCoordsTo(2, 107 / 512,       44 / 512);
			this.setTexCoordsTo(3, 158 / 512, 44 / 512);

			this.pivotX = texture.width / 2;
			this.pivotY = texture.height / 2;
		}
		
		
		
		
		public override function update():void
		{
			this.y += .2 * Config.GLOBAL_SPEED;
			
			if(this.y  > Config.stageHeight + 100)
			{
				this.isValid = false;		
			}
			
			if(this.y > 0)
			{
				if(fireCounter > fireCounterBorder)
				{
					fireCounter = 0;
					fire();
				}
				fireCounter++;
			}
		}		
		
		private function fire():void
		{
			var mainT:Sprite = enemyProvider.mainTarget;
			var enemy:Enemy = this.enemyProvider.fireOnce(3, {aimX:mainT.x, aimY:mainT.y, x:this.x, y:this.y}) as Enemy;
		}
		
		
		private var fireCounterBorder:uint;
		public override function reset(param:Object):void
		{
			fireCounterBorder = int(40 + (Math.random() * 250));
			fireCounter = 0;
			isValid = true;
			this.x = int(Math.random() * Config.stageWidth);
			this.y = -25;
		}
		
		
		
		public override function get effectRange():Number
		{
			return _effectRange;
		}
		
		
		public override function explode():void
		{
			this.isValid = false;
			particleLayer.createParticles(30, this.x, this.y, 1);
			this.explodeCallBack(this);
		}
		
		
		
		
		
		
		
	}
}