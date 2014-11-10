package com.selim.abidin.display.enemies
{
	import com.selim.abidin.display.EnemyProvider;
	import com.selim.abidin.display.IMatchable;
	import com.selim.abidin.display.IUpdatable;
	import com.selim.abidin.display.ParticleProvider;
	import com.selim.abidin.display.object.SQuad;
	import com.selim.abidin.utils.Config;
	
	import starling.textures.Texture;
	
	public class BasicEnemyFire extends Enemy
	{
	
		
		private var vx:Number = 0;
		private var vy:Number = 0;
		public function BasicEnemyFire(enemyProvider:EnemyProvider,texture:Texture, explodeCallBack:Function ,particleLayer:ParticleProvider, param:Object=null)
		{
			super(enemyProvider,particleLayer,texture,explodeCallBack, param);
			this.isShotable = false;
			this.scorePoint = 0;
			this.width = 8;
			this.height = 8;
			_effectRange = 3;
			this.setTexCoordsTo(0, 0,49 / 512);  // Left Top
			this.setTexCoordsTo(1, 25 / 512,49 / 512); // Right Top
			this.setTexCoordsTo(2, 0, 75 / 512); //  Left Bot
			this.setTexCoordsTo(3, 25 / 512, 75 / 512); // Right Bot

			this.pivotX = texture.width / 2;
			this.pivotY = texture.height / 2;
		}
		
		
		
		
		public override function update():void
		{
			//this.x += vx * Config.GLOBAL_SPEED;
			param.y += vy * Config.GLOBAL_SPEED;
			this.y = param.y;
			
			param.x +=  vx * Config.GLOBAL_SPEED;
			this.x = param.x;
			
			if(this.y  > Config.stageHeight + 20)
			{
				this.isValid = false;		
			}
			
		}		
		
		public override function reset(param:Object):void
		{
			this.param = param;
			isValid = true;
			
			var dx:Number = param.aimX - param.x;
			var dy:Number = param.aimY - param.y;
			
			var rad:Number = Math.atan2(dy, dx);
			
			
			vx = Math.cos(rad) * .5;
			vy = Math.sin(rad) * .5;
			this.x = 0;
			this.y = -25;
		}
		
		
		
		public override function get effectRange():Number
		{
			return _effectRange;
		}
		
		public override function explode():void
		{
			return;
		}
		
		
		
		
		
		
		
	}
}