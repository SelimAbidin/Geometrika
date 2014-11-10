package com.selim.abidin.display.object
{
	public class FlameQuad extends SQuad
	{
		public function FlameQuad()
		{
			super();
		}
		
		
		
		public override function update():void
		{
			this.y +=2;
			this.scale +=0.1;
			this.rotation +=1;
			this.alpha -=0.1;
			
			if(this.alpha <= 0)
			{
				this.isValid = false;
			}
		}
	}
}