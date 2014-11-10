package com.selim.abidin.events
{
	import starling.events.Event;
	
	public class HeroEvent extends Event
	{
		public static var CONTROLABLE:String  ="controlable";
		public static var UNCONTROLABLE:String  ="uncontrolable";
		public static var HERO_DIED:String = "heroDied";
		public function HeroEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}