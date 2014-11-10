package com.selim.abidin.utils
{
	import com.selim.abidin.display.enemies.Enemy;

	public class Config
	{
		public function Config()
		{
		}
		
		
		// 1=IOS, 2= Android, 3=Web or Desktop
		/*
		1=IOS, 2= Android, 3=Web or Desktop
		 * */
		public static var SystemType:uint = 1;
		
		public static var stageWidth:Number = 320;
		public static var stageHeight:Number = 480;
		
		public static var GLOBAL_SPEED:Number = 3;
		public static var score:int = 0;;
		
		
	}
}