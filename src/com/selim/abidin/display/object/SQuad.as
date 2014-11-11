package com.selim.abidin.display.object
{
	import com.selim.abidin.display.IUpdatable;

	public class SQuad implements IUpdatable
	{
		public var scale:Number = 1;
		public var _x:Number = 0;
		public var _y:Number = 0;
		public var alpha:Number = 1;
		public var rotation:Number = 0;
		public var isValid:Boolean = true;
		public function SQuad()
		{
		}
		
		public function update():void
		{
			
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function set x(val:Number):void
		{
			_x = val;
		}
		
		
		public function get y():Number
		{
			return _y;
		}
		
		public function set y(val:Number):void
		{
			_y = val;
		}
		
		
		
	}
}