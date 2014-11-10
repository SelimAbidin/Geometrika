package com.selim.abidin.display.enemies
{
	import com.selim.abidin.display.EnemyProvider;
	import com.selim.abidin.display.IMatchable;
	import com.selim.abidin.display.IUpdatable;
	import com.selim.abidin.display.ParticleProvider;
	import com.selim.abidin.display.object.SQuad;
	import com.selim.abidin.utils.Config;
	
	import starling.textures.Texture;
	
	public class DeltaWing extends Enemy
	{
	
		
		public function DeltaWing(enemyProvider:EnemyProvider,texture:Texture, explodeCallBack:Function ,particleLayer:ParticleProvider, param:Object=null)
		{
			
			super(enemyProvider,particleLayer,texture,explodeCallBack, param);
			
			this.scorePoint = 10;
			this.width = 25;
			this.height = 22;
			_effectRange = 12;
			this.setTexCoordsTo(0, 0,0);
			this.setTexCoordsTo(1, 50 / 512,0);
			this.setTexCoordsTo(2, 0, 44 / 512);
			this.setTexCoordsTo(3, 50 / 512, 44 / 512);

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
			
		}		
		
		public override function reset(param:Object):void
		{
			isValid = true;
			this.x = Math.random() * Config.stageWidth;
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