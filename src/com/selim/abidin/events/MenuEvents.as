package com.selim.abidin.events
{
	import starling.events.Event;
	
	public class MenuEvents extends Event
	{
		public static var DISAPPEAR_ANIMATION_COMPLATE:String = "disappearAnimationComplated";
		public function MenuEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}