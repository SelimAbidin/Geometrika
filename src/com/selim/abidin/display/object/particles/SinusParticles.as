package com.selim.abidin.display.object.particles
{
	import starling.textures.Texture;
	
	public class SinusParticles extends HeroParticle
	{
		public function SinusParticles(texture:Texture)
		{
			super(texture);
		}
		
		
		public override function initialize():void
		{
			this.setTexCoordsTo(0, 149 / 1024, 3 / 1024);
			this.setTexCoordsTo(1, 222 / 1024, 3 / 1024);
			this.setTexCoordsTo(2, 149 / 1024, 78 / 1024);
			this.setTexCoordsTo(3, 222 / 1024, 78 / 1024);
			this.life = 400;
		}
		
		
		
	}
}