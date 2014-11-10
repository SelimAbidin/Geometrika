package com.selim.abidin.display.fires.types
{
	
	import com.selim.abidin.utils.Config;
	
	public class ClassicFire extends Fire
	{
		
		public function ClassicFire()
		{
			_effectRange = 10;
			
			super();
		}
		
		public override function update():void
		{
			this.y -= 2 * Config.GLOBAL_SPEED;
			
			if(this.y < 20)
			{
				this.isValid = false;
			}
		}
		
		
		
		
	}
}