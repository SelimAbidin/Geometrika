package com.selim.abidin.display.object
{
	import com.selim.abidin.utils.Config;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class Particle extends Image
	{
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var gravity:Number = 0;
		public var life:Number = 100;
		public var isValid:Boolean = true;
		public static var angleConst:Number = 2 * Math.PI;
		public function Particle(texture:Texture, wid:Number, heg:Number)
		{
			super(texture);
			
			this.width = wid;
			this.height = heg;
			
		
			this.pivotX = texture.width / 2;
			this.pivotY = texture.height / 2;
		}
		
		
		public function initialize():void
		{
			
		}
		
		
		
		public function update():void
		{
			vy += gravity;
			this.x += vx *  Config.GLOBAL_SPEED;
			this.y += vy *  Config.GLOBAL_SPEED;
			this.life -= 1 * Config.GLOBAL_SPEED; 
			if(this.life < 0)isValid = false;
			
			
		}
		
		
		
		
		public function reset():void
		{
			isValid = true;
		}
		
		
		protected function checkBounds():Boolean
		{
			if(this.x > Config.stageWidth + 30)
			{
				return false;
			}
			else if(this.x <  -30)
			{
				return false;
			}
			else if(this.y  < -30)
			{
				return false;
			}
			else if(this.y > Config.stageHeight + 30)
			{
				return false;
			}
			return true;
		}		
		
		
		
		
	}
}