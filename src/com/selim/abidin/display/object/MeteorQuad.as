package com.selim.abidin.display.object
{
	import com.selim.abidin.utils.Config;

	public class MeteorQuad extends SQuad
	{
		private var borderY:int;
		public function MeteorQuad()
		{
			borderY = Config.stageHeight + 50;
			super();
		}
		
		
		
		
		public override function update():void
		{
			this.rotation += 0.02;
			this.y += this.scale * Config.GLOBAL_SPEED;
			if(this.y > borderY)
			{
				this.isValid = false;
				
			}
		}
	}
}