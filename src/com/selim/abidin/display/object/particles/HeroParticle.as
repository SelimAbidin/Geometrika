package com.selim.abidin.display.object.particles
{
	import com.selim.abidin.display.object.Particle;
	import com.selim.abidin.utils.Config;
	
	import starling.textures.Texture;
	
	public class HeroParticle extends Particle
	{
		public function HeroParticle(texture:Texture)
		{
			super(texture, 20, 22);
			
			
		}
		
		public override function initialize():void
		{
			this.setTexCoordsTo(0, 0,0);
			this.setTexCoordsTo(1, 82 / 1024, 0);
			this.setTexCoordsTo(2, 0, 86 / 1024);
			this.setTexCoordsTo(3, 82 / 1024, 86 / 1024);
			this.life = 400;
		}
		
		
		
		
		
		
		public override function update():void
		{
			super.update();
			this.alpha -= .01  * Config.GLOBAL_SPEED;
			this.rotation += 5 * Config.GLOBAL_SPEED;
		}
		
		
		
		
		public override function reset():void
		{
			super.reset();
			var ang:Number = Math.random() * angleConst;
			this.vx = Math.sin(ang) * 1.5;
			this.vy = Math.cos(ang) * 1.5;
			this.alpha = 1;
			this.life = 400;
			this.isValid = true;
		}
		
		
		
		
		
		
	}
}