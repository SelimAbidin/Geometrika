package com.selim.abidin.display.object.particles
{
	import com.selim.abidin.display.object.Particle;
	import com.selim.abidin.utils.Config;
	
	import starling.textures.Texture;
	
	public class BasicParticle extends Particle
	{
		public function BasicParticle(texture:Texture)
		{
			super(texture, 10, 10);
			
			
			
			
		}
		
		public override function initialize():void
		{
			this.setTexCoordsTo(0,  84 / 1024, 3 / 1024);
			this.setTexCoordsTo(1, 143 / 1024, 3 / 1024);
			this.setTexCoordsTo(2,  84 / 1024, 56 / 1024);
			this.setTexCoordsTo(3, 143 / 1024, 56 / 1024);
			
			
			this.life = 100;
		}
		
		
		public override function update():void
		{
			super.update();
			this.alpha -= .006  * Config.GLOBAL_SPEED;
			this.rotation += 5 * Config.GLOBAL_SPEED;
			this.scaleX += .00012 * Config.GLOBAL_SPEED
			this.scaleY  = this.scaleX;
		}
		
		
		
		
		public override function reset():void
		{
			super.reset();
			var ang:Number = Math.random() * angleConst;
			this.vx = Math.sin(ang) * (Math.random() * 1);
			this.vy = Math.cos(ang) * (Math.random() * 1);
			this.scaleX = 0;
			this.scaleY = 0;
			this.life = 450;
			this.alpha = 1;
			this.isValid = true;
		}
		
		
		
		
	}
}