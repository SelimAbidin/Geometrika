package com.selim.abidin.display.enemies
{
	import com.selim.abidin.display.EnemyProvider;
	import com.selim.abidin.display.IMatchable;
	import com.selim.abidin.display.IUpdatable;
	import com.selim.abidin.display.ParticleProvider;
	import com.selim.abidin.display.object.SQuad;
	import com.selim.abidin.utils.Config;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.Texture;
	
	public class SinusManeuverWing extends Enemy
	{		
		private var  xAci:Number = 0;
		public function SinusManeuverWing(enemyProvider:EnemyProvider, texture:Texture, explodeCallBack:Function, particleLayer:ParticleProvider, param:Object=null)
		{
			super(enemyProvider,particleLayer,texture,explodeCallBack,param);
			this.scorePoint = 15;
			this.particleLayer = particleLayer;
			this.width = 25;
			this.height = 22;
			_effectRange = 12;
			this.setTexCoordsTo(0, 53 / 512 ,0);  // TL
			this.setTexCoordsTo(1, 105 / 512,0);  // TR
			this.setTexCoordsTo(2, 53 / 512, 44 / 512);
			this.setTexCoordsTo(3, 105/ 512, 44 / 512);

			this.pivotX = texture.width / 2;
			this.pivotY = texture.height / 2;
		}
		
		
		
		
		public override function update():void
		{
			this.y += .2 * Config.GLOBAL_SPEED;
			
			this.x =  halfMarginX +  halfScreenX + Math.sin(xAci / 180 * Math.PI) * welleX;
			
			xAci+= .2 * Config.GLOBAL_SPEED;
			
			
			
			if(this.y  > Config.stageHeight + 100)
			{
				this.isValid = false;
			}
			
		}		
		
		
		
		private var halfScreenX:Number;
		private var welleX:Number;
		private var halfMarginX:Number;
		public override function reset(param:Object):void
		{
			this.param = param;
			isValid = true;
			
			halfScreenX = Config.stageWidth * this.param.x;
			halfMarginX = 0//;Config.stageWidth * .05;
			welleX 		= (Config.stageWidth * .45) * param.welle;
			
			if(param.x > 0.5)
			{
				xAci = (360 - ((param.x * 180) + 90)) % 360;
			}
			else
			{
				xAci = (param.x * 180) - 90;
			}
		
			this.x =  halfMarginX +  halfScreenX + Math.sin(xAci / 180 * Math.PI) * halfScreenX;
			
			this.y = -27;
		}
		
		public override function get effectRange():Number
		{
			return _effectRange;
		}
		
		public override function explode():void
		{
			this.isValid = false;
			
			particleLayer.createParticles(80, this.x, this.y,2);
			
			this.explodeCallBack(this);
		}
		
		
		
		
		
		
		
	}
}