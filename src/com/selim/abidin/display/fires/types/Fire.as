package com.selim.abidin.display.fires.types
{
	import com.selim.abidin.display.IMatchable;
	import com.selim.abidin.display.object.SQuad;
	
	public class Fire extends SQuad implements IMatchable
	{
		protected var _effectRange:Number = 10;
		public var id:int = Math.floor(Math.random() * 999999);
		public function Fire()
		{
			super();
			
		}
		
		
		public function get effectRange():Number
		{
			return _effectRange;
		}
		
		public function explode():void
		{
			this.isValid = false;
		}
		
		
		
		
	}
}